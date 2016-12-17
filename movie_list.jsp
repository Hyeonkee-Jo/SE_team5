<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
		
		try {
			DatabaseMetaData meta = conn.getMetaData();
			System.out.println("time data: " + meta.getTimeDateFunctions());
			System.out.println("user: " + meta.getUserName());
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		
		ArrayList<String> movieTitleList = new ArrayList<String>();
		ArrayList<String> imgTitleList = new ArrayList<String>();
		
		
		String query = "SELECT MOVIE_TITLE, IMG_NAME FROM MOVIE";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		
		while(rs.next()) {
			movieTitleList.add(rs.getString(1));
			imgTitleList.add(rs.getString(2));
		}
		//어레이 리스트에 영화이름이 들어간 상태.
		
		int imgNum=1;
%>

<html>
    <head>
        <link rel="stylesheet" href="css/movie_list.css">
		<script>
			function movInfo(title){
				document.location.href="movie_info.jsp?movie_title="+title;
			}
		</script>

	</head>
    <body>
        <a href="movie_list.jsp" id="movie_tab">영화</a>
        <a href="movie_reservation.jsp" id="reservation_tab">예매</a>
        <a href="" id="my_info_tab">내 정보</a>
        <br>
		
		<table>
<%
			for(int i =0 ; i < movieTitleList.size(); i++){
				
				if(imgNum==1){
%>
			<tr>
			<td>
				<img src="images/<%out.print(imgTitleList.get(i));%>.jpg" alt="movie1" style="width:200px;height:300px;" onclick='movInfo("<%out.print(imgTitleList.get(i));%>")' >
				<br>
			</td>
<%
					imgNum++;
				}
				else if(imgNum==2){
%>
			<td>
				<img src="images/<%out.print(imgTitleList.get(i));%>.jpg" alt="movie1" style="width:200px;height:300px;" onclick='movInfo("<%out.print(imgTitleList.get(i));%>")' >
				<br>
			</td>

<%					imgNum++;
				}
				else if(imgNum==3){
%>
			<td>
				<img src="images/<%out.print(imgTitleList.get(i));%>.jpg" alt="movie1" style="width:200px;height:300px;" onclick='movInfo("<%out.print(imgTitleList.get(i));%>")' >
				<br>
			</td>

<%					imgNum++;
				}
				else if(imgNum==4){
%>
			<td>
				<img src="images/<%out.print(imgTitleList.get(i));%>.jpg" alt="movie1" style="width:200px;height:300px;" onclick='movInfo("<%out.print(imgTitleList.get(i));%>")' >
				<br>
			</td>
			</tr>

<%					imgNum=1;	
				}
				if(i == movieTitleList.size()-1){
%>
			</tr>
<%					
				}
			}

%>	
		
		</table>
		
    </body>
</html>