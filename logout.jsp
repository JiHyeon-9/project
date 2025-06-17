<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate();
Cookie[] cookies = request.getCookies();
if (cookies != null){
	for (Cookie cookie : cookies){
		if("id".equals(cookie.getName())){
			cookie.setMaxAge(0);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
	}
}

response.sendRedirect("mainpage.jsp");
%>