<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>

<%
   String DRIVER = "oracle.jdbc.driver.OracleDriver";
   String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER"; 
   String USER = "SE";
   String PASS = "SE";
     
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
  
   Statement stmt = conn.createStatement();
   String query = "SELECT CUSTOMER_ID FROM CUSTOMER WHERE IS_ADMIN = 'X'";
   rs = stmt.executeQuery(query);
%>

<!DOCTYPE html>
<html>
<body>
    <ol type>
    <lh>회원 목록</lh>
    <%
       while(rs.next()) {
    %>
    <form action = "member_detail.jsp">
        <li>
    <%
         out.print(rs.getString(1));
    %>
    <a href="member_detail.jsp" target="_self">
        <button type = "submit" name = "usr_id" value = "<%out.print(rs.getString(1));%>"> 상세 </button>
        </a></li>
        </form>
    <%    
        }
    } catch (Exception e) {      
        System.out.println(e.getMessage());
    }
    %>
        </ol>
</body>
</html>