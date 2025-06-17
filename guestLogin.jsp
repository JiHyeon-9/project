<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.UUID" %>
<%@ include file="db.jsp"%>
<%
String guestid = (String) session.getAttribute("guestid");
try {
	
	boolean exists; //기본값 false
	do{ 
		guestid = "guest_" + UUID.randomUUID().toString().substring(0, 8); //uuid 쓴 이유는 중복 안 되고 쉽게 만들어서, 난수 id 새로 생성
		
		pstmt = conn.prepareStatement("select guestid from guest where guestid = ?"); //게스트 테이블에 방금 만든 아이디가 중복되나?
		pstmt.setString(1, guestid); // ?에 guestid 삽입 
		rs = pstmt.executeQuery(); //sql 실행 후 rs에 값 넣어서 다시 가져옴
		exists = rs.next(); //rs가 가져온 결과에 중복이 있으면 exists가 true고, 없으면 false
		
		rs.close(); 
		pstmt.close();
	} while (exists); //true면 중복 id가 있는 거니까 false가 나올 때까지 반복
	
	
	pstmt = conn.prepareStatement("insert into guest (guestid, sessionid) values (?, ?)");
	pstmt.setString(1, guestid);
	pstmt.setString(2, session.getId()); //getid는 session 내장객체로 jsp에서 알아서 고유 id 생성
	//sessionid가 있는 이유는 세션이랑 db랑 연결할라고 guestid만 잇으면 삭제가 좀 귀찮음 
	//근데 세션id는 어차피 시간 지나면 지 알아서 없어짐
	
	pstmt.executeUpdate(); //sql 실행
	session.setAttribute("guestid", guestid); //저장
	
	out.print(guestid + " 님, 안녕하세요!");
}catch(Exception e){
    out.print(e);
} finally {
if (pstmt != null) pstmt.close();
if(conn!= null) conn.close();
if(rs!=null) rs.close();
}
%>