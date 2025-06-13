<%@ page import="java.sql.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

String userid = (String) session.getAttribute("id");
if (userid == null) {
    response.sendRedirect("mainpage.jsp");
    return;
}

String uploadPath = application.getRealPath("/uploads");
File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) uploadDir.mkdir();

if (request.getMethod().equalsIgnoreCase("POST")) {
    MultipartRequest multi = new MultipartRequest(
        request,
        uploadPath,
        10 * 1024 * 1024,
        "UTF-8",
        new DefaultFileRenamePolicy()
    );

    String nickname = multi.getParameter("nickname");
    String password = multi.getParameter("password");

    // 파일 업로드 처리
    String fileName = "";
    File file = multi.getFile("userProfile");
    if (file != null) {
        fileName = file.getName();
        int dotIndex = fileName.lastIndexOf(".");
        if (dotIndex != -1) {
            String ext = fileName.substring(dotIndex + 1).toLowerCase();
            if (ext.equals("jpg") || ext.equals("png") || ext.equals("gif")) {
                session.setAttribute("photo", fileName);
            } else {
                file.delete();
                fileName = "";
            }
        }
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String url = "jdbc:mysql://localhost:3306/profile";
        String dbId = "root";
        String dbPass = "0929";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbId, dbPass);

        String sql = "UPDATE signup SET password = ?, nickname = ? WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, password);
        pstmt.setString(2, nickname);
        pstmt.setString(3, userid);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 성공 시 세션 값도 갱신
            session.setAttribute("nickname", nickname);
            session.setAttribute("password", password);

            out.println("<script>alert('프로필 수정 완료'); location.href='info.jsp';</script>");
        } else {
            out.println("<script>alert('프로필 수정 실패'); location.href='info.jsp';</script>");
        }

    } catch (Exception e) {
        String msg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "오류";
        out.println("<script>alert('오류 발생: " + msg + "'); location.href='profile.jsp';</script>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
}
%>
