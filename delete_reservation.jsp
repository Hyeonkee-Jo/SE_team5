<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.text.SimpleDateFormat" %>

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
	
	String reservationNumber = request.getParameter("reservationNumber");
	String startTime = request.getParameter("startTime");
	String[] startTimeArray = startTime.split("/");
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd/HH/mm");
	Date today = new Date();
	String currentTime = format.format(today);
	today = format.parse(currentTime);
	
	int startYear = Integer.parseInt(startTimeArray[0]);
	int startMonth = Integer.parseInt(startTimeArray[1]);
	int startDay = Integer.parseInt(startTimeArray[2]);
	int startHour = Integer.parseInt(startTimeArray[3]);
	int startMinutes = Integer.parseInt(startTimeArray[4]);
	
	startTime = startYear + "/" + startMonth + "/" +startDay + "/" + startHour + "/" + (startMinutes - 15);
	Date start = format.parse(startTime);
	
	boolean isCancel = false;
	if(start.compareTo(today) > 0) {
		try {
			String query = "DELETE FROM RESERVATION WHERE RESERVATION_NUMBER = ?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, reservationNumber);
			int rowCount = pstmt.executeUpdate();
		
			if(rowCount == 0) {
			%>
			<script>
				alert("예매 취소 실패");
			</script>
			<%
			}
			else {
			%>
			<script>
				alert("예매 취소 성공");
			</script>
			<%			
			isCancel = true;
			}
		
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	if(!isCancel){
	%>
	<script>
		alert("영화 시작 15분 전부터는 예매를 취소할 수 없습니다.");
	</script>
	<%
	}
%>

<script>
	document.location.href="member_info.jsp";
</script>