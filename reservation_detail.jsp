<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*"%> 
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.text.SimpleDateFormat"%>
<%@ page import ="java.util.Date"%>

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
	
	String reservationNumber = (String)request.getParameter("reservationNumber");
	String title = "";
	String startTime = "";
	String seat = "";
	String reservationDate = "";
	int price = 0;
	String cinemaRegion = "";
	String theaterName = "";

	try {
		String query = "SELECT * FROM RESERVATION WHERE RESERVATION_NUMBER = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, reservationNumber);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			price = rs.getInt(2);
			cinemaRegion = rs.getString(5);
			theaterName = rs.getString(6);
		}
		
	} catch(SQLException e) {
%>
		<script>
		alert("예매 정보 가져오기 실패");
		</script>
<%
	}
	
	try {
		String query = "SELECT TO_CHAR(RESERVATION_DATE, 'YYYY/MM/DD/HH24/MI'), TO_CHAR(START_TIME, 'YYYY/MM/DD/HH24/MI') " +
						"FROM RESERVATION WHERE RESERVATION_NUMBER = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, reservationNumber);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			reservationDate = rs.getString(1);
			startTime = rs.getString(2);
		}
		
	} catch(SQLException e) {
%>
		<script>
		alert("예매 시간 정보 가져오기 실패");
		</script>
<%
	}
	
	try {
		String query = "SELECT MOVIE_TITLE FROM SCHEDULE "
				+ "WHERE CINEMA_REGION = ? AND THEATER_NAME = ? "
				+ "AND START_TIME = TO_DATE(?, 'YY/MM/DD/HH24/MI')";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, cinemaRegion);
		pstmt.setString(2, theaterName);
		pstmt.setString(3, startTime);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			title = rs.getString(1);
		}	
		
	} catch(SQLException e) {
%>
		<script>
		alert("영화 제목 가져오기 실패");
		</script>
<%
	}
	
	try {
		String query = "SELECT RESERVED_SEAT_ROW, RESERVED_SEAT_COLUMN FROM RESERVED_SEAT "
				+ "WHERE RESERVATION_NUMBER = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, reservationNumber);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			seat = rs.getInt(1) + rs.getInt(2) + " ";
		}
		
	} catch(SQLException e) {
%>
		<script>
		alert("좌석 정보 가져오기 실패");
		</script>
<%
	}
%>


<html>
<body>
<form method="post" action="delete_reservation.jsp" id="delete_form">
	<label for="reservationNumber" id="reservationNumber_label">예매번호 : </label>
	<input type="text" id="reservationNumber" name="reservationNumber" value="<%out.print(reservationNumber);%>"><br>
	<label for="title" id="title_label">영화제목 : </label>
	<input type="text" id="title" name="title" value="<%out.print(title);%>"><br>
	<label for="cinema_region" id="cinema_region_label">영화관 지역 : </label>
	<input type="text" id="cinema_region" name="cinemaRegion" value="<%out.print(cinemaRegion);%>"><br>
	<label for="theater_name" id="theater_name_label">상영관 : </label>
	<input type="text" id="theater_name" name="theaterName" value="<%out.print(theaterName);%>"><br>
	<label for="start_time" id="start_time_label">시작시간 : </label>
	<input type="text" id="start_time" name="startTime" value="<%out.print(startTime);%>"><br>
	<label for="seat" id="seat_label">좌석 : </label>
	<input type = "text" id="seat" name = "seat" value="<%out.print(seat);%>"><br>
    <label for="reservation_date" id="reservation_date_label">예매시간 : </label>
	<input type = "text" id="reservation_date" name = "reservationDate" value="<%out.print(reservationDate);%>"><br>
	<label for="price" id="price_label">결제금액 : </label>
	<input type = "text" id="price" name = "price" value="<%out.print(price);%>"><br>
</form>

<button type="submit" form="delete_form"> 예매취소 </button>

</body>
</html>