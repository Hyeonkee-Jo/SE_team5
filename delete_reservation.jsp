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
	
	System.out.println("asdfasdf");
	String reservationNumber = request.getParameter("reservationNumber");
	String reservationDate = request.getParameter("reservationDate");
	String startTime = request.getParameter("startTime");
	String[] reservationDateArray = reservationDate.split("/");
	String[] startTimeArray = startTime.split("/");
	
	int reservationYear = Integer.parseInt(reservationDateArray[0]);
	int startYear = Integer.parseInt(startTimeArray[0]);
	int reservationMonth = Integer.parseInt(reservationDateArray[1]);
	int startMonth = Integer.parseInt(startTimeArray[1]);
	int reservationDay = Integer.parseInt(reservationDateArray[2]);
	int startDay = Integer.parseInt(startTimeArray[2]);
	int reservationHour = Integer.parseInt(reservationDateArray[3]);
	int startHour = Integer.parseInt(startTimeArray[3]);
	int reservationMinutes = Integer.parseInt(reservationDateArray[4]);
	int startMinutes = Integer.parseInt(startTimeArray[4]);
	
	boolean isCancel = false;
	if(reservationYear <= startYear) {	
		if(reservationMonth <= startMonth) {	
			if(reservationDay <= startDay) {
				if(reservationHour <= startHour) {	
					if(reservationMinutes <= startMinutes - 15) {
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
				}
			}
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