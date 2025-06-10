<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String url = "jdbc:mysql://localhost:3306/profile";
String dbId = "root";
String dbPass = "0929";
Connection conn = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver"); // 최신 드라이버
    conn = DriverManager.getConnection(url, dbId, dbPass);
    out.print("커넥션 성공");
} catch(Exception e){
    out.print("오류: " + e.getMessage());
} finally {
    if(conn != null) conn.close();
}
%>

