<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*"%> 

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
	
	String reservationNumber = "";
	try {
		int initReservationNumber = 0;
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(
				"SELECT RESERVATION_NUMBER FROM RESERVATION "
				+ "ORDER BY RESERVATION_NUMBER DESC");
		if(rs.next()){

			initReservationNumber = Integer.parseInt(rs.getString(1).substring(1, rs.getString(1).length())) + 1;
		}else
			initReservationNumber = 1000;
		
		reservationNumber = "R" + initReservationNumber;

	} catch(SQLException e) {
		e.printStackTrace();
	}
	
	String cinemaRegion = (String)session.getAttribute("cinemaRegion");
	String theaterName = (String)session.getAttribute("theaterName");
	String startTime = (String)session.getAttribute("startTime");
	
	int price = 0;
	try {
		String query = "SELECT SEAT_PRICE " + 
					"FROM THEATER WHERE CINEMA_REGION = ? AND THEATER_NAME = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, cinemaRegion);
		pstmt.setString(2, theaterName);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			price = rs.getInt(1);
		}
			
	} catch (SQLException e) {
	%>
	<script>
		alert("상영관 좌석 가격 가져오기 실패");
	</script>
	<%
	}
	
	int row = 0;
	int column = 0;
	try {
		String query = "SELECT SEAT_ROW, SEAT_COLUMN " + 
					"FROM SEAT WHERE CINEMA_REGION = ? AND THEATER_NAME = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, cinemaRegion);
		pstmt.setString(2, theaterName);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			row = rs.getInt(1);
			column = rs.getInt(2);
		}
			
	} catch (SQLException e) {
	%>
	<script>
		alert("상영관 좌석 행,열 가져오기 실패");
	</script>
	<%
	}
	
	int[][] seatState = new int[row + 1][column + 1];
	try {
		String query = "SELECT S.RESERVED_SEAT_ROW, S.RESERVED_SEAT_COLUMN " + 
					"FROM RESERVED_SEAT S, RESERVATION R " + 
					"WHERE CINEMA_REGION = ? AND THEATER_NAME = ? AND START_TIME = TO_DATE(?, 'YY/MM/DD/HH24/MI') " + 
					"AND S.RESERVATION_NUMBER = R.RESERVATION_NUMBER";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, cinemaRegion);
		pstmt.setString(2, theaterName);
		pstmt.setString(3,startTime);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			seatState[rs.getInt(1)][rs.getInt(2)] = 2;
		}
			
	} catch (SQLException e) {
	%>
	<script>
		alert("예약된 자리 정보 가져오기 실패");
	</script>
	<%
	}
	
	
	
%>

<html>
    <head>
        <link rel="stylesheet" href="css/select_seat.css">
		<script>
		function setColor(btn, text, price, seat){
			var property = document.getElementById(btn);
			var textProerty = document.getElementById(text);
			var seatProerty  = document.getElementById(seat);
			if (property.value == 0){
				property.style.backgroundColor = "#994C00"  ;
				property.value = 1;
				seatProerty.value = 1;
				textProerty.value = Number(textProerty.value) + Number(price);
			}
			else{
				property.style.backgroundColor = "#07D567";
				property.value = 0;
				seatProerty.value = 0;
				textProerty.value = textProerty.value - price;
			}
		}
		</script>
    </head>
    <body>
	<form action="payment.jsp" method = "post" id="payment_form">
		<%for(int i = 1; i <= row; i++) {%>
			<%for(int j = 1; j <= column; j++) {%>
				<input type="text" id="seat<%out.print(i);%><%out.print(j);%>" 
				name="seat<%out.print(i);%><%out.print(j);%>" 
				value="<%out.print(seatState[i][j]);%>" 
				style="background-color:#07D567; display:none">
			<%}%>
		<%}%>
        <table>
		<%for(int i = 1; i <= row; i++) {%>
			<tr>
			<%for(int j = 1; j <= column; j++) {%>
				<td><button type="button" id="seatBtn<%out.print(i);%><%out.print(j);%>" 
				value="<%out.print(seatState[i][j]);%>" 
				<%if(seatState[i][j] != 2) {%>
				style=background-color:#07D567
				<%}%>
				<%if(seatState[i][j] != 2) {%>
				onclick="setColor('seatBtn<%out.print(i);%><%out.print(j);%>', 'price_text', <%out.print(price);%>, 'seat<%out.print(i);%><%out.print(j);%>')"
				<%}%>
				><%out.print(i);%>,<%out.print(j);%></button>
				</td>
			<%}%>
			</tr>
		<%}%>
        </table>
		<label for="price_text" id="price_text_label">가격 : </label>
		<input type="text" id="price_text" name="price" value=""></input>
		<input type="text" name="cinemaRegion" value="<%out.print(cinemaRegion);%>" style=display:none>
		<input type="text" name="theaterName" value="<%out.print(theaterName);%>" style=display:none>
		<input type="text" name="startTime" value="<%out.print(startTime);%>" style=display:none>
		<input type="text" name="row" value="<%out.print(row);%>" style=display:none>
		<input type="text" name="column" value="<%out.print(column);%>" style=display:none>
		<input type="text" name="reservationNumber" value="<%out.print(reservationNumber);%>" style=display:none>
	</form>
	<button type="submit" id="pay_button" form="payment_form">결제</button>
    <input type="button" id="cancel_button" value="취소" onClick="history.back()">
    </body>
</html>