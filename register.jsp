<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
    <style>
    /*유저 db에 정보 업로드 기능 미구현*/
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
        }.Box_form {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }.Box_form input {
            padding: 8px 8px;
            border: 2px solid;
            border-radius: 2px;
            outline: none;
            width: 100%;
            box-sizing: border-box;
        }.Box_form button {
            padding: 8px 18px;
            border: 2px solid;
            font-weight: bold;
            cursor: pointer;
            border-radius: 2px;
            margin-top: 10px;
            width: 100%;
        }.option_link {
            text-align: center;
            color: #000;
            margin-top: 12px;
        }.option_link a {
            color: #000;
            margin: 0 5px;
        }.complete {
            text-align: center;
            font-weight: bold;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="Box">
        <%
        //입력값이 모두 있으면 완료 메시지 출력
        String nickname = request.getParameter("nickname");
        String userid = request.getParameter("id");
        String password = request.getParameter("password");
        if (nickname != null && userid != null && password != null &&
            !nickname.isEmpty() && !userid.isEmpty() && !password.isEmpty()) {
        %>
            <div class="complete">회원가입이 완료되었습니다!</div>
            <div class="option_link">
                <a href="mainpage.jsp">로그인으로 돌아가기</a>
            </div> 
        <%
        } else {
        %>
        <form class="Box_form" action="signup.jsp" method="post">
            <input type="text" name="nickname" placeholder="닉네임" required>
            <input type="text" name="id" placeholder="아이디" required>
            <input type="password" name="password" placeholder="비밀번호" required>
            <button type="submit">회원가입</button>
            <div class="option_link">
                <a href="mainpage.jsp">로그인으로 돌아가기</a></div>
        </form>
        <%
        }
        %>
    </div>
</body>
</html>
