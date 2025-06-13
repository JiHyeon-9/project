<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설정</title>
    <style>
    /*유저 db에 정보 변경,회원 탈퇴기능, process.jsp 미구현*/
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
    		padding: 20px 30px 20px 30px;
    		min-width: 420px;
    		min-height: 220px;
    		box-sizing: border-box;
    		display: flex;
    		flex-direction: column;
    		justify-content: center;
    		align-items: center;
		}.Box_form {
    		display: flex;
    		flex-direction: row;
    		gap: 24px;
		}.set_input {
    		display: flex;
    		flex-direction: column;
    		gap: 12px;
    		width: 220px;
		}.set_input input {
    		padding: 8px 8px;
    		border: 2px solid;
    		border-radius: 2px;
    		outline: none;
    		width: 100%;
    		box-sizing: border-box;
		}.set_button {
    		display: flex;
    		flex-direction: column;
    		gap: 24px;
    		justify-content: flex-start;
    		width: 110px ;
		}.set_button button {
    		padding: 8px 0;
    		border: 2px solid;
    		font-weight: bold;
    		cursor: pointer;
    		border-radius: 2px;
    		width: 100%;
    		font-size: 1rem;
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
        <form class="Box_form" action="process.jsp" method="post">
            <div class="set_input">
            	<input type="text" id="nickname" name="nickname" placeholder= "변경할 닉네임" required>
                <input type="text" id="id" name="id" placeholder= "변경할 아이디" required>
                <input type="password" id="password" name="password" placeholder= "변경할 비밀번호" required>
                <input type="password" id="password" name="password" placeholder= "현재 비밀번호" required>
            </div>
            <div class="set_button">
                <button type="submit" name="btn" value="  ">정보변경</button>
                <button type="button" name="btn" value="  " formnovalidate>회원 탈퇴</button>
            </div>
        </form>
        <div class="option_link">
            <a href="mainpage.jsp">로그인으로 돌아가기</a>
        </div>
	</div>
	
</body>
</html>