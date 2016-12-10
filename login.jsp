<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>

<%
   String DRIVER = "oracle.jdbc.driver.OracleDriver";
		String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER";
		String USER = "KIM";
		String PASS = "KIM";

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
%>
    
<html>
    <head>
        <link rel="stylesheet" href="login.css">
    </head>
    <body>
        <label for="id_text" id="id_label">ID : </label>
        <input type="text" id="id_text"><br>
        <label for="pw_text" id="pw_label">비밀번호 : </label>
        <input type="text" id="pw_text"><br>
        <button type="button" id="login_button">로그인</button>
        <button type="button" id="sign_up_button">회원가입</button>    
    </body>
</html>