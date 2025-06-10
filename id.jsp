<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String nickname = request.getParameter("nickname");

String url = "jdbc:mysql://localhost:3306/profile";
String dbId = "root";
String dbPass = "0929";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, dbId, dbPass);
	
	String sql = "select userid from signup where nickname=?";
	pstmt=conn.prepareStatement(sql);
	
	pstmt.setString(1, nickname);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		String userid = rs.getString("userid");
		out.print("사용자 id: "+ userid);
	} else {
		out.print("아이디가 존재하지 않습니다.");
	}
}

	
catch(Exception e){
    out.print(e);
} finally {
if (pstmt != null) pstmt.close();
if(conn!= null) conn.close();
if(rs!=null) rs.close();
}
%>
