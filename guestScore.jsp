<%@ page import="java.sql.*, java.lang.Math" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Game Over</title>
</head>
<body>
	<%
	String scoreParam = request.getParameter("score");
	int intscore = Integer.parseInt(scoreParam);
	int userId = 1; // 실제 로그인 사용자 ID로 바꿔야 함

	// 1. 사용자 정보 불러오기
	String sql = "SELECT level, exp FROM guest WHERE guest_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, userId);
	rs = pstmt.executeQuery();

	int level = 1;
	int exp = 0;

	if (rs.next()) {
		level = rs.getInt("level");
		exp = rs.getInt("exp");
	}
	rs.close();
	pstmt.close();

	// 2. 경험치 계산
	exp += intscore / 100;

	int neededExp = (int) Math.pow(2, level);
	while (exp >= neededExp) {
		exp -= neededExp;
		level++;
		neededExp = (int) Math.pow(2, level);
	}

	// 3. DB 업데이트
	String updateSql = "UPDATE guest SET level = ?, exp = ? WHERE guest_id = ?";
	PreparedStatement updateStmt = conn.prepareStatement(updateSql);
	updateStmt.setInt(1, level);
	updateStmt.setInt(2, exp);
	updateStmt.setInt(3, userId);
	updateStmt.executeUpdate();
	%>
	
	<h2>Game Over!</h2>
	<p>
		내 점수:
		<%=intscore%></p>
	<p>
		현재 레벨:
		<%=level%></p>
	<p>
		현재 EXP:
		<%=exp%>
		/
		<%=neededExp%>
	</p>
	<p>
		<button onclick="location.href='index.html'">다시하기</button>
		<button onclick="location.href='gueststart.jsp'">메인화면</button>	</p>
	<%
	rs.close();
	pstmt.close();
	conn.close();
	%>
</body>
</html>