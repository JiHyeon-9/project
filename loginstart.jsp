<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="db.jsp"%> 
<!DOCTYPE html>
<html>
<head>
    <style>
    
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            width: 100vw;
            display: flex;
            justify-content: center;
            align-items: center;
        }.Box {
            border: 3px solid;
            padding: 20px 50px 30px 50px;
            min-width: 420px;
            min-height: 180px;
            box-sizing: border-box;
            background: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }.Box_title {
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 25px;
        }.Box_rank{
             margin: 10px ;
        }.start_button_row {
            display: flex;
            justify-content: flex-end;
        }.start_button button {
            width: 80px;
            height: 80px;
            border: 2px solid;
            font-weight: bold;
            font-size: 1.05rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }.buttons {
            position: fixed;
            right: 30px;
            bottom: 40px;
            display: flex;
            flex-direction: column;
            gap: 18px;
            z-index: 100;
        }.sidebuttons {
            min-width: 80px;
            padding: 12px 18px;
            border: 2px solid;
            font-weight: bold;
            cursor: pointer;
        }.logout_link {
            text-align: center;
            color: #000;
            margin-top: 12px;
        }.logout_link a {
            color: #000;
            margin: 0 5px;
        }
    </style>
    <%--화면에 로그인한 유저의 최고점수 표시를 위해 추가했습니다. --%>
    <%
		String id = (String)session.getAttribute("id");
		String nickname = (String)session.getAttribute("nickname");

		int bestScore = 0; 

		if (id != null) {
    		String sql = "SELECT MAX(score) AS best_score FROM scores WHERE user_id = (SELECT user_id FROM signup WHERE id = ?)";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, id);
    		rs = pstmt.executeQuery();
    	  if (rs.next()) {
        	  bestScore = rs.getInt("best_score");
    	  }
    	rs.close();
    	pstmt.close();
    	conn.close();
		}
	%>
</head>
<body>
	
    <div class="Box">
        <div class="Box_title">환영합니다, <%= nickname %> 님. </div>
        <div class="Box_rank"> <%= nickname %> 님의 최고 점수는 <%= bestScore %> 점입니다. </div>
        <div class="start_button_row">
            <div class="start_button">
                <button onclick="location.href='index.html'">GAME START</button>
            </div>
        </div>
        <div class="logout_link">
            <a href="logout.jsp">로그아웃</a>
        </div>
    </div>
</body>
</html>