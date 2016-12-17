<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>

<%
	//여긴 디비가 사실 필요없어
%>
    
<html>
    <head>
        <link rel="stylesheet" href="css/login.css">
    </head>
    <body>
		<form action="doLogin.jsp">
			<label for="id_text" id="id_label">ID : </label>
			<input type="text" id="id_text" name="id_text" required><br>
			<label for="pw_text" id="pw_label">비밀번호 : </label>
			<input type="text" id="pw_text" name="pw_text" required><br>
			<button type="submit" id="login_button">로그인</button> 
			<button type="button" id="sign_up_button" onClick='document.location.href="sign_up.jsp";'>회원가입</button>  				
		</form>
		
	</body>
</html>