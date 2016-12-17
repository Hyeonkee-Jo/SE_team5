<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>

<%
	String DRIVER = "oracle.jdbc.driver.OracleDriver";
	String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER";
	String USER = "SE";
	String PASS = "SE";
	Connection conn = null;
	try{
		Class.forName(DRIVER);
		conn = DriverManager.getConnection(URL,USER,PASS);
	}catch(Exception e){
		System.out.println(e.getMessage());
	}
	
	String cinemaRegion = request.getParameter("cinemaRegion");
	
	try {
		String query = "DELETE FROM CINEMA WHERE CINEMA_REGION = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, cinemaRegion);
		int rowCount = pstmt.executeUpdate();
		
		if(rowCount == 0) {
		%>
		<script>
			alert("영화관 삭제 실패");
		</script>
		<%
		}
		else {
		%>
		<script>
			alert("영화관 삭제 성공");
		</script>
		<%			
		}		
	} catch (SQLException e) {
		%>
		<script>
			alert("영화관 삭제 오류");
		</script>
		<%	
	}
%>

<script>
	document.location.href="manage_cinema.jsp";
</script>