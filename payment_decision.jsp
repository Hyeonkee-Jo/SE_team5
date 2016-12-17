<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.Random" %>

<%
   String DRIVER = "oracle.jdbc.driver.OracleDriver";
   String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER"; 
   String USER = "SE";
   String PASS = "SE";

   boolean isPNExist = false;
   boolean flag = true;
   String phone_num = request.getParameter("phone_number");
   // 값 넣어준 것은 다 값 받아와야되는 것들 (request 하지 않은 부분)
   int cost = 10000;
   String userId = "jo"; 
   String reserve_num = "R2003";
   String cinema_region = "DJ";
   String theater_name = "B1";
   String start_time; // 'YY/MM/DD/HH24/MI'의 형태로 받기
   String payment_number = "";
   String payment_plan = request.getParameter("credit_method");
   int seat_row = 1;
   int seat_column = 3;
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
   
   if(payment_plan.equals("PHONE")) {
        try {
        Statement stmt = conn.createStatement();  
        String query = "SELECT * FROM CUSTOMER WHERE CUSTOMER_ID = '" + userId + "'";
        rs = stmt.executeQuery(query);
        rs.next();
        
        if(!phone_num.equals(rs.getString(5))) {
            %><script>
                alert("휴대폰 번호가 다릅니다.");
                document.location.href ="payment.jsp";
        </script><%
        }

        } catch (Exception e) {
        %><script>alert("aa");</script><%
        System.out.println(e.getMessage());
        }
   }
                                         
   while(flag) {
        try {
            Statement stmt = conn.createStatement();  
            String query = "SELECT PAYMENT_NUMBER FROM PAYMENT";
            rs = stmt.executeQuery(query);

            Random random = new Random();
            int rand_num = random.nextInt(10000);
        
            if(rand_num < 10 ) {
                payment_number = "P000" + String.valueOf(rand_num);
            }
            else if(rand_num < 100 ) {
                payment_number = "P00" + String.valueOf(rand_num);
            }
            else if(rand_num < 1000 ) {
                payment_number = "P0" + String.valueOf(rand_num);
            }
            else {
                payment_number = "P" + String.valueOf(rand_num);
            }
                                     
            while(rs.next()) {
                if(payment_number.equals(rs.getString(1))) {
                    isPNExist = true;
                    break;
                }
            }
            if(isPNExist == false) {
                try {
                    Statement statement = conn.createStatement(); 
                    String qry = "INSERT INTO PAYMENT VALUES('" + payment_number + "', '" + payment_plan +"')";
                    rs = statement.executeQuery(qry);
                    flag = false;
                } catch(Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        } catch (Exception e) {
        %><script>alert("ab");</script><%
        System.out.println(e.getMessage());
        }
    }   
    
                                          
    try {
        Statement stmt = conn.createStatement();
        String query = "INSERT INTO RESERVATION VALUES('"+reserve_num+"',"+ cost+", TO_DATE(SYSDATE, 'YY/MM/DD/HH24/MI'), '"+userId+"', '"+cinema_region +"', '"+theater_name+"', TO_DATE('16/12/12/12/30', 'YY/MM/DD/HH24/MI'), '" +payment_number+"')";
        rs = stmt.executeQuery(query);
    } catch (Exception e) {
        %><script>alert("Reservation table is not created");
            document.location.href ="payment.jsp";</script><%
        System.out.println(e.getMessage());
    }  
    
     try {
        Statement stmt = conn.createStatement();
        String query = "INSERT INTO RESERVED_SEAT VALUES('"+reserve_num+"', "+seat_row+", "+seat_column+")";
        rs = stmt.executeQuery(query);
        %><script>
        alert("결제가 완료되었습니다.");
        document.location.href ="payment.jsp";
        </script><%
    } catch (Exception e) {
        %><script>alert("Reservation_seat table is not created");
            document.location.href ="payment.jsp";</script><%
        System.out.println(e.getMessage());
    }  
%>