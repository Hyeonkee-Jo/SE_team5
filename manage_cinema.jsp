<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*"%> 
<%@page import ="java.util.ArrayList"%>

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

	ArrayList<String> cinemaRegionList = new ArrayList<String>();
	try {
		String query = "SELECT CINEMA_REGION FROM CINEMA";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		
		while(rs.next()) {
			cinemaRegionList.add(rs.getString(1));
		}
			
	} catch (SQLException e) {
	%>
	<script>
		alert("영화관 지역 가져오기 실패");
	</script>
	<%
	}

%>

<!DOCTYPE html>
<html>
<head>
   <link rel="stylesheet" href="css/manage_cinema.css">
</head>
<body>
    <form id="theater_detail" action="theater_detail.jsp">
    <div id="listMovieR">
        <p style="margin-left:30px; font-weight:bold">영화관 목록</p>
        <hr>
        <div id="listMovie">
            <ul>
			<%for(String cinemaRegion : cinemaRegionList) {%>
				<li><a href="theater_detail.jsp?cinemaRegion=<%out.print(cinemaRegion);%>" onclick="parentNode.submit()" ><%out.print(cinemaRegion);%></a>
				<button type="submit" name="cinemaRegion" value="<%out.print(cinemaRegion);%>" formaction="delete_cinema.jsp">삭제</button></li>
			<%}%>       
            </ul>
        </div>
    </div>
	</form>
    <form id="deleteArea" action="add_cinema.jsp" >
        <label for="cinema_region" id="cinema_region_label">지역 : </label>
        <input type="text"  id="cinema_region" name="cinemaRegion" style="margin-left:10px;">
        <button type="submit" style="margin-left:10px;">추가</button>
    </form>
</body>
</html>