package controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet("/toolkit-download")
public class ToolkitDownloadController extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // File name
        String fileName = "RSAToolkit.exe";
        // File path
        String filePath = "/assets/" + fileName;

        // Get FileInputStream object to identify the path
        ServletContext servletContext = getServletContext();
        String fileTruePath = servletContext.getRealPath(filePath);
        System.out.println(fileTruePath);
        File file = new File(fileTruePath);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Set the content type and header of the response.
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition",
                "attachment; filename=\"" + fileName + "\"");
        response.setContentLengthLong(file.length());

        FileInputStream inputStream = new FileInputStream(file);

        // Loop through the document and write into the
        // output.
        OutputStream outputStream = response.getOutputStream();
        int in;
        while ((in = inputStream.read()) != -1) {
            outputStream.write(in);
        }

        // Close FileInputStream and PrintWriter object
        inputStream.close();
        outputStream.flush();
    }
}
