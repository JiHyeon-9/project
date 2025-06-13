<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String nickname = request.getParameter("nickname");

String url = "jdbc:mysql://localhost:3306/project";
String dbId = "cye";
String dbPass = "pwpw12211234*";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, dbId, dbPass);
	
	String sql = "select id from signup where nickname=?";
	pstmt=conn.prepareStatement(sql);
	
	pstmt.setString(1, nickname);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		String userid = rs.getString("id");
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
