<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>

<%
try {
    // 업로드된 프로필 사진 경로
    String uploadPath = application.getRealPath("/") + "upload/profile.jpg";
    File uploaded = new File(uploadPath);

    if (uploaded.exists()) {
        if (uploaded.delete()) {
            // 세션의 photo 정보도 기본으로 변경
            session.setAttribute("photo", "upload/https://i.namu.wiki/i/M0j6sykCciGaZJ8yW0CMumUigNAFS8Z-dJA9h_GKYSmqqYSQyqJq8D8xSg3qAz2htlsPQfyHZZMmAbPV-Ml9UA.webp");

            // 성공 후 info.jsp로 이동
            response.sendRedirect("info.jsp?deleteSuccess=true");
        } else {
            out.println("<script>alert('프로필 사진 삭제 실패'); history.back();</script>");
        }
    } else {
        // 파일이 없는 경우
        session.setAttribute("photo", "upload/https://i.namu.wiki/i/M0j6sykCciGaZJ8yW0CMumUigNAFS8Z-dJA9h_GKYSmqqYSQyqJq8D8xSg3qAz2htlsPQfyHZZMmAbPV-Ml9UA.webp");
        response.sendRedirect("info.jsp?deleteSuccess=true");
    }
} catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('에러 발생: " + e.getMessage() + "'); history.back();</script>");
}
%>
