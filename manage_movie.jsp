<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*"%> 
<%@page import ="java.util.ArrayList"%>

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
	ArrayList<String> movieList = new ArrayList<String>();
	try {
		String query = "SELECT MOVIE_TITLE FROM MOVIE";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		
		while(rs.next()) {
			movieList.add(rs.getString(1));
		}
			
	} catch (SQLException e) {
	%>
	<script>
		alert("영화관 지역 가져오기 실패");
	</script>
	<%
	}

%>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/manage_movie.css">
</head>
<body>
    <form id="theater_detail" action="theater_detail.jsp">
    <div id="listMovieR">
        <p style="margin-left:30px; font-weight:bold">영화 목록</p>
        <hr>
        <div id="listMovie">
            <ul>
			<%for(String movie : movieList) {%>
				<li><a href="theater_detail.jsp?movieTitle=<%out.print(movie);%>" ><%out.print(movie);%></a>
				<button type="submit" name="movieTitle" value="<%out.print(movie);%>" formaction="delete_movie.jsp">삭제</button></li>
			<%}%>       
            </ul>
        </div>
    </div>
	</form>
    <form id="deleteArea" action="" >
        <button type="submit" style="margin-left:10px;">등록</button>
    </form>
</body>
</html>