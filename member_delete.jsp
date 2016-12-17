<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>

<%
   String DRIVER = "oracle.jdbc.driver.OracleDriver";
   String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER"; 
   String USER = "SE";
   String PASS = "SE";
    
   
   String userId = request.getParameter("del_id");

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
        
        String query = "DELETE FROM CUSTOMER WHERE CUSTOMER_ID = '" + userId +"'";
        rs = stmt.executeQuery(query);
   

   } catch (Exception e) {
   %><script>alert("aa");</script><%
        System.out.println(e.getMessage());
   }
%>
    <script>
        alert("해당 회원이 삭제되었습니다.");
        document.location.href ="member_management.jsp";
    </script>
    