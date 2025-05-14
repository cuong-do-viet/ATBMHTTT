package DAO;

import model.Notification;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {
    private Connection conn;

    public NotificationDAO() {}

    public NotificationDAO(Connection conn) {
        this.conn = conn;
    }

    // Lấy danh sách thông báo theo username
    public List<Notification> getNotificationsByUsername(String username) throws SQLException {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE username = ? ORDER BY created_at DESC";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Notification n = new Notification(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("title"),
                            rs.getString("message"),
                            rs.getTimestamp("created_at"),
                            rs.getBoolean("is_read")
                    );
                    list.add(n);
                }
            }
        }
        return list;
    }

    // Thêm mới một thông báo
    public void addNotification(Notification notification) throws SQLException {
        String sql = "INSERT INTO notifications (username, title, message) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, notification.getUsername());
            stmt.setString(2, notification.getTitle());
            stmt.setString(3, notification.getMessage());
            stmt.executeUpdate();
        }
    }

    // Đánh dấu thông báo là đã đọc
    public void markAsRead(int notificationId) throws SQLException {
        String sql = "UPDATE notifications SET is_read = TRUE WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, notificationId);
            stmt.executeUpdate();
        }
    }

    // Xóa thông báo
    public void deleteNotification(int notificationId) throws SQLException {
        String sql = "DELETE FROM notifications WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, notificationId);
            stmt.executeUpdate();
        }
    }
}


