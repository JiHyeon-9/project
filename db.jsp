<%@ page import="java.sql.*"%>
<%
String dbUrl = "jdbc:mysql://localhost:3306/profile";
String dbUser = "root";
String dbPassword = "0929";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
} catch (Exception e) {
	out.println("tlfvo: " + e.getMessage());
}
%>