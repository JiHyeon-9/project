<%@ page import="java.sql.*"%>
<%@ include file="db.jsp"%>
<%
request.setCharacterEncoding("UTF-8");

// 세션에서 user_id(id) 가져오기
Integer userId = (Integer) session.getAttribute("id");
String content = request.getParameter("content");

if (userId != null && content != null && !content.trim().isEmpty()) {

	// 댓글 등록 쿼리
	String sql = "INSERT INTO comments (user_id, content) VALUES (?, ?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, userId);
	pstmt.setString(2, content);
	pstmt.executeUpdate();
	pstmt.close();
}

conn.close();
response.sendRedirect("ranking.jsp"); // 댓글 작성 후 리다이렉트
%>
