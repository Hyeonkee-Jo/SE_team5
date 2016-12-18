<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.Random" %>

<%
    String DRIVER = "oracle.jdbc.driver.OracleDriver";
    String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER"; 
    String USER = "SE";
    String PASS = "SE";

   	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
    boolean isPNExist = false;
    boolean flag = true;
    String phone_num = request.getParameter("phone_number");
    String reserve_num = request.getParameter("reservationNumber");
    String userId = (String)session.getAttribute("userId");
    String cinemaRegion = request.getParameter("cinemaRegion");
    String theaterName = request.getParameter("theaterName");
    String startTime = request.getParameter("startTime");
    int cost = Integer.parseInt(request.getParameter("price"));
    String payment_number = "";
    String payment_plan = request.getParameter("credit_method");
	int seatCount = Integer.parseInt(request.getParameter("seatCount"));
	
	%>
<p><%out.print(userId);%></p>
<p><%out.print(cinemaRegion);%></p>
<p><%out.print(theaterName);%></p>
<p><%out.print(startTime);%></p>
<p><%out.print(cost);%></p>
<p><%out.print(reserve_num);%></p>
	<%
	for(int i = 0; i < seatCount; i++) {
		int row = Integer.parseInt(request.getParameter("row"+i));
		int column = Integer.parseInt(request.getParameter("column"+i));
		%>
		<p><%out.print(row+","+column);%></p>
		<%
	}
    Connection conn = null;
    PreparedStatement pstmt;
    ResultSet rs;
    
    try{
		Class.forName(DRIVER);
		conn = DriverManager.getConnection(URL,USER,PASS);
    }catch(Exception e){
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
        String query = "INSERT INTO RESERVATION VALUES('"+reserve_num+"',"+ cost+", TO_DATE(SYSDATE, 'YY/MM/DD/HH24/MI'), '"+userId+"', '"+cinemaRegion +"', '"+theaterName+"', TO_DATE('"+startTime+"', 'YY/MM/DD/HH24/MI'), '" +payment_number+"')";
        rs = stmt.executeQuery(query);
    } catch (Exception e) {
        %><script>alert("Reservation table is not created");</script><%
        System.out.println(e.getMessage());
    }  
    
	
	for(int i = 0; i < seatCount; i++) {
		int row = Integer.parseInt(request.getParameter("row"+i));
		int column = Integer.parseInt(request.getParameter("column"+i));
		
		try {
        Statement stmt = conn.createStatement();
        String query = "INSERT INTO RESERVED_SEAT VALUES('"+reserve_num+"', "+row+", "+column+")";
        rs = stmt.executeQuery(query);
        %><script>
        alert("결제가 완료되었습니다.");
        </script><%
		} catch (Exception e) {
			%><script>alert("Reservation_seat table is not created");
			System.out.println(e.getMessage());</script><%
		}
	}		

%>

<script>
	document.location.href="movie_list.jsp";
</script>