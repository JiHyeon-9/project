<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String userid = request.getParameter("userid");

String url = "jdbc:mysql://localhost:3306/project";
String dbId = "cye";
String dbPass = "pwpw12211234*";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, dbId, dbPass);
	
	String sql = "select pw from signup where userid=?";
	pstmt=conn.prepareStatement(sql);
	
	pstmt.setString(1, userid);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		String pw = rs.getString("pw");
		out.print("사용자 pw: "+ pw);
	} else {
		out.print("비밀번호가 존재하지 않습니다.");
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
