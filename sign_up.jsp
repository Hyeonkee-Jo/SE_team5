<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>

<%
	//사실 여기도 필요없어
%>

<html>
    <head>
        <link rel="stylesheet" href="css/sign_up.css">
    </head>
    <body>
	
		<form action="doSignUp.jsp">
			<label for="id_text" id="id_label">ID : </label>
			<input type="text" id="id_text" name="id_text" required><br>
			
			<label for="pw_text" id="pw_label">비밀번호 : </label>
			<input type="text" id="pw_text" name="pw_text" required><br>
			
			<label for="phone_text" id="phone_label">휴대폰 번호 : </label>
			<input type="text" id="phone_text" name="phone_text" required><br>
			
			<label for="name_text" id="name_label">이름 : </label>
			<input type="text" id="name_text" name="name_text" required><br>
			
			<label for="mail_text" id="mail_label">생일 : </label>
			<input type="text" id="mail_text" name="birth_text" required><br>
			
			
			<label for="mail_text" id="mail_label">주소 : </label>
			<input type="text" id="mail_text" name="address_text" required><br>
			
			<label for="mail_text" id="mail_label">메일주소 : </label>
			<input type="text" id="mail_text" name="email_text" required><br>
			
			
			
			<button type="submit" id="sign_up_button">회원가입</button>	
			<button type="button" id="cancel_button">취소</button> 
		</form>
	   
	</body>
</html>
