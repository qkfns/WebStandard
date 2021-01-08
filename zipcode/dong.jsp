<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    String DRV = "org.mariadb.jdbc.Driver";
    String URL = "jdbc:mariadb://mariadb.c3zgrbtde6pb.ap-northeast-2.rds.amazonaws.com:3306/bigdata";
    String USR = "bigdata";
    String PWD = "bigdata2020";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String sql = "select distinct dong from zipcode_2013 where sido = ? and gugun = ?";
    StringBuilder sb = new StringBuilder();

    // get방식으로 전달한 시/도 데이터를 JSP로 가져오기
    // http://127.0.0.1:8080/zipcode/gugun.jsp?sido=서울&gugun=강남구
    request.setCharacterEncoding("UTF-8");
    String sido = request.getParameter("sido");
    String gugun = request.getParameter("gugun");

    try {
        Class.forName(DRV);
        conn = DriverManager.getConnection(URL, USR, PWD);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, sido);
        pstmt.setString(2, gugun);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            sb.append(rs.getString(1)).append(',');
            // 서울,경기,인천,부산,.....
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    out.write(sb.toString());
%>