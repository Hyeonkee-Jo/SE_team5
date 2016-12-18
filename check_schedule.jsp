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
    String cinemaRegion = request.getParameter("cinemaRegion");
	String movieTitle = request.getParameter("movieTitle");
    String theaterName = request.getParameter("theaterName");
    String startTime = request.getParameter("startTime");
    
	try {
		String query = "SELECT * FROM SCHEDULE " + 
						"WHERE CINEMA_REGION = ? AND THEATER_NAME = ? " + 
						"AND START_TIME = TO_DATE(?, 'YY/MM/DD/HH24/MI') " + 
						"AND MOVIE_TITLE = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, cinemaRegion);
		pstmt.setString(2, theaterName);
		pstmt.setString(3, startTime);
		pstmt.setString(4, movieTitle);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		%><p><%out.print(rs.getString(1));%></p>
		<%
		session.setAttribute("cinemaRegion", cinemaRegion);
		session.setAttribute("theaterName", theaterName);
		session.setAttribute("startTime", startTime);
		%>
		<script>
		document.location.href="select_seat.jsp";
		</script><%
	} catch (SQLException e) {
	%>
	<script>
		alert("잘못 선택하셨습니다.");
	</script>
	<script>
		document.location.href="movie_reservation.jsp";
	</script>
	<%
	}
    
%>
