<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="sign" class="project.Signup" />
<jsp:setProperty property="*" name="sign" />

<%
String url = "jdbc:mysql://localhost:3306/profile";
String dbId = "root";
String dbPass = "0929";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	conn = DriverManager.getConnection(url, dbId, dbPass);
	String sql = "Select * from signup where id = ?"; //password는 일부로 보안 문제 때문에 안 함
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, sign.getId());
	
	rs = pstmt.executeQuery();
	
	if (!rs.next()){
		%>
		<script>
		    alert('존재하지 않는 아이디입니다.');
		    location.href='loginForm.jsp';
		</script>
		<%
		    return;
		}
	if (!rs.getString("password").equals(sign.getPassword())){
			%>
			<script>
			    alert('비밀번호가 일치하지 않습니다.');
			    location.href='loginForm.jsp';
			</script>
			<%
			    return;
			}
	
	session.setAttribute("id", rs.getString("id"));
	session.setAttribute("nickname", rs.getString("nickname"));
	
	response.sendRedirect("info.jsp");
	
	
} catch (Exception e){
	e.printStackTrace();
	out.print("로그인 실패" + e);
	
} finally {
	if (conn!=null) conn.close();
	if (pstmt!=null) pstmt.close();
	if (rs !=null) rs.close();
}

%>