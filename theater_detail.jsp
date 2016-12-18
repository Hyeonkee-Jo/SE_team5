<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*"%> 
<%@page import ="java.util.ArrayList"%>

<%
    request.setCharacterEncoding("UTF-8");
	String DRIVER = "oracle.jdbc.driver.OracleDriver";
	String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER";
	String USER = "SE";
	String PASS = "SE";

	Connection conn = null;
    ResultSet rs;
    String boolConfirm = "true";
	try{
		Class.forName(DRIVER);
		conn = DriverManager.getConnection(URL,USER,PASS);
	}catch(Exception e){
		System.out.println(e.getMessage());
	}
	
   String cinemaRegion = request.getParameter("cinemaRegion");
   
   try {
  
   Statement stmt = conn.createStatement();
   String query = "SELECT MOVIE_TITLE FROM SCREENING WHERE CINEMA_REGION = '"+cinemaRegion+"'";
   rs = stmt.executeQuery(query);

%>

<!DOCTYPE html>
<html>
<head>
   <link rel="stylesheet" href="css/manage_cinema.css">
</head>
<body>
    <form id="theater_detail" action="theater_detail.jsp">
    <div id="listMovieR">
        <p style="margin-left:30px; font-weight:bold">영화 목록</p>
        <hr>
        <div id="listMovie">
            <%while(rs.next()) { %>
            <ul>
                <% out.print(rs.getString(1));%>
                <input name = "cinema_Region" value = "<%out.print(cinemaRegion);%>" style="display:none">
                <button type="submit" name="movieName" value="<%out.print(rs.getString(1));%>" formaction="delete_movie_inCinema.jsp">
                    삭제</button>
            </ul>
            <%} 
                } catch (Exception e) {      
        System.out.println(e.getMessage());
        }%>
        </div>
    </div>
	</form>

    <form id="add_movie_to_theater" action="add_movie_to_theater.jsp" >
        <% try {
        Statement stmt = conn.createStatement();
        String query = "SELECT MOVIE_TITLE FROM MOVIE";
        rs = stmt.executeQuery(query); 
    %>
        <div id = "movie_box" style="margin-left:30px;">
            <select name="movie_list">
                <% while(rs.next()) { %>
                <option value="<% out.print(rs.getString(1));%>"><% out.print(rs.getString(1));%></option>
                <%}
                }catch (Exception e) {
                %><script>alert("aa");</script><%
                    System.out.println(e.getMessage());
            }%>
            </select>
        </div>
        <input name = "c_Region" value = "<%out.print(cinemaRegion);%>" style="display:none">
        <button type="submit" style="margin-left:30px;">영화등록</button>
    </form>
                
    <form id="theater_detail" action="theater_detail.jsp">
    <div id="listTheaterR">
        <p style="margin-left:30px; font-weight:bold">상영관 목록</p>
        <hr>
        <div id="listTheater">
            <% try {
                Statement stmt = conn.createStatement();
                String query = "SELECT THEATER_NAME FROM THEATER WHERE CINEMA_REGION = '"+ cinemaRegion +"'";
                rs = stmt.executeQuery(query);
                while(rs.next()) {
               %>
            <ul>
                <a href="schedule_detail.jsp?cinemaRegion=<%out.print(cinemaRegion);%>&theaterName=<% out.print(rs.getString(1));%>"> <% out.print(rs.getString(1));%></a>
                <input name = "cinema_Region" value = "<%out.print(cinemaRegion);%>" style="display:none">
                <button type="submit" name="theater_name" value="<%out.print(rs.getString(1));%>" formaction="delete_theater.jsp">삭제</button>
            </ul>
            <% }} catch (Exception e) {
                %><script>alert("aa");</script><%
                    System.out.println(e.getMessage());
            } %>
        </div>
    </div>
	</form>
    
    <form id="add_theater" action="add_theater.jsp" >
        <input name = "cinema_Region" value = "<%out.print(cinemaRegion);%>" style="display:none">
        <p style = "margin-left:30px;">이 름 : <input type = "text" name = "theater_id" value="" required><br></p>
        <p style = "margin-left:30px;">가 격 : <input type = "text" name = "theater_cost" value="5000" required><br></p>
        <button type="submit" style="margin-left:30px;">상영관 등록</button>
    </form>
</body>
</html>