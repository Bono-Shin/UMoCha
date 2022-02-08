<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.util.*" %>

<%
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	ArrayList<AdminCar> carList = new ArrayList<>();
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from adminCar where make = '현대자동차'";
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		while(rs.next()){
			AdminCar adminCar = new AdminCar();
			
			adminCar.setBidx(rs.getString("bidx"));
			adminCar.setCname(rs.getString("cname"));
			adminCar.setPrice1(rs.getString("price1"));
			adminCar.setPrice2(rs.getString("price2"));
			adminCar.setImage(rs.getString("Image"));
			
			carList.add(adminCar);
		}
		

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null){
			conn.close();
		}
		if(psmt != null){
			conn.close();
		}
		if(rs != null){
			rs.close();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]-현대자동차</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	.ht1{
		border : 1px solid black;
		border-collapse : collapse;
		text-align : center;
		position : relative;
		left : 100px;
		top : 50px;
	}
	
	.ht1 th{
		border : 1px solid black;
	}
	
	.ht1 td{
		border : 1px solid black;
	}
</style>
</head>
<body>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
		<%@ include file = "/aside.jsp" %>
		<article>
			<table class="ht1">
				<thead>
					<tr>
						<th width="200px">사진</th>
						<th width="200px">차량명</th>
						<th	width="200px">차량 가격</th>
					</tr>
				</thead>
				<tbody>
					<%for(AdminCar ac : carList){ %>
					<tr>
						<td><img src="<%=request.getContextPath()%>/image/<%=ac.getImage()%>" alt="<%=ac.getCname()%>" width="200px"></td>
						<td><a href="<%=request.getContextPath()%>/car/car.jsp?bidx=<%=ac.getBidx()%>"><%=ac.getCname()%></a></td>
						<td><%=ac.getPrice1()%> ~ <%=ac.getPrice2() %>만원</td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</article>
	</section>
</body>
</html>