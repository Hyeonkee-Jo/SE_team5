<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%> 
<%

	String region = request.getParameter("region");
	String theaterName= request.getParameter("theaterName");
	String movie = request.getParameter("whatMovie");
	String day = request.getParameter("choiceDay");
	String time = request.getParameter("choiceTime");
	
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd/hh");
	Date today = new Date();
	String date = format.format(today);
	String[] todayArray = date.split("/");

	
	String DRIVER = "oracle.jdbc.driver.OracleDriver";
	String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER";
	String USER = "SE";
	String PASS = "SE";
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	try{
		Class.forName(DRIVER);
		conn = DriverManager.getConnection(URL,USER,PASS);
	}catch(Exception e){
		System.out.println(e.getMessage());
	}
	
	
	String query ="DELETE FROM SCHEDULE WHERE CINEMA_REGION = ? AND THEATER_NAME = ? AND START_TIME=TO_DATE("+day+", YY/MM/DD/HH24/)";
	pstmt = conn.prepareStatement(query);
	



%>