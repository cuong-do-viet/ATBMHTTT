package controller;

import DAO.NotificationDAO;
import model.Notification;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/notification")
public class NotificationController extends HttpServlet {
    private NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        User userLogging = (User) session.getAttribute("userLogging");

        if (userLogging == null) {
            resp.getWriter().write("<div style='text-align: center; padding: 20px; color: #666;'><p>Vui lòng đăng nhập để xem thông báo</p></div>");
            return;
        }

        if ("getNotifications".equals(action)) {
            handleGetNotifications(req, resp, userLogging);
        } else if ("markAsRead".equals(action)) {
            handleMarkAsRead(req, resp);
        } else if ("deleteNotification".equals(action)) {
            handleDeleteNotification(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User userLogging = (User) session.getAttribute("userLogging");

        if (userLogging == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.getWriter().write("{\"success\": false, \"error\": \"Bạn chưa đăng nhập.\"}");
            return;
        }
        handleReportLostKey(req, resp, userLogging);
    }


    private void handleReportLostKey(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        String reason = req.getParameter("reason");

        String adminEmail = "huynguyen7013@gmail.com";
        String subject = "Yêu cầu báo mất khóa từ " + user.getName();
        String content = "Người dùng: " + user.getName() + "\n"
                + "Email: " + user.getEmail() + "\n"
                + "Lý do báo mất khóa:\n" + reason;

        IJavaMail mailService = new JavaMailImpl();

        boolean sent = mailService.send(adminEmail, subject, content);

        if (sent) {
            resp.getWriter().write("{\"success\": true}");
        } else {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\": false, \"error\": \"Lỗi khi gửi email.\"}");
        }
    }


    private void handleGetNotifications(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        try {
            List<Notification> notifications = notificationDAO.getNotificationsByUsername(user.getName());
            PrintWriter out = resp.getWriter();

            if (notifications.isEmpty()) {
                out.write("<div class='notification-item' style='padding: 20px; text-align: center; color: #666;'>");
                out.write("<p style='margin: 0;'>Không có thông báo mới</p>");
                out.write("</div>");
            } else {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

                for (Notification notification : notifications) {
                    String readClass = notification.isRead() ? "" : "unread";
                    String backgroundColor = notification.isRead() ? "#f8f9fa" : "#e3f2fd";

                    out.write("<div class='notification-item " + readClass + "' data-id='" + notification.getId() + "' ");
                    out.write("style='padding: 15px; border-bottom: 1px solid #eee; background-color: " + backgroundColor + "; cursor: pointer;' ");
                    out.write("onclick='markNotificationAsRead(" + notification.getId() + ")'>");

                    out.write("<div style='display: flex; justify-content: space-between; align-items: start;'>");
                    out.write("<div style='flex: 1;'>");
                    out.write("<h6 style='margin: 0; font-weight: 500; color: #333;'>" + escapeHtml(notification.getTitle()) + "</h6>");
                    out.write("<p style='margin: 5px 0 0 0; color: #666; font-size: 14px;'>" + escapeHtml(notification.getMessage()) + "</p>");
                    out.write("</div>");

                    out.write("<div style='display: flex; flex-direction: column; align-items: end; margin-left: 10px;'>");
                    out.write("<small style='color: #999; white-space: nowrap;'>" + sdf.format(notification.getCreatedAt()) + "</small>");

                    if (!notification.isRead()) {
                        out.write("<span style='width: 8px; height: 8px; background-color: #007bff; border-radius: 50%; margin-top: 5px;'></span>");
                    }

                    out.write("<button onclick='deleteNotification(event, " + notification.getId() + ")' ");
                    out.write("style='border: none; background: none; color: #dc3545; cursor: pointer; font-size: 12px; margin-top: 5px;' ");
                    out.write("title='Xóa thông báo'>×</button>");
                    out.write("</div>");

                    out.write("</div>");
                    out.write("</div>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.getWriter().write("<div style='text-align: center; padding: 20px; color: #dc3545;'><p>Lỗi khi tải thông báo. Vui lòng thử lại sau.</p></div>");
        }
    }

    private void handleMarkAsRead(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int notificationId = Integer.parseInt(req.getParameter("id"));
            notificationDAO.markAsRead(notificationId);
            resp.getWriter().write("{\"success\": true}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }

    private void handleDeleteNotification(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int notificationId = Integer.parseInt(req.getParameter("id"));
            notificationDAO.deleteNotification(notificationId);
            resp.getWriter().write("{\"success\": true}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }

    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
