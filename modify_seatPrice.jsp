<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%> 

<%
	request.setCharacterEncoding("UTF-8");

	String price = request.getParameter("mPrice");
	String region = request.getParameter("region");
	String theaterName= request.getParameter("theaterName");
	
	String DRIVER = "oracle.jdbc.driver.OracleDriver";
	String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER";
	String USER = "SE";
	String PASS = "SE";
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	
	try{
		Class.forName(DRIVER);
		conn = DriverManager.getConnection(URL,USER,PASS);
	}catch(Exception e){
		System.out.println(e.getMessage());
	}
	
	
	String query ="UPDATE THEATER SET SEAT_PRICE = ? WHERE CINEMA_REGION =?  AND THEATER_NAME = ?";
	pstmt = conn.prepareStatement(query);
	
	pstmt.setInt(1, Integer.parseInt(price));
	pstmt.setString(2, region);
	pstmt.setString(3, theaterName);

	try{
		pstmt.executeQuery();
	}
	catch(Exception e){
		%>
		<script>
		alert("수정 실패");
		</script>
		<%
	}

%>
<script>
	document.location.href="manage_cinema.jsp"
</script>