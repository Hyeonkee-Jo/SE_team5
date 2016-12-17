<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
	
	String cinemaRegion = "대전 궁동";
	String theaterName = "B1";
	String startTime = "16/12/18/20/00";
	String movieTitle = "신비한 동물사전";
	int price = 10000;
	
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
		function setColor(btn, text, price){
			var property = document.getElementById(btn);
			var textProerty = document.getElementById(text);
			if (property.value == 0){
				property.style.backgroundColor = "#994C00"  
				property.value = 1
				textProerty.value = Number(textProerty.value) + Number(price);
			}
			else{
				property.style.backgroundColor = "#07D567"
				property.value = 0
				textProerty.value = textProerty.value - price;
			}
		}
		</script>
    </head>
    <body>
	<form action="payment.jsp" method = "post" id="payment_form">
        <table>
		<%for(int i = 1; i <= row; i++) {%>
			<tr>
			<%for(int j = 1; j <= column; j++) {%>
				<td><input type="button" id="seat<%out.print(i);%><%out.print(j);%>" 
				name="seat<%out.print(i);%><%out.print(j);%>" 
				value="<%out.print(seatState[i][j]);%>" 
				<%if(seatState[i][j] != 2) {%>
				style=background-color:#07D567
				<%}%>
				<%if(seatState[i][j] != 2) {%>
				onclick="setColor('seat<%out.print(i);%><%out.print(j);%>', 'price_text', <%out.print(price);%>)"
				<%}%>
				><%out.print(i);%>,<%out.print(j);%></input>
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
		<input type="text" name="movieTitle" value="<%out.print(movieTitle);%>" style=display:none>
		<input type="text" name="row" value="<%out.print(row);%>" style=display:none>
		<input type="text" name="column" value="<%out.print(column);%>" style=display:none>
	</form>
	<button type="submit" id="pay_button" form="payment_form">결제</button>
    <input type="button" id="cancel_button" value="취소" onClick="history.back()">
    </body>
</html>