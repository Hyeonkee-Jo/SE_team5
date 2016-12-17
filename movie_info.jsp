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
	
	try {
		DatabaseMetaData meta = conn.getMetaData();
		System.out.println("time data: " + meta.getTimeDateFunctions());
		System.out.println("user: " + meta.getUserName());
	} catch (SQLException e) {
		System.out.println(e.getMessage());
	}
	String movieTitle =request.getParameter("movie_title");
	int runningtime = 0;
	String sysnopsis = "";
	String preview = "";
	String img = "";
	
	int rating = 0;
	String query = "SELECT * FROM MOVIE WHERE IMG_NAME = ?";
	
	PreparedStatement pstmt = conn.prepareStatement(query);
	pstmt.setString(1, movieTitle);
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()) {
		img = rs.getString(2);
		runningtime = rs.getInt(3);
		sysnopsis = rs.getString(4);
		preview = rs.getString(5);
		rating = rs.getInt(6);
	}
	
%>
    
<html>
    <head>
        <link rel="stylesheet" href="css/movie_info.css">
    </head>
    <body>
        <div id="movie_image" style="width: 30%; height:300px; float: left;">
            <img src="images/<%out.print(img);%>.jpg" alt="movie1" style="width:200px;height:300px;">
        </div>
        <div id="movie_info" style="width: 70%; height:300px; float: right;">
            <p>제목 : <%out.println(movieTitle);%></p>
            <p>상영 시간 : <%out.println(runningtime);%>분</p>
            <p>제한 연령 : <%out.println(rating);%>세 이상</p>
        </div>
        <p><%out.println(sysnopsis);%></p>
        <iframe width="560" height="315" src="<%out.print(preview);%>" frameborder="0" allowfullscreen></iframe>
    </body>
</html>
