<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*"%> 
<%@page import ="java.util.ArrayList"%>

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
	
	ArrayList<String> reservationNumberList = new ArrayList<String>();
	String customerId = (String)session.getAttribute("userId");
	String customerPw = "";
	String customerName = "";
	String address = "";
	String phoneNumber = "";
	String birthday = "";
	String eMail = "";
	String query = "SELECT * FROM CUSTOMER WHERE CUSTOMER_ID = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, customerId);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			customerPw = rs.getString(2);
			customerName = rs.getString(3);
			address = rs.getString(4);
			phoneNumber = rs.getString(5);
			birthday = rs.getString(6);
			eMail = rs.getString(7);
		}

			
	} catch (SQLException e) {
		e.printStackTrace();
	}
		
	query = "SELECT * FROM RESERVATION WHERE CUSTOMER_ID = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1, customerId);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			reservationNumberList.add(rs.getString(1));
		}
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>

<html>
<body>
<a href="movie_list.jsp" id="movie_tab">영화</a>
<a href="movie_reservation.jsp" id="reservation_tab">예매</a>
<a href="member_info.jsp" id="my_info_tab">내 정보</a>
<form method="post" action="update_customer.jsp" id="update_form">
	<input type="text" name="customerId" value="<%out.print(customerId);%>" style="display:none">
	<label for="password" id="password_label">비밀번호 : </label>
	<input type="text" id="password" name="password" value="<%out.print(customerPw);%>" required><br>
	<label for="name" id="name_label">이름 : </label>
	<input type="text" id="name" name="name" value="<%out.print(customerName);%>" required><br>
	<label for="address" id="address_label">주소 : </label>
	<input type="text" id="address" name="address" value="<%out.print(address);%>" required><br>
	<label for="phoneNumber" id="phoneNumber_label">전화번호 : </label>
	<input type="text" id="phoneNumber" name="phoneNumber" value="<%out.print(phoneNumber);%>" required><br>
	<label for="birthday" id="birthday_label">생년월일 : </label>
	<input type="text" id="birthday" name="birthday" value="<%out.print(birthday);%>" required><br>
	<label for="eMail" id="eMail_label">이메일 : </label>
	<input type="text" id="eMail" name="eMail" value="<%out.print(eMail);%>" required><br>
</form> 
<form method="post" action="delete_customer.jsp" id="delete_form">
	<input type="text" name="customerId" value="<%out.print(customerId);%>" style="display:none">
</form>
<form method="post" action="reservation_detail.jsp">
	<ol type>
		<lh>예매 내역</lh>
		<%for(String reservationNumber : reservationNumberList) {%>
		<li>
			<button type="submit" name="reservationNumber" value="<%out.print(reservationNumber);%>">
				<%out.println(reservationNumber);%>
			</button>
		</li>
		<%}%>
	</ol>
</form>
<button type = "submit" form="update_form"> 수 정 </button>
<button type = "submit" form="delete_form"> 회원탈퇴 </button>
<button type = "button" onClick="history.back()"> 취 소 </button>

</body>
</html>