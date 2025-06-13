package project;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class userProfileSurvelt extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ���ε��� ���丮 ��� ���� (���� ��ο� �°� ����)
        String uploadPath = getServletContext().getRealPath("/uploads");

        // ���丮 ������ ����
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // ���ε� �ִ� ũ�� ���� (10MB ����)
        int maxSize = 10 * 1024 * 1024;

        try {
            // cos.jar�� MultipartRequest ���
            MultipartRequest multi = new MultipartRequest(
                    request,
                    uploadPath,
                    maxSize,
                    "UTF-8",
                    new DefaultFileRenamePolicy()
            );

            // ���ε�� ���ϸ� ��������
            String fileName = multi.getFilesystemName("photo");

            // ���� ���
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            if (fileName != null) {
                out.println("<h2>���ε� ����!</h2>");
                out.println("<p>���ϸ�: " + fileName + "</p>");
                out.println("<img src='uploads/" + fileName + "' style='max-width: 300px;'>");
            } else {
                out.println("<h2>���ε� ����</h2>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<h2>���� �߻�: " + e.getMessage() + "</h2>");
        }
    }
}

