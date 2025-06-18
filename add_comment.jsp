<%@ page import="java.sql.*"%>
<%@ page import="jakarta.servlet.*"%>
<%@ page import="jakarta.servlet.http.*"%>
<%@ include file="db.jsp"%>

<%
request.setCharacterEncoding("UTF-8");
String writerLoginId = (String) session.getAttribute("id");
String content = request.getParameter("content");
String targetUserIdStr = request.getParameter("user_id");

if (writerLoginId == null || content == null || content.trim().isEmpty() || targetUserIdStr == null) {
   out.println("<script>alert('로그인 후 댓글을 작성해주세요.'); location.href='mainpage.jsp';</script>");
    return;
}

try {
  

    // 작성자 user_id 확인 (signup에서만!)
    String writerSql = "SELECT user_id FROM signup WHERE id = ?";
    PreparedStatement writerStmt = conn.prepareStatement(writerSql);
    writerStmt.setString(1, writerLoginId);
    ResultSet writerRs = writerStmt.executeQuery();

    if (!writerRs.next()) {
        // 게스트거나 유효하지 않은 사용자
        response.sendRedirect("ranking.jsp");
        return;
    }

    int writerId = writerRs.getInt("user_id");
    int targetUserId = Integer.parseInt(targetUserIdStr);

    String insertSql = "INSERT INTO comments (user_id, writer_id, content) VALUES (?, ?, ?)";
    PreparedStatement insertStmt = conn.prepareStatement(insertSql);
    insertStmt.setInt(1, targetUserId);
    insertStmt.setInt(2, writerId);
    insertStmt.setString(3, content);
    insertStmt.executeUpdate();

    insertStmt.close();
    writerRs.close();
    writerStmt.close();

    response.sendRedirect("ranking.jsp");

} catch (Exception e) {
    out.println("오류 발생: " + e.getMessage());
} finally {
    try {
        if (conn != null) conn.close();
    } catch (Exception e) {}
}
%>
