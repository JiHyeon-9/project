<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session.getAttribute("userid") == null) { //세션에서 꺼내온 userid가 null이면
	out.print("로그인 안 됨");
} else {
	out.print((String) session.getAttribute("userid")); //잇으면 보여 주삼
}
%>