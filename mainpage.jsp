<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <style>/*아직 db에서 회원정보 읽어서 로그인 성공,실패 기능 미구현, process.jsp 미구현*/
       /*로그인 박스*/
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
            padding: 20px 50px 10px 50px;
            min-width: 420px;
            min-height: 220px;
            box-sizing: border-box;
      }.Box_title {
            text-align: center;
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 25px;
        }.Box_form {
            display: flex;
            gap: 10px;
        }.login_input {
            display: flex;
            flex-direction: column;
            gap: 12px;
            min-width: 220px;
        }.login_input input {
            padding: 8px 8px;
            border: 2px solid;
            border-radius: 2px;
            outline: none;
        }.login_button {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }.login_button button {
            padding: 8px 18px;
            border: 2px solid;
            font-weight: bold;
            cursor: pointer;
            border-radius: 2px;
        }.guest_button {
            margin-top: 1px;
        }.option_link {
            text-align: center;
            color: #000;
            margin-top: 12px;
        }.option_link a {
            color: #000;
            margin: 0 5px;
        }
        
        /* 랭킹, 설정 버튼 */
        .buttons {
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
            border: 2px solid ;
            font-weight: bold;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="Box">
        <div class="Box_title">회원 로그인</div>
        <form class="Box_form" action="login.jsp" method="post">
            <div class="login_input">
                <input type="text" id="id" name="id" placeholder= "아이디" required>
                <input type="password" id="password" name="password" placeholder= "비밀번호" required>
           <label>
    <input type="checkbox" name="autologin" value="true" checked> 자동 로그인
         </label>
            </div>
            <div class="login_button">
                <button type="submit" name="btn" value="login">로그인</button>
                <button type="button" class="guest_button" 
                name="btn" value="guest" onclick="location.href='gueststart.jsp'" formnovalidate>게스트 로그인</button>
            </div>
        </form>
        <div class="option_link">
            <a href="idfind.jsp">아이디 찾기</a> | 
            <a href="pwfind.jsp">비밀번호 찾기</a> | 
            <a href="register.jsp">회원가입</a>
        </div>
    </div>
    <div class="buttons">
        <button class="sidebuttons" onclick="location.href='ranking.jsp'">랭킹</button>
        <button class="sidebuttons" onclick="location.href='settings.jsp'">설정</button>
    </div>
</body>
</html>