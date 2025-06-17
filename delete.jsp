<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp"%>
<%
try{
	String id = request.getParameter("id");
	String password = request.getParameter("password");

	String sql = "delete from signup where id = ? and password = ? ";
	pstmt = conn.prepareStatement(sql); 
	pstmt.setString(1, id);
	pstmt.setString(2, password);
	pstmt.executeUpdate();
	
	session.removeAttribute("id");
	session.removeAttribute("password");
	
	Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie cookie : cookies){
            if("id".equals(cookie.getName())){
                cookie.setMaxAge(0);   // 쿠키 만료
                cookie.setPath("/");   // 경로 지정(생성할 때와 동일해야 함)
                response.addCookie(cookie);
            }
        }
    }
    %>
    <script>
    alert('회원탈퇴 되었습니다.');
    </script>
<%

	response.sendRedirect("mainpage.jsp");
} catch(Exception e){
    out.print(e);
} finally {
if (pstmt != null) pstmt.close();
if(conn!= null) conn.close();
}
%>
