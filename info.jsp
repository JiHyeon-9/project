<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%
String imagePath = "upload/https://maked.kr/common/img/default_profile.png";
File uploaded = new File(application.getRealPath("/") + "upload/profile.jpg");
if (uploaded.exists()) {
    imagePath = "upload/profile.jpg";
} else {
    imagePath = "null";
}

//저장된 부분
String savedId = (String)session.getAttribute("userid");
String savedNickname = (String)session.getAttribute("nickname");
String savedPassword = (String)session.getAttribute("password");
//String savedMessage = (String)session.getAttribute("message");

//String savedLv = (String)session.getAttribute("Lv");
//String savedExp = (String)session.getAttribute("exp");

if (savedId == null || savedId.trim().equals("")) {
    //response.sendRedirect("loginForm.jsp");
}
else if (savedNickname == null || savedNickname.trim().equals("")) {
    //response.sendRedirect("loginForm.jsp");
}
else if (savedPassword == null || savedPassword.trim().equals("")) {
    //response.sendRedirect("loginForm.jsp");
    out.print("aa");
}
//else {
    //if (savedMessage == null) savedMessage = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 설정</title>
<style>
    .profile-container { width: 500px; margin: 50px auto; border: 2px solid; padding: 20px;}
    .profile-picture { text-align: center; margin-bottom: 15px; }
    .profile-picture img { width: 100px; height: 100px; border-radius: 50%; }
    .form-group { margin-bottom: 15px; }
    .form-group input[type="text"] { width: 100%; padding: 10px; font-size: 14px;
        border: 1px solid #ccc; border-radius: 6px; }
    .btn-save, .btn-delete-photo {
        background-color: #7da51e; color: white; padding: 10px 20px; border: none;}
    .btn-delete-photo { background-color: #b5b5b5; float: right; }
    .btn-back { position: absolute; top: 10px; left: 10px; font-size: 24px; cursor: pointer; border: none; background: none;}
</style>

<script>
    let formChanged = false;

    // 정보 변경 감지
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('input[type="text"], input[type="password"], input[type="file"]');
        inputs.forEach(function(input) {
            input.addEventListener('change', function() {
                formChanged = true;
            });
        });
    });

    // 페이지 벗어나기 경고
    window.onbeforeunload = function() {
        if (formChanged) {
            return '변경 사항이 저장되지 않을 수 있습니다. 계속하시겠습니까?';
        }
    };

    // 저장 버튼 클릭 시 경고 해제
    function clearUnloadWarning() {
        window.onbeforeunload = null;
    }

    // 뒤로가기 버튼
    function goBack() {
        history.back();
    }
</script>
</head>
<body>
	<div class="profile-container">
	<button type="button" class="btn-back" onclick="goBack()">←</button>
		    <h2>프로필 설정</h2>
		    <form action="saveProfile.jsp" method="post" enctype="multipart/form-data">
		    <div class="profile-picture">
		        <img src="<%= imagePath %>" alt="프로필 사진">
		        <br /><br />
		        <input type="file" name="photo">
		    </div>
		    <div class="form-group">
		        <p>아이디</p>
		        <input type="text" name="id" value="<%= savedId %>" />
		        <p>닉네임</p>
		        <input type="text" name="nickname" value="<%= savedNickname %>" />
		        <p>비밀번호</p>
		        <input type="text" name="password" value="<%= savedPassword %>" />
		        <p>상태 메시지</p>
		        
		    </div>
		<button type="submit" class="btn-save">저장</button>
	</form>
	    <form action="deletePhoto.jsp" method="post" style="margin-top: 10px">
	        <button type="submit" class="btn-delete-photo">삭제</button>
	    </div>
	</form>
</body>
</html>
<%
//}
%>