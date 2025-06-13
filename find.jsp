<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>아이디/비밀번호 찾기</title>
    <style>
    /*입력한 값으로 유저db에서 찾는 기능 미구현*/
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
        }
    </style>
</head>
<body>
    <div class="Box">
        <div class="Box_title">아이디/비밀번호 찾기</div>
        <form class="Box_form" action=" " method="post">
            <input type="text" name="name" placeholder="회원이름" required>
            <input type="text" name="nickname" placeholder="닉네임" required>
            <button type="submit">정보 조회</button>
        </form>
        <div class="option_link">
            <a href="mainpage.jsp">로그인으로 돌아가기</a>
        </div>
    </div>
</body>
</html>
