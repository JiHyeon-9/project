<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String url = "jdbc:mysql://localhost:3306/project";
String dbId = "cye";
String dbPass = "pwpw12211234*";
Connection conn = null; 
PreparedStatement pstmt = null;
try{
	String id = request.getParameter("id");
	String password = request.getParameter("password");

	Class.forName("com.mysql.cj.jdbc.Driver");
	conn =  DriverManager.getConnection(url, dbId, dbPass);

	String sql = "delete from signup where id = ? and password = ? ";
	pstmt = conn.prepareStatement(sql); 
	pstmt.setString(1, id);
	pstmt.setString(2, password);
	pstmt.executeUpdate();
	
	session.removeAttribute("id");
	session.removeAttribute("password");

	out.println("회원탈퇴 되어쓰");
} catch(Exception e){
    out.print(e);
} finally {
if (pstmt != null) pstmt.close();
if(conn!= null) conn.close();
}
%>