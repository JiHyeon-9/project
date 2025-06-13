package project;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class userProfileSurvelt extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 업로드할 디렉토리 경로 설정 (서버 경로에 맞게 수정)
        String uploadPath = getServletContext().getRealPath("/uploads");

        // 디렉토리 없으면 생성
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // 업로드 최대 크기 설정 (10MB 예시)
        int maxSize = 10 * 1024 * 1024;

        try {
            // cos.jar의 MultipartRequest 사용
            MultipartRequest multi = new MultipartRequest(
                    request,
                    uploadPath,
                    maxSize,
                    "UTF-8",
                    new DefaultFileRenamePolicy()
            );

            // 업로드된 파일명 가져오기
            String fileName = multi.getFilesystemName("photo");

            // 응답 출력
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            if (fileName != null) {
                out.println("<h2>업로드 성공!</h2>");
                out.println("<p>파일명: " + fileName + "</p>");
                out.println("<img src='uploads/" + fileName + "' style='max-width: 300px;'>");
            } else {
                out.println("<h2>업로드 실패</h2>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<h2>오류 발생: " + e.getMessage() + "</h2>");
        }
    }
}

