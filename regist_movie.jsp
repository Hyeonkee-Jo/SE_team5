<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%> 
<%@page import ="java.util.ArrayList"%>
<%	
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/regist_movie.css">
</head>
<body>
    
	<form method="post" enctype="multipart/form-data" action="new_movie.jsp">
        제목 : <input type="text" name="mTitle" class="edit" required><br>
        시간 : <input type="text" name="runningTime" class="edit" required><br>
        연령 : <input type="text" name="ageLimit" class="edit" required><br>
        줄거리 : <input type="text" name="story" class="edit" id="edit_story" required><br>
        예고편 : <input type="text" name="synop" class="edit" id="edit_synop" required><br>
		<input type="file" name="file" size=40 required><br>
		<button type="submit">영화 등록</button>		
	</form>
	
    <div id="picture">
        사진
		<br>
		
    </div>
</body>
    
</html>