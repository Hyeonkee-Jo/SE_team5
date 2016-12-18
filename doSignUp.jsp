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
	String userPhone = request.getParameter("phone_text");
	String userName = request.getParameter("name_text");
	String userMail = request.getParameter("mail_text");
	String userEmail = request.getParameter("email_text");
	String userBirth = request.getParameter("birth_text");
	String userAddress = request.getParameter("address_text");

	boolean aleadyExist = false;
	boolean success = false;
	
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
	
	String query ="SELECT CUSTOMER_ID FROM CUSTOMER WHERE CUSTOMER_ID = ?";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, userId);
	
	try{
		rs = pstmt.executeQuery();	
		rs.next();				//같은 아이디가 존재하는지 한번 확인해본다
		rs.getString(1);
		aleadyExist = true;
	}
	catch(Exception e){
		query = "INSERT INTO CUSTOMER VALUES( ? , ? , ? , ? , ? , ? , ?,'X')";
		pstmt =conn.prepareStatement(query);
		pstmt.setString(1, userId);
		pstmt.setString(2, userPwd);
		pstmt.setString(3, userName);
		pstmt.setString(4, userAddress);
		pstmt.setString(5, userPhone);
		pstmt.setString(6, userBirth);
		pstmt.setString(7, userEmail);
		
		try{
			rs = pstmt.executeQuery();
			success = true;
		}
		catch(Exception a){
			
		}
	}
	if(aleadyExist){
%>
		<script>alert("이미 해당 아이디가 존재합니다!");</script>
		<script> 
		document.location.href="login.jsp";
		</script>
<%		
	}
	if(success){
%>
		<script> 
		alert("회원가입 완료!"); 
		document.location.href="login.jsp";
		</script>
<%		
	}
	
%>