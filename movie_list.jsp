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
		
		ArrayList<String> movieTitleList = new ArrayList<String>();
		
		String query = "SELECT MOVIE_TITLE FROM MOVIE";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		
		while(rs.next()) {
			movieTitleList.add(rs.getString(1));
		}
		
%>

<html>
    <head>
        <link rel="stylesheet" href="css/movie_list.css">
    </head>
    <body>
        <a href="movie_list.jsp" id="movie_tab">영화</a>
        <a href="movie_reservation.jsp" id="reservation_tab">예매</a>
        <a href="" id="my_info_tab">내 정보</a>
        <br>
        <div class="scroll">
            <img src="images/movie1.jpg" alt="movie1" style="width:200px;height:300px;">
            <img src="images/movie2.jpg" alt="movie2" style="width:200px;height:300px;">
            <img src="images/movie3.jpg" alt="movie3" style="width:200px;height:300px;">
            <img src="images/movie4.jpg" alt="movie4" style="width:200px;height:300px;">
            <br>
            <a href="" id="movie1_title">신비한 동물사전</a>
            <a href="" id="movie2_title">닥터 스트레인지</a>
            <a href="" id="movie3_title">다크나이트</a>
            <a href="" id="movie4_title">말할 수 없는 비밀</a>
        </div>
    </body>
</html>