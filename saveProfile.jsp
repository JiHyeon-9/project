<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 입력값 받기
    String id = request.getParameter("id");
    String nickname = request.getParameter("nickname");
    String password = request.getParameter("password");
    String message = request.getParameter("message");
    
    // 세션에 저장
    session.setAttribute("id", id);
    session.setAttribute("nickname", nickname);
    session.setAttribute("password", password);
    session.setAttribute("message", message);

    try {

        String sql = "INSERT INTO signup (id, nickname, password, message, photo) VALUES (?, ?, ?, ?, ?)";

        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, id);
        pstmt.setString(2, nickname);
        pstmt.setString(3, password);
        pstmt.setString(4, message);

        // 프로필 사진 처리 (세션에서 가져옴)
        String photo = (String) session.getAttribute("photo");
        pstmt.setString(5, photo != null ? photo : "");

        int result = pstmt.executeUpdate();

        if (result > 0) {  // 저장 성공
        	response.sendRedirect("info.jsp");
            return;
        }
        else {  // 저장 실패
            out.println("<script>alert('프로필 저장 실패'); history.back();</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('에러 발생: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
