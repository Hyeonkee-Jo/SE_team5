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
    <head>
        <style>
        ul.mylist li, ol.mylist li {
            padding: 5px 0px 5px 5px;
            margin-bottom: 5px;
            border-bottom: 1px solid #efefef;
            font-size: 12px;
            }
        </style>
    </head>
<body>
	<a href="manage_movie.jsp" id="movie_tab">영화</a>
    <a href="manage_cinema.jsp" id="reservation_tab">영화관</a>
    <a href="member_management.jsp" id="my_info_tab">회원정보</a>
    <ol type class="mylist">
    <lh>회원 목록</lh>
    <%
       while(rs.next()) {
    %>
    <form action = "member_detail.jsp" style="margin-top:10px;">
        <li >
         <a href="member_detail.jsp?usr_id=<%out.print(rs.getString(1));%>"><%out.print(rs.getString(1));%></a>
		</li>
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