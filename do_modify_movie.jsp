 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String realFolder = "";
	String filename1 = "";
	int maxSize = 1024*1024*5;
	String encType = "euc-kr";
	String savefile = "images";
	ServletContext scontext = getServletContext();
	realFolder = scontext.getRealPath(savefile);

	String movieTitle="";	
	String imgName="";
	String runningTime="";
	String rating="";
	String story="";
	String synopsis="";
 
	String origin="";
 
 
 
 
 
	try{
		MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		origin = multi.getParameter("originTitle");
		
		movieTitle = multi.getParameter("mTitle");
		runningTime = multi.getParameter("runningTime");
		rating = multi.getParameter("ageLimit");
		story = multi.getParameter("story");
		synopsis = multi.getParameter("synop");

		imgName = multi.getOriginalFileName("file");
		imgName = imgName.substring(0, imgName.length()-4);

		File file = multi.getFile("file");
	}
	catch(Exception e){
		
	}

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
	try{
		String firstQuery = "DELETE FROM MOVIE WHERE MOVIE_TITLE=?";
		PreparedStatement pstmt2 = conn.prepareStatement(firstQuery);
		pstmt2.setString(1, origin);
		pstmt2.executeQuery();
	
		String query = "INSERT INTO MOVIE VALUES(?,?,?,?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(query);
	
		pstmt.setString(1, movieTitle);
		pstmt.setString(2, imgName);
		pstmt.setInt(3, Integer.parseInt(runningTime));
		pstmt.setString(4, story);
		pstmt.setString(5, synopsis);
		pstmt.setInt(6, Integer.parseInt(rating));
		
		pstmt.executeQuery();
	}
	catch(Exception b){
%>
		<script>
			alert("영화 삽입 실패");
			document.location.href="movie_list.jsp";	
		</script>
<%		
	}
%>
		<script>
			alert("영화 추가 완료");
			document.location.href="movie_list.jsp";	
		</script>
<%		
	
%>
</head>
<body>

</body>
</html>