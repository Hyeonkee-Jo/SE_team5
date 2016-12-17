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

	request.setCharacterEncoding("UTF-8");
	String customerId = "jhlee";
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String phoneNumber = request.getParameter("phoneNumber");
	String birthday = request.getParameter("birthday");
	String eMail = request.getParameter("eMail");
	
	try {
		String query = "UPDATE CUSTOMER SET CUSTOMER_PASSWORD = ?, CUSTOMER_NAME = ?, "
						+ "ADDRESS = ?, PHONE_NUMBER = ?, BIRTHDAY = ?, E_MAIL = ? "
						+ "WHERE CUSTOMER_ID = ?";
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, password);
		pstmt.setString(2, name);
		pstmt.setString(3, address);
		pstmt.setString(4, phoneNumber);
		pstmt.setString(5, birthday);
		pstmt.setString(6, eMail);
		pstmt.setString(7, customerId);
		int rowCount = pstmt.executeUpdate();
		
		if(rowCount == 0) {
%>
		<script>
		alert("정보 수정에 실패했습니다.");
		</script>
<%
		}
		else {
%>
		<script>
		alert("정보 수정에 성공했습니다.");
		</script>
<%			
		}
		
	} catch(SQLException e) {
		e.printStackTrace();
	}
%>
<script>
	document.location.href="member_info.jsp";
</script>