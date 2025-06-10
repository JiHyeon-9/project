<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate(); //세션 자체를 삭제
out.print("로그아웃 되었습니다.");
%>