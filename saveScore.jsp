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

   String loginId = (String) session.getAttribute("id");
   int userId = -1;
   boolean isGuest = false;

   // 일반 로그인인지 확인
   String checkSql = "SELECT user_id FROM signup WHERE id = ?";
   PreparedStatement checkStmt = conn.prepareStatement(checkSql);
   checkStmt.setString(1, loginId);
   ResultSet checkRs = checkStmt.executeQuery();

   if (checkRs.next()) {
       userId = checkRs.getInt("user_id");
   } else {
       // signup에 없으면 guest 테이블 확인
       String guestSql = "SELECT * FROM guest WHERE gid = ?";
       PreparedStatement guestStmt = conn.prepareStatement(guestSql);
       guestStmt.setString(1, loginId);
       ResultSet guestRs = guestStmt.executeQuery();
       if (guestRs.next()) {
           isGuest = true;
       }
       guestRs.close();
       guestStmt.close();
   }
   checkRs.close();
   checkStmt.close();

   if (userId == -1 && !isGuest) {
       out.println("<script>alert('로그인 정보가 없습니다.'); location.href='loginstart.jsp';</script>");
       return;
   }

   int level = 1;
   int exp = 0;

   if (!isGuest) {
       // 1. 사용자 정보 불러오기
       String sql = "SELECT level, exp FROM signup WHERE user_id = ?";
       pstmt = conn.prepareStatement(sql);
       pstmt.setInt(1, userId);
       rs = pstmt.executeQuery();
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
       String updateSql = "UPDATE signup SET level = ?, exp = ? WHERE user_id = ?";
       PreparedStatement updateStmt = conn.prepareStatement(updateSql);
       updateStmt.setInt(1, level);
       updateStmt.setInt(2, exp);
       updateStmt.setInt(3, userId);
       updateStmt.executeUpdate();
       updateStmt.close();

       // 4. 최고 점수 갱신
       String scoreCheckSql = "SELECT score FROM scores WHERE user_id = ?";
       PreparedStatement scoreCheckStmt = conn.prepareStatement(scoreCheckSql);
       scoreCheckStmt.setInt(1, userId);
       ResultSet scoreRs = scoreCheckStmt.executeQuery();

       boolean shouldInsert = true;
       if (scoreRs.next()) {
           int currentScore = scoreRs.getInt("score");
           if (intscore > currentScore) {
               String updateScoreSql = "UPDATE scores SET score = ?, played_at = CURRENT_TIMESTAMP WHERE user_id = ?";
               PreparedStatement updateScoreStmt = conn.prepareStatement(updateScoreSql);
               updateScoreStmt.setInt(1, intscore);
               updateScoreStmt.setInt(2, userId);
               updateScoreStmt.executeUpdate();
               updateScoreStmt.close();
           }
           shouldInsert = false;
       }
       scoreRs.close();
       scoreCheckStmt.close();

       if (shouldInsert) {
           String insertScoreSql = "INSERT INTO scores (user_id, score) VALUES (?, ?)";
           PreparedStatement insertScoreStmt = conn.prepareStatement(insertScoreSql);
           insertScoreStmt.setInt(1, userId);
           insertScoreStmt.setInt(2, intscore);
           insertScoreStmt.executeUpdate();
           insertScoreStmt.close();
       }
   } else {
       level = 1;
       exp = 0;
   }
   %>
   
   <h2>Game Over!</h2>
   <p>내 점수: <%=intscore%></p>
   <p>현재 레벨: <%=level%></p>
   <p>현재 EXP: <%=exp%> / <%= (int) Math.pow(2, level) %></p>
   <p>
      <button onclick="location.href='index.html'">다시하기</button>
      <%
         if (isGuest) {
      %>
         <button onclick="location.href='gueststart.jsp'">메인화면</button>
      <%
         } else {
      %>
         <button onclick="location.href='loginstart.jsp'">메인화면</button>
      <%
         }
      %>
      <button onclick="location.href='ranking.jsp'">랭킹</button>
      <%
         if (isGuest) {
      %>
         <button onclick="location.href='mainpage.jsp'">로그인하러 가기</button>
         <% }   else {
             %>
             <button onclick="location.href='info.jsp'">프로필 보기</button>
          <%
             }
          %>
   </p>
   <%
   conn.close();
   %>
</body>
</html>
