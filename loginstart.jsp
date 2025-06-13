<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>Add commentMore actions
<%@ page import="project.Singup","project.dinosaur_db" %> 
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
</head>
<body>
	<%
		String nickname = request.getParameter("nickname");
		String scoer = request.getParameter("scoer");
	%>
    <div class="Box">
        <div class="Box_title">환영합니다,<%= project.getnickname()  %> </div>
        <div class="Box_rank">내 최고 점수,<%= project.getscoer() %> </div>
        <div class="start_button_row">
            <div class="start_button">
                <button onclick="location.href='(이곳을 게임실행.jsp로 수정)'">GAME START</button>
            </div>
        </div>
        <div class="logout_link">
            <a href="logout.jsp">로그아웃</a>
        </div>
    </div>
    <div class="buttons">
        <button class="sidebuttons" onclick="location.href='ranking.jsp'">랭킹</button>
        <button class="sidebuttons" onclick="location.href='settings.jsp'">설정</button>
    </div>
</body>
</html>