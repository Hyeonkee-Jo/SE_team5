<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.net.*"%>

<%
   String DRIVER = "oracle.jdbc.driver.OracleDriver";
   String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER"; 
   String USER = "SE";
   String PASS = "SE";
     
   String userId = request.getParameter("usr_id");
   String userPwd ="";//rs.getString(2);
   String userName ="";//rs.getString(3);
   String userAddr ="";//rs.getString(4);
   String userPN = "";//rs.getString(5);
   String userBirth = "";//rs.getString(6);
   String userEmail = "";//rs.getString(7);

   session.setAttribute("old_id", userId);
   
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
   
   try {
        Statement stmt = conn.createStatement();
        String query = "SELECT * FROM CUSTOMER WHERE CUSTOMER_ID = '" + userId + "'";
        rs = stmt.executeQuery(query);

        rs.next();
        userPwd =rs.getString(2);
        userName =rs.getString(3);
        userAddr =rs.getString(4);
        userPN = rs.getString(5);
        userBirth = rs.getString(6);
        userEmail = rs.getString(7);

   } catch (Exception e) {  
        System.out.println(e.getMessage());
   }
%>
    


<!DOCTYPE html>
<html>
<body>
<form action = "member_modify.jsp" method = "post">
    <p>I D <input type = "text" name = "u_id" value="<%out.print(userId);%>" required><br></p>
    <p>비밀번호<input type = "text" name = "u_password" value="<%out.print(userPwd);%>" required><br></p>
    <p> 이 름 <input type = "text" name = "u_name" value="<%out.print(userName);%>" required><br></p>
    <p>휴대폰 번호 <input type = "text" name = "u_phonenumber" value="<%out.print(userPN);%>" required><br></p>
    <p>주 소 <input type = "text" name = "u_address" value="<%out.print(userAddr);%>" required><br></p>
    <p>생년월일 <input type = "text" name = "u_birth" value="<%out.print(userBirth);%>" required><br></p>
    <p>메일주소<input type = "text" name = "u_e-address" value="<%out.print(userEmail);%>" required><br></p>
    <button type = "submit"> 수 정 </button>
    
    <button type = "submit" formaction="member_delete.jsp" name = "del_id" value = "<%out.print(userId);%>"> 삭 제 </button>
    
    <a href="member_management.jsp" target="_self">
        <button type = "button"> 취소 </button>
    </a>
</form>
</body>
</html>