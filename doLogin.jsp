<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>

<%
	String DRIVER = "oracle.jdbc.driver.OracleDriver";
	String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER";
	String USER = "SE";
	String PASS = "SE";
	
	String userId=request.getParameter("id_text");
	String userPwd=request.getParameter("pw_text");
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	
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
	
	String query ="SELECT CUSTOMER_PASSWORD FROM CUSTOMER WHERE CUSTOMER_ID = ?";
	pstmt = conn.prepareStatement(query);
	
	pstmt.setString(1, userId);
	
	try{
		rs = pstmt.executeQuery();
		
		rs.next();
		
		if(rs.getString(1).equals(userPwd)){
%>
			<script>
				document.location.href="main.jsp";
			</script>
<%
		}
		else{
%>
			<script>
				alert("패스워드가 일치하지 않습니다!");
				document.location.href="login.jsp";
			</script>
<%			
		}
	}
	catch(Exception e){
%>
		<script>
			alert("아이디가 존재하지 않습니다!");
			document.location.href="login.jsp";
		</script>
<%		
	}
%>