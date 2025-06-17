<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="db.jsp"%>


<style>
body {
	margin-top:10px;
	margin: 0;
	padding: 40px 0;
	height: 100vh;
	width: 100vw;
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #f5f5f5;
	font-family: sans-serif;
}

.ranking-container {
	border: 3px solid;
	padding: 30px 50px;
	min-width: 800px;
	min-height: 600px;
	box-sizing: border-box;
	background: #fff;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.ranking-container h2 {
	font-size: 1.8rem;
	font-weight: bold;
	margin-bottom: 25px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	padding: 12px;
	border: 2px solid #000;
	text-align: center;
	font-size: 1rem;
}

th {
	background-color: #eee;
	font-weight: bold;
}

button {
	border: 2px solid #000;
	padding: 6px 12px;
	font-weight: bold;
	cursor: pointer;
	background-color: #fff;
}

.comment-box {
	display: none;
	padding: 10px 15px;
	border: 2px solid #aaa;
	background-color: #f9f9f9;
	margin-top: 10px;
	width: 100%;
	box-sizing: border-box;
	text-align: left;
}

.comment-box ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.comment-box li {
	margin-bottom: 8px;
	font-size: 0.95rem;
}

.comment-box em {
	color: #999;
}
.top-right-button {
	position: fixed;
	top: 20px;
	right: 30px;
	z-index: 999;
}

.top-right-button button {
	border: 2px solid #000;
	background-color: #fff;
	font-weight: bold;
	padding: 8px 14px;
	cursor: pointer;
	border-radius: 5px;
	font-size: 0.95rem;
}

</style>

<div class="top-right-button">
	<button onclick="location.href='mainpage.jsp'">메인으로</button>
</div>
<div class="ranking-container">
	<h2>랭킹 TOP 10</h2>
	<table>
		<tr>
			<th>순위</th>
			<th>닉네임</th>
			<th>레벨</th>
			<th>최고점수</th>
			<th>댓글</th>
		</tr>
		<%
		String sql = "SELECT p.user_id, id, level, p.nickname, MAX(s.score) AS best_score "
				+ "FROM scores s JOIN signup p ON p.user_id = s.user_id "
				+ "GROUP BY s.user_id ORDER BY best_score DESC LIMIT 10";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();

		int rank = 1;
		while (rs.next()) {
			int uid = rs.getInt("user_id");
			String id = rs.getString("id");
			String nick = rs.getString("nickname");
			int level = rs.getInt("level");
			int score = rs.getInt("best_score");
		%>
		<tr>
	<td><%= rank++ %></td>
	<td><%= nick %></td>
	<td><%= level %></td>
	<td><%= score %></td>
	<td>
		<button onclick="toggleComments('<%= uid %>')">+ 댓글</button>
	</td>
</tr>
<tr>
	<td colspan="5" style="padding: 0;">
		<div id="commentBox_<%= uid %>" class="comment-box">
			<ul>
				<%
				String csql = "SELECT c.content, p.nickname, c.created_at " +
				              "FROM comments c JOIN signup p ON c.user_id = p.user_id " +
				              "WHERE c.user_id = ?";
				PreparedStatement cpstmt = conn.prepareStatement(csql);
				cpstmt.setInt(1, uid);
				ResultSet crs = cpstmt.executeQuery();
				
				boolean hasComments = false;
				while (crs.next()) {
				    hasComments = true;
				    String ccontent = crs.getString("content");
				    String cnick = crs.getString("nickname");
				    Timestamp ctime = crs.getTimestamp("created_at");
				%>
				<li><strong><%= cnick %></strong>: <%= ccontent %> 
					<small>(<%= ctime %>)</small>
				</li>
				<%
				}
				if (!hasComments) {
				%>
				<li><em>댓글 없음</em></li>
				<%
				}
				crs.close();
				cpstmt.close();
				%>
			</ul>
		</div>
	</td>
</tr>

		<%
		}
		rs.close();
		pstmt.close();
		conn.close();
		%>
	</table>
</div>

<script>
	function toggleComments(userId) {
		const box = document.getElementById('commentBox_' + userId);
		box.style.display = (box.style.display === 'none' || box.style.display === '') ? 'block'
				: 'none';
	}
</script>
