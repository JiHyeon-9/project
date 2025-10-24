<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="sign" class="project.Signup" />
<jsp:setProperty property="*" name="sign" />
<%@ include file="db.jsp"%>
<%


String autologin= request.getParameter("autologin");
try {
   
   String sql = "Select * from signup where id = ?"; //password는 일부로 보안 문제 때문에 안 함
   
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1, sign.getId());
   
   rs = pstmt.executeQuery();
   
   if (!rs.next()){
      %>
      <script>
          alert('존재하지 않는 아이디입니다1.');
          location.href='mainpage.jsp';
      </script>
      <%
          return;
      }
   if (!rs.getString("password").equals(sign.getPassword())){
         %>
         <script>
             alert('비밀번호가 일치하지 않습니다.');
             location.href='mainpage.jsp';
         </script>
         <%
             return;
         }
   
   session.setAttribute("id", rs.getString("id"));
   session.setAttribute("password", rs.getString("password"));
   session.setAttribute("nickname", rs.getString("nickname"));
   session.setAttribute("message", rs.getString("message"));
   
   if("true".equals(autologin)){
      Cookie login = new Cookie("id", rs.getString("id"));
      login.setMaxAge(60*60*24*7);
      login.setPath("/");
      response.addCookie(login);
   }

   response.sendRedirect("loginstart.jsp"); //게임화면으로 돌아가야 함
   
} catch (Exception e){
   e.printStackTrace();
   out.print("로그인 실패" + e);
   
} finally {
   if (conn!=null) conn.close();
   if (pstmt!=null) pstmt.close();
   if (rs !=null) rs.close();
}
%>