<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*"%> 
<%@page import ="java.util.ArrayList"%>
<%@page import ="java.util.HashMap"%>

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
	ArrayList<String> cinemaRegionList = new ArrayList<String>();
	try {
		String query = "SELECT CINEMA_REGION FROM CINEMA";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
	
		while(rs.next()) {
			cinemaRegionList.add(rs.getString(1));
		}
	} catch(SQLException e) { 
	%>
	<script>
		alert("영화관 목록 가져오기 실패");
	</script>
	<%
	}
	
	ArrayList<String> movieTitleList = new ArrayList<String>();
	try {
		String query = "SELECT MOVIE_TITLE FROM MOVIE";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
	
		while(rs.next()) {
			movieTitleList.add(rs.getString(1));
		}
	} catch(SQLException e) { 
	%>
	<script>
		alert("영화 목록 가져오기 실패");
	</script>
	<%
	}
	
	ArrayList<String> theaterNameList = new ArrayList<String>();
	try {
		String query = "SELECT DISTINCT THEATER_NAME FROM SCHEDULE";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
	
		while(rs.next()) {
			theaterNameList.add(rs.getString(1));
		}
	} catch(SQLException e) { 
	%>
	<script>
		alert("상영관 목록 가져오기 실패");
	</script>
	<%
	}
	
	ArrayList<String> startTimeList = new ArrayList<String>();
	try {
		String query = "SELECT DISTINCT TO_CHAR(START_TIME, 'YYYY/MM/DD/HH24/MI') FROM SCHEDULE";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
	
		while(rs.next()) {
			startTimeList.add(rs.getString(1));
		}
	} catch(SQLException e) { 
	%>
	<script>
		alert("시작시간 목록 가져오기 실패");
	</script>
	<%
	}
%>

<html>
    <head>
        <link rel="stylesheet" href="css/movie_reservation.css">
    </head>
    <body>
        <a href="movie_list.jsp" id="movie_tab">영화</a>
        <a href="movie_reservation.jsp" id="reservation_tab">예매</a>
        <a href="member_info.jsp" id="my_info_tab">내 정보</a>
        <br>
		<form action="check_schedule.jsp">
        <label for="cinema_select" id="cinema_label">영화관 : </label>
        <select id="cinema_select" name="cinemaRegion">
		<%
			for(String cinemaRegion : cinemaRegionList) {
		%>
				<option value="<%out.print(cinemaRegion);%>"><%out.println(cinemaRegion);%></option>
        <%
			}
		%>
		</select>
        <br>
        <label for="movie_select" id="movie_label">영화 : </label>
        <select id="movie_select" name="movieTitle">
		<%
			for(String movieTitle : movieTitleList) {
		%>
				<option value="<%out.print(movieTitle);%>"><%out.println(movieTitle);%></option>
        <%
			}
		%>
        </select>
        <br>
        <label for="theather_select" id="theater_label">상영관 : </label>
        <select id="theather_select" name="theaterName">
		<%
			for(String theaterName : theaterNameList) {
		%>
				<option value="<%out.print(theaterName);%>"><%out.println(theaterName);%></option>
        <%
			}
		%>
        </select>
        <br>
        <label for="start_select" id="start_label">상영관 : </label>
        <select id="start_select" name="startTime">
		<%
			for(String startTime : startTimeList) {
		%>
				<option value="<%out.print(startTime);%>"><%out.println(startTime);%></option>
        <%
			}
		%>
        </select>
		<br>
		<button type="submit">예매</button>
		</form>
    </body>
</html>