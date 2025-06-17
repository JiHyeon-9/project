<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="db.jsp"%>
<%
String userid = request.getParameter("id");
String nickname = request.getParameter("nickname");


try {
		
	String sql = "select password from signup where id=? and nickname=? ";
	pstmt=conn.prepareStatement(sql);
	
	pstmt.setString(1, userid);
	pstmt.setString(2, nickname);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		String pw = rs.getString("password");
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
