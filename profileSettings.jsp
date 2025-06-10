<%@ page import="java.sql.*, java.nio.file.Paths, javax.servlet.http.Part" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userid = (String) session.getAttribute("id");
    if (userid == null) {
        response.sendRedirect("loginForm.jsp"); // 로그인 안 된 경우
        return;
    }
    // MultipartRequest 생성
    String uploadPath = application.getRealPath("/uploads");
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdir();

    if (request.getMethod().equalsIgnoreCase("POST")) {
    MultipartRequest multi = new MultipartRequest(
        request,
        uploadPath,
        10 * 1024 * 1024,  // 10MB
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
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

        if (ext.equals("jpg") || ext.equals("png") || ext.equals("gif")) {
            // 이미지일 경우만 세션에 저장
            session.setAttribute("photo", fileName);
        } else {
            // 이미지 아님 → 삭제 처리
            file.delete();
            fileName = "";
        }
    }

 
    java.sql.Connection conn = null;
    java.sql.PreparedStatement pstmt = null;

    try {
        String url = "jdbc:mysql://localhost:3306/profile"; // DB명 맞게 변경
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
            // 세션 값 업데이트
            session.setAttribute("nickname", nickname);
            session.setAttribute("password", password);

            out.println("<script>alert('프로필 수정 완료'); location.href='profile.jsp';</script>");
        }
        else {
            out.println("<script>alert('프로필 수정 실패'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
    }
%>