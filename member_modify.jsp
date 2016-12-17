<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.net.*"%>

<%
   String DRIVER = "oracle.jdbc.driver.OracleDriver";
   String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER"; 
   String USER = "SE";
   String PASS = "SE";
    
   
   String userId = request.getParameter("u_id");
   String userPwd = request.getParameter("u_password");
   String userName =URLDecoder.decode(request.getParameter("u_name"), "UTF-8");
   String userAddr =request.getParameter("u_address");
   String userPN = request.getParameter("u_phonenumber");
   String userBirth = request.getParameter("u_birth");
   String userEmail = request.getParameter("u_e-address");
   String oldId = (String)session.getAttribute("old_id");

   
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
         String query = "UPDATE CUSTOMER SET CUSTOMER_ID = '"+ userId + "', CUSTOMER_PASSWORD = '"+ userPwd + "', CUSTOMER_NAME = '" + userName + "', ADDRESS = '" + userAddr + "', PHONE_NUMBER = '"+ userPN + "', BIRTHDAY = '"+ userBirth + "', E_MAIL = '"+ userEmail + "' WHERE CUSTOMER_ID = '" + oldId +"'";
        rs = stmt.executeQuery(query);
   

   } catch (Exception e) {
   %><script>alert("aa");</script><%
        System.out.println(e.getMessage());
   }
%>
    
<script>
        alert("회원정보가 수정되었습니다.");
        document.location.href ="member_management.jsp";
</script>
