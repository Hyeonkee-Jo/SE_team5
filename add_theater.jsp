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
    String theater_name = request.getParameter("theater_id");
    int cost = Integer.parseInt(request.getParameter("theater_cost"));
	
    try {
        Statement stmt = conn.createStatement();
        String query = "SELECT THEATER_NAME FROM THEATER WHERE CINEMA_REGION = '" + cinemaRegion + "'";
        rs = stmt.executeQuery(query);
   
        while(rs.next()) {
            if(rs.getString(1).equals(theater_name)) {
                %><script>
                alert("same theater exist!!");
                document.location.href ="manage_cinema.jsp";
        </script><%
            }  
        }

    } catch (Exception e) {
    %><script>alert("a");</script><%
        System.out.println(e.getMessage());
    }
    try {
        Statement stmt = conn.createStatement();
        String query = "INSERT INTO THEATER VALUES('"+cinemaRegion+"', '"+theater_name +"', "+ cost +")";
        rs = stmt.executeQuery(query);
   

    } catch (Exception e) {
    %><script>alert("a");</script><%
        System.out.println(e.getMessage());
    }
%>

    <script>
	   document.location.href="manage_cinema.jsp";
    </script>