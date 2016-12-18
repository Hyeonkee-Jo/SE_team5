<%@ page language="java" contentType="text/html; charset=UTF-8"
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
	
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	String movieTitle = request.getParameter("movieTitle");
	%><p><%out.print(movieTitle);%><%
	try {
		String query = "DELETE FROM MOVIE WHERE MOVIE_TITLE = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, movieTitle);
		int rowCount = pstmt.executeUpdate();
		
		if(rowCount == 0) {
		%>
		<script>
			alert("영화 삭제 실패");
		</script>
		<%
		}
		else {
		%>
		<script>
			alert("영화 삭제 성공");
		</script>
		<%			
		}		
	} catch (SQLException e) {
		%>
		<script>
			alert("영화 삭제 오류");
		</script>
		<%	
	}
%>

