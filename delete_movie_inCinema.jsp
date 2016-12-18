%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");
	String DRIVER = "oracle.jdbc.driver.OracleDriver";
	String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER";
	String USER = "SE";
	String PASS = "SE";
   
	Connection conn = null;
    ResultSet rs;
   
	try{
		Class.forName(DRIVER);
		conn = DriverManager.getConnection(URL,USER,PASS);
	}catch(Exception e){
		System.out.println(e.getMessage());
	}
	
	String cinemaRegion = request.getParameter("cinema_Region");
    String movie_name = request.getParameter("movieName");
	
    try {
        Statement stmt = conn.createStatement();
        String query = "DELETE FROM SCREENING WHERE CINEMA_REGION = '" + cinemaRegion +"' AND MOVIE_TITLE = '"+ movie_name +"'";
        rs = stmt.executeQuery(query);
   

    } catch (Exception e) {
    %><script>alert("aa");</script><%
        System.out.println(e.getMessage());
    }
%>

    <script>
	   document.location.href="manage_cinema.jsp";
    </script>