<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%> 
<%@page import ="java.util.ArrayList"%>

<%	
	request.setCharacterEncoding("UTF-8");


	//String movieTitle=request.getParameter("movieTitle");
	String movieTitle ="다크나이트";
	String originTitle="다크나이트";
	
	
	String imgName="";
	String runningTime="";
	String rating="";
	String story="";
	String synopsis="";
 
	
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
	
	
	String query ="SELECT * FROM MOVIE WHERE MOVIE_TITLE = ?";
	pstmt = conn.prepareStatement(query);
	
	pstmt.setString(1, movieTitle);
	
	rs = pstmt.executeQuery();
	rs.next();

	runningTime = rs.getString(3);
	rating = rs.getString(6);
	story = rs.getString(4);
	synopsis = rs.getString(5);





%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <link rel="stylesheet" href="css/regist_movie.css">
</head>
<body>
    
	<form method="post" enctype="multipart/form-data" action="do_modify_movie.jsp">
        제목 : <input type="text" name="mTitle" class="edit" value="<%out.print(movieTitle);%>" required><br>
        시간 : <input type="text" name="runningTime" class="edit" value="<%out.print(runningTime);%>" required><br>
        연령 : <input type="text" name="ageLimit" class="edit" value="<%out.print(rating);%>" required><br>
        줄거리 : <input type="text" name="story" class="edit" id="edit_story" value="<%out.print(story);%>" required><br>
        예고편 : <input type="text" name="synop" class="edit" id="edit_synop" value="<%out.print(synopsis);%>"required><br>
		<input type="file" name="file" size=40 required><br>
		<input type="text" name="originTitle" style="visibility : hidden" value="<%out.print(originTitle);%>">
		<button type="submit">영화 수정</button>		
	</form>
	
    <div id="picture">
        사진
		<br>
		
    </div>
</body>
    
</html>