package project;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.DriverManager;
import java.sql.Connection;

@WebServlet("/saveProfileServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,     // 1MB
    maxFileSize = 1024 * 1024 * 5,       // 5MB
    maxRequestSize = 1024 * 1024 * 10    // 10MB
)
public class saveProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");
        String statusMessage = request.getParameter("message");
        String photo = request.getParameter("photo");

        session.setAttribute("nickname", nickname);
        session.setAttribute("password", password);
        session.setAttribute("message", statusMessage);
        session.setAttribute("photo", photo);

        try {
            String url = "jdbc:mysql://localhost:3306";
            String dbId = "root";
            String dbPass = "0929";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, dbId, dbPass);
            // ... DB 작업 수행 ...
            conn.close();
        } catch (Exception e) {
            e.printStackTrace(); // 또는 로깅
        }

        // 파일 업로드 처리
        Part filePart = request.getPart("photo");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("/upload");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + fileName);
            session.setAttribute("photo", fileName);
        }

        response.sendRedirect("profile.jsp");
    }
}

