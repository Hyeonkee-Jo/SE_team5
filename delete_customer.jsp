<%@ page language="java" contentType="text/html; charset=UTF-8"
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
	
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	String customerId = request.getParameter("customerId");
	try {
		String query = "DELETE FROM CUSTOMER WHERE CUSTOMER_ID = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, customerId);
		int rowCount = pstmt.executeUpdate();
		
		if(rowCount == 0) {
		%>
		<script>
			alert("회원 탈퇴 실패");
		</script>
		<%
		}
		else {
		%>
		<script>
			alert("회원 탈퇴 성공");
		</script>
		<%			
		}		
	} catch (SQLException e) {
		%>
		<script>
			alert("회원 탈퇴 오류");
		</script>
		<%	
	}
%>
<script>
	document.location.href="login.jsp"
</script>
