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
	
	try {
		DatabaseMetaData meta = conn.getMetaData();
		System.out.println("time data: " + meta.getTimeDateFunctions());
		System.out.println("user: " + meta.getUserName());
	} catch (SQLException e) {
		System.out.println(e.getMessage());
	}
	
	ArrayList<String> cinemaRegionList = new ArrayList<String>();
	String query = "SELECT CINEMA_REGION FROM CINEMA";
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(query);
	
	while(rs.next()) {
		cinemaRegionList.add(rs.getString(1));
	}
	
%>

<html>
    <head>
        <link rel="stylesheet" href="css/movie_reservation.css">
    </head>
    <body>
        <a href="movie_list.jsp" id="movie_tab">영화</a>
        <a href="movie_reservation.jsp" id="reservation_tab">예매</a>
        <a href="" id="my_info_tab">내 정보</a>
        <br>
        <label for="cinema_select" id="cinema_label">영화관 : </label>
        <select id="cinema_select">
		<%
			for(String cinemaRegion : cinemaRegionList) {
		%>
				<option value="<%out.println(cinemaRegion);%>"><%out.println(cinemaRegion);%></option>
        <%
			}
		%>
		</select>
        <br>
        <label for="movie_select" id="movie_label">영화 : </label>
        <select id="movie_select">
            <option value="신비한동물사전">신비한 동물사전</option>
            <option value="닥터스트레인지">닥터스트레인지</option>
            <option value="다크나이트">다크나이트</option>
            <option value="말할수없는비밀">말할 수 없는 비밀</option>
        </select>
        <br>
        <label for="theather_select" id="theater_label">상영관 : </label>
        <select id="theather_select">
            <option value="1관">1관</option>
            <option value="2관">2관</option>
            <option value="3관">3관</option>
            <option value="4관">4관</option>
        </select>
        <br><br>
        <a href="" class="list">2016-11-17 07:00 ~ 09:00</a>
        <a href="" class="list">2016-11-17 21:00 ~ 23:00</a>
        <a href="" class="list">2016-11-18 14:00 ~ 16:00</a>
        <a href="" class="list">2016-11-19 18:00 ~ 20:00</a>
    </body>
</html>