<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%> 
<%@page import ="java.util.ArrayList"%>
<%@page import ="java.util.HashMap"%>
<%@page import ="java.util.Date"%>
<%@page import ="java.text.SimpleDateFormat"%>


<%
	
	//String region =request.getParameter("cinemaRegion");
	//String theaterName = request.getParameter("theaterName");
	request.setCharacterEncoding("UTF-8");
	String region ="대전 궁동";
	String theaterName = "B1";
	int seatPrice=0;
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd/hh");
	Date today = new Date();
	
	String date = format.format(today);
	String[] todayArray = date.split("/");
	String tomorrow =String.valueOf(Integer.parseInt(todayArray[2])+1);
	String dayAfterTomorrow = String.valueOf(Integer.parseInt(todayArray[2])+2);
	
	
	ArrayList<String> timeList = new ArrayList<String>();
	ArrayList<String> movieList = new ArrayList<String>();
	HashMap<String, Integer> runningTime = new HashMap<String, Integer>();
	
	ArrayList<String> screening = new ArrayList<String>();
	
	String DRIVER = "oracle.jdbc.driver.OracleDriver";
	String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER";
	String USER = "SE";
	String PASS = "SE";
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	
	String[][] schedule = new String[3][24];
	
	
	try{
		Class.forName(DRIVER);
		conn = DriverManager.getConnection(URL,USER,PASS);
	}catch(Exception e){
		System.out.println(e.getMessage());
	}
	
	
	String query ="SELECT SEAT_PRICE FROM THEATER WHERE CINEMA_REGION = ? AND THEATER_NAME = ?";
	pstmt = conn.prepareStatement(query);
	
	pstmt.setString(1, region);
	pstmt.setString(2, theaterName);
	
	try{
		rs = pstmt.executeQuery();
		rs.next();
		seatPrice = rs.getInt(1);
	}
	catch(Exception e){}
	//여기까지 좌석 과격얻어왔음
	
	
	query = "SELECT TO_CHAR(START_TIME, 'YYYY/MM/DD/HH24'), MOVIE_TITLE FROM SCHEDULE WHERE CINEMA_REGION = ? AND THEATER_NAME = ? " ;
	pstmt = conn.prepareStatement(query);
	
	pstmt.setString(1, region);
	pstmt.setString(2, theaterName);
	
	//try{
		rs = pstmt.executeQuery();
		while(rs.next()){
			timeList.add(rs.getString(1));
			movieList.add(rs.getString(2));
		}
		
	//}catch(Exception e){}
	//여기까지 영화 이름, 상영 시작 시간 얻어온다.
	
	query = "SELECT MOVIE_TITLE FROM SCREENING WHERE CINEMA_REGION = ?";
	pstmt = conn.prepareStatement(query);	
	pstmt.setString(1, region);
	
	rs= pstmt.executeQuery();
	while(rs.next()){
		screening.add(rs.getString(1));
	}
	
	
	
	for(int i =0; i<movieList.size(); i++){
		query= "SELECT RUNNINGTIME FROM MOVIE WHERE MOVIE_TITLE= ?";
		pstmt = conn.prepareStatement(query);
	
		pstmt.setString(1, movieList.get(i));
		
		rs = pstmt.executeQuery();
		rs.next();
		
		runningTime.put(movieList.get(i), rs.getInt(1));
	}
	// 해쉬맵에 영화 이름을 key로 , runningTime이 value로 저장되있음
	int range=0;
	int hour=0;
	String day="";
	for(int i=0; i<timeList.size() ; i++){
		String time =timeList.get(i);
		day = time.substring(time.length()-5, time.length()-3);
		hour = Integer.parseInt(time.substring(time.length()-2, time.length()));
		
		range = runningTime.get(movieList.get(i)) / 60;
		if( (runningTime.get(movieList.get(i)) % 60) != 0)
			range+=1;
			
		if(day.equals(todayArray[2])){
			
			for(int j=0; j<range&& (hour+j<24); j++){
				schedule[0][hour+j]=movieList.get(i);
			}
		}
		else if(day.equals(tomorrow)){
			for(int j=0; j<range && (hour+j<24); j++){
				schedule[1][hour+j]=movieList.get(i);
			}
		}
		else if(day.equals(dayAfterTomorrow)){
			for(int j=0; j<range && (hour+j<24); j++){
				schedule[2][hour+j]=movieList.get(i);
			}
		}
	}
	

%>


<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/detail.css">
</head>
<body>

    <form id="aboutPrice" action="modify_seatPrice.jsp">
        가격
        <input type="text" name="region", style="visibility : hidden" value="<%out.print(region);%>"
		<input type="text" name="theaterName", style="visibility : hidden" value="<%out.print(theaterName);%>"
		<input type="text" name="mPrice" style="width: 100px" value="<%out.print(seatPrice);%>">
        <button type="submit">수정</button>
    </form>
	
	
    <p id="timeTable_text">시간표</p>
    <table id="timeTable">
        <tr>
            <td></td>
            <td id="first"><%out.print(todayArray[2]+"일");%></td>
            <td id="second"><%out.print(tomorrow+"일");%></td>
            <td id="third"><%out.print(dayAfterTomorrow+"일");%></td>
        </tr>
		<tr>
            <td>0</td>
            <td><%if(schedule[0][0]!=null)out.print(schedule[0][0]);%></td>
            <td><%if(schedule[1][0]!=null)out.print(schedule[1][0]);%></td>
            <td><%if(schedule[2][0]!=null)out.print(schedule[2][0]);%></td>
        </tr>
        <tr>
            <td>1</td>
            <td><%if(schedule[0][1]!=null)out.print(schedule[0][1]);%></td>
            <td><%if(schedule[1][1]!=null)out.print(schedule[1][1]);%></td>
            <td><%if(schedule[2][1]!=null)out.print(schedule[2][1]);%></td>
        </tr>
        <tr>
            <td>2</td>
            <td><%if(schedule[0][2]!=null)out.print(schedule[0][2]);%></td>
            <td><%if(schedule[1][2]!=null)out.print(schedule[1][2]);%></td>
            <td><%if(schedule[2][2]!=null)out.print(schedule[2][2]);%></td>
        </tr>
        <tr>
            <td>3</td>
            <td><%if(schedule[0][3]!=null)out.print(schedule[0][3]);%></td>
            <td><%if(schedule[1][3]!=null)out.print(schedule[1][3]);%></td>
            <td><%if(schedule[2][3]!=null)out.print(schedule[2][3]);%></td>
        </tr>
        <tr>
            <td>4</td>
            <td><%if(schedule[0][4]!=null)out.print(schedule[0][4]);%></td>
            <td><%if(schedule[1][4]!=null)out.print(schedule[1][4]);%></td>
            <td><%if(schedule[2][4]!=null)out.print(schedule[2][4]);%></td>
        </tr>
        <tr>
            <td>5</td>
            <td><%if(schedule[0][5]!=null)out.print(schedule[0][5]);%></td>
            <td><%if(schedule[1][5]!=null)out.print(schedule[1][5]);%></td>
            <td><%if(schedule[2][5]!=null)out.print(schedule[2][5]);%></td>
        </tr>
        <tr>
            <td>6</td>
            <td><%if(schedule[0][6]!=null)out.print(schedule[0][6]);%></td>
            <td><%if(schedule[1][6]!=null)out.print(schedule[1][6]);%></td>
            <td><%if(schedule[2][6]!=null)out.print(schedule[2][6]);%></td>        </tr>
        <tr>
            <td>7</td>
            <td><%if(schedule[0][7]!=null)out.print(schedule[0][7]);%></td>
            <td><%if(schedule[1][7]!=null)out.print(schedule[1][7]);%></td>
            <td><%if(schedule[2][7]!=null)out.print(schedule[2][7]);%></td>
        </tr>
        <tr>
            <td>8</td>
            <td><%if(schedule[0][8]!=null)out.print(schedule[0][8]);%></td>
            <td><%if(schedule[1][8]!=null)out.print(schedule[1][8]);%></td>
            <td><%if(schedule[2][8]!=null)out.print(schedule[2][8]);%></td>
        </tr>
        <tr>
            <td>9</td>
            <td><%if(schedule[0][9]!=null)out.print(schedule[0][9]);%></td>
            <td><%if(schedule[1][9]!=null)out.print(schedule[1][9]);%></td>
            <td><%if(schedule[2][9]!=null)out.print(schedule[2][9]);%></td>
        </tr>
        <tr>
            <td>10</td>
            <td><%if(schedule[0][10]!=null)out.print(schedule[0][10]);%></td>
            <td><%if(schedule[1][10]!=null)out.print(schedule[1][10]);%></td>
            <td><%if(schedule[2][10]!=null)out.print(schedule[2][10]);%></td>
        </tr>
        <tr>
            <td>11</td>
            <td><%if(schedule[0][11]!=null)out.print(schedule[0][11]);%></td>
            <td><%if(schedule[1][11]!=null)out.print(schedule[1][11]);%></td>
            <td><%if(schedule[2][11]!=null)out.print(schedule[2][11]);%></td>
        </tr>
        <tr>
            <td>12</td>
            <td><%if(schedule[0][12]!=null)out.print(schedule[0][12]);%></td>
            <td><%if(schedule[1][12]!=null)out.print(schedule[1][12]);%></td>
            <td><%if(schedule[2][12]!=null)out.print(schedule[2][12]);%></td>
        </tr>
        <tr>
            <td>13</td>
            <td><%if(schedule[0][13]!=null)out.print(schedule[0][13]);%></td>
            <td><%if(schedule[1][13]!=null)out.print(schedule[1][13]);%></td>
            <td><%if(schedule[2][13]!=null)out.print(schedule[2][13]);%></td>
        </tr>
        <tr>
            <td>14</td>
            <td><%if(schedule[0][14]!=null)out.print(schedule[0][14]);%></td>
            <td><%if(schedule[1][14]!=null)out.print(schedule[1][14]);%></td>
            <td><%if(schedule[2][14]!=null)out.print(schedule[2][14]);%></td>
        </tr>
        <tr>
            <td>15</td>
            <td><%if(schedule[0][15]!=null)out.print(schedule[0][15]);%></td>
            <td><%if(schedule[1][15]!=null)out.print(schedule[1][15]);%></td>
            <td><%if(schedule[2][15]!=null)out.print(schedule[2][15]);%></td>
        </tr>
        <tr>
            <td>16</td>
            <td><%if(schedule[0][16]!=null)out.print(schedule[0][16]);%></td>
            <td><%if(schedule[1][16]!=null)out.print(schedule[1][16]);%></td>
            <td><%if(schedule[2][16]!=null)out.print(schedule[2][16]);%></td>
        </tr>
        <tr>
            <td>17</td>
            <td><%if(schedule[0][17]!=null)out.print(schedule[0][17]);%></td>
            <td><%if(schedule[1][17]!=null)out.print(schedule[1][17]);%></td>
            <td><%if(schedule[2][17]!=null)out.print(schedule[2][17]);%></td>
        </tr>
        <tr>
            <td>18</td>
            <td><%if(schedule[0][18]!=null)out.print(schedule[0][18]);%></td>
            <td><%if(schedule[1][18]!=null)out.print(schedule[1][18]);%></td>
            <td><%if(schedule[2][18]!=null)out.print(schedule[2][18]);%></td>
        </tr>
        <tr>
            <td>19</td>
            <td><%if(schedule[0][19]!=null)out.print(schedule[0][19]);%></td>
            <td><%if(schedule[1][19]!=null)out.print(schedule[1][19]);%></td>
            <td><%if(schedule[2][19]!=null)out.print(schedule[2][19]);%></td>
        </tr>
        <tr>
            <td>20</td>
            <td><%if(schedule[0][20]!=null)out.print(schedule[0][20]);%></td>
            <td><%if(schedule[1][20]!=null)out.print(schedule[1][20]);%></td>
            <td><%if(schedule[2][20]!=null)out.print(schedule[2][20]);%></td>
        </tr>
        <tr>
            <td>21</td>
            <td><%if(schedule[0][21]!=null)out.print(schedule[0][21]);%></td>
            <td><%if(schedule[1][21]!=null)out.print(schedule[1][21]);%></td>
            <td><%if(schedule[2][21]!=null)out.print(schedule[2][21]);%></td>
        </tr>
        <tr>
            <td>22</td>
            <td><%if(schedule[0][22]!=null)out.print(schedule[0][22]);%></td>
            <td><%if(schedule[1][22]!=null)out.print(schedule[1][22]);%></td>
            <td><%if(schedule[2][22]!=null)out.print(schedule[2][22]);%></td>
        </tr>
        <tr>
            <td>23</td>
            <td><%if(schedule[0][23]!=null)out.print(schedule[0][23]);%></td>
            <td><%if(schedule[1][23]!=null)out.print(schedule[1][23]);%></td>
            <td><%if(schedule[2][23]!=null)out.print(schedule[2][23]);%></td>
        </tr>
        
    </table>
    
    <form id="registF" name="add_schedule.jsp">
    
		<input type="text" name="region", style="visibility : hidden" value="<%out.print(region);%>">
		<input type="text" name="theaterName", style="visibility : hidden" value="<%out.print(theaterName);%>">
	
		<select id="select_movie" name="whatMovie" >
			<option value="" >영화선택</option>
			<%
			for(int i=0 ; i<screening.size();i++){
				out.print("<option value='"+screening.get(i)+"'>"+screening.get(i)+"</option>");
			}
			
			
			%>
		</select>
        
        <select id="select_time" name="choiceDay" >
			<option value="" >날짜 선택</option>
			
			<option value="<%out.print(todayArray[2]);%>">오늘</option>
			<option value="<%out.print(tomorrow);%>">내일</option>
			<option value="<%out.print(dayAfterTomorrow);%>">모레</option>
		</select>
		
		
        <select id="select_time" name="choiceTime" >
			<option value="" >시간 선택</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="2">3</option>
			<option value="2">4</option>
			<option value="2">5</option>
			<option value="2">6</option>
			<option value="2">7</option>
			<option value="2">8</option>
			<option value="2">9</option>
			<option value="2">10</option>
			<option value="2">11</option>
			<option value="2">12</option>
			<option value="2">13</option>
			<option value="2">14</option>
			<option value="2">16</option>
			<option value="2">17</option>
			<option value="2">18</option>
			<option value="2">19</option>
			<option value="2">20</option>
			<option value="2">21</option>
			<option value="2">22</option>
			<option value="2">23</option>
		</select>
		
        
        <button type="submit">등록</button>
    </form>
	
    <form id="deleteF" action= "delete_schedule.jsp">
		<input type="text" name="region", style="visibility : hidden" value="<%out.print(region);%>">
		<input type="text" name="theaterName", style="visibility : hidden" value="<%out.print(theaterName);%>">
		
        <select id="select_time" name="selectedSchedule" >
			
			<option value="" >스케쥴 선택</option>
			<%
			for(int i=0; i<timeList.size(); i++){
				String tmpDay = timeList.get(i).substring(timeList.get(i).length()-5, timeList.get(i).length()-3);
				
				if(Integer.parseInt(todayArray[2])<=Integer.parseInt(tmpDay))
					out.print("<option value='"+timeList.get(i)+"' >"+timeList.get(i)+"</option>");
			}
			%>
		</select>	
        
        <button type="submit">삭제</button>
    </form>
    
</body>
</html>