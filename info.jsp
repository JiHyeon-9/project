<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ include file="db.jsp"%>
<%
request.setCharacterEncoding("UTF-8");

// 기본 프로필 이미지 경로
String defaultImagePath = "https://maked.kr/common/img/default_profile.png";
String imagePath = defaultImagePath;

// 업로드된 프로필 사진이 있으면 경로 변경
File uploaded = new File(application.getRealPath("/upload/profile.jpg"));
if (uploaded.exists()) {
    imagePath = "upload/profile.jpg";
}

// 세션 값 불러오기
String savedId = (String)session.getAttribute("id");
String savedNickname = (String)session.getAttribute("nickname");
String savedPassword = (String)session.getAttribute("password");
String savedMessage = (String)session.getAttribute("message");
String savedLv = (String)session.getAttribute("level");
String savedExp = (String)session.getAttribute("exp");

// 로그인 체크
if (savedId == null || savedId.trim().equals("")) {
    response.sendRedirect("mainpage.jsp");
} else if (savedNickname == null || savedNickname.trim().equals("")) {
   response.sendRedirect("mainpage.jsp");
   
} else if (savedPassword == null || savedPassword.trim().equals("")) {
  	response.sendRedirect("mainpage.jsp");
	
} else {
    if (savedMessage == null) savedMessage = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 설정</title>
<style>
    body {
        margin: 0; padding: 0; height: 100vh; width: 100vw;
        display: flex; justify-content: center; align-items: center;
    }
    .Box { border: 3px solid; padding: 20px 50px 10px 50px; min-width: 420px; min-height: 220px; box-sizing: border-box; }
    .profile-picture { text-align:center; margin-bottom:10px; }
    .login_input { display: flex; flex-direction: column; gap: 10px; min-width: 130px; }
    .login_input input { padding: 6px 6px; border: 2px solid; border-radius: 2px; outline: none; }
    .button-row { display: flex; gap:180px;  margin-top: 10px;align-items: center;}
    .btn-save { margin-top: 10px; padding: 8px 18px; border: 2px solid; font-weight: bold; cursor: pointer; border-radius: 2px; }
    .btn-delete { margin-top: 10px; padding: 8px 18px; border: 2px solid; font-weight: bold; cursor: pointer; border-radius: 2px; }
</style>
<script>
function previewImages(event) {
    const files = event.target.files;
    const preview = document.getElementById('preview');
    preview.innerHTML = '';

    if (files.length === 0) return;

    const container = document.createElement('div');
    container.style.display = 'grid';
    container.style.gridTemplateColumns = 'repeat(3, 1fr)';
    container.style.gap = '10px';

    Array.from(files).forEach((file) => {
        if (!file.type.startsWith('image/')) return;
        const reader = new FileReader();
        reader.onload = function(e) {
            const img = document.createElement('img');
            img.src = e.target.result;
            img.style.width = '100%';
            img.style.height = '100px';
            img.style.objectFit = 'cover';
            img.style.border = '1px solid #ccc';
            img.style.borderRadius = '6px';
            container.appendChild(img);
        };
        reader.readAsDataURL(file);
    });

    preview.appendChild(container);
}

function previewProfileImage(event) {
    const file = event.target.files[0];
    if (!file || !file.type.startsWith('image/')) return;   

    const reader = new FileReader();
    reader.onload = function(e) {
        document.getElementById('currentProfile').src = e.target.result;
    };
    reader.readAsDataURL(file);
}

function goBack() {
    history.back();
}
</script>
</head>
<body>
    <div class="Box">
        <button type="button" class="btn-back" onclick="goBack()">←</button>
        <h2>프로필 설정</h2>
        <form action="profileSettings.jsp" method="post" enctype="multipart/form-data">
    		<div class="profile-picture">
        	<img id="currentProfile" src="<%= imagePath %>" alt="프로필 사진"
             	style="width:120px;height:120px;border-radius:60px;border:1px solid #aaa;">
        		<br /><br />
        	<input type="file" name="userProfile" accept="image/*" onchange="previewProfileImage(event)">
        	<div id="preview" style="margin-top:10px;"></div>
    		</div>
    		
    		<div class="login_input">
        	<div>아이디</div>
		        <input type="text" name="id" value="<%= savedId %>" required readonly/>
		        <div>닉네임</div>
		        <input type="text" name="nickname" value="<%= savedNickname %>" required/>
		        <div>비밀번호</div>
		        <input type="text" name="password" value="<%= savedPassword %>" required/>
		        <div>상태 메시지</div>
		        <input type="text" name="message" value="<%= savedMessage %>" />
		    </div>
		    
    		<div class="button-row">
    			<form action="profileSettings.jsp" method="post">
		        	<button type="submit" class="btn-save">저장</button>
		        </form>
		        <form action="deleteform.jsp" method="post">
		            <button type="delete" class="btn-delete">회원탈퇴</button>
		        </form>
        	</div>
		</form>
    </div>
</body>
</html>
<%
}
%>