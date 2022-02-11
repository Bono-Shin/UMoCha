<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String cname = request.getParameter("cname");

	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	ArrayList<AdminCar> searchCar = new ArrayList<>();
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from adminCar where cname like '%"+cname+"%' and delYN = 'n'";
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		while(rs.next()){
			AdminCar adminCar = new AdminCar();
			
			adminCar.setBidx(rs.getString("bidx"));
			adminCar.setCname(rs.getString("cname"));
			adminCar.setMake(rs.getString("make"));
			adminCar.setImage(rs.getString("image"));
			adminCar.setPrice1(rs.getString("price1"));
			adminCar.setPrice2(rs.getString("price2"));
			
			searchCar.add(adminCar);
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
<title>유모차[당신이 찾는 모든 차]</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	.searchT{
		text-align : center;
		border-collapse : collapse;
	}
	
	.searchT>tbody>tr td{
		border : 1px solid black;
	}
	
	.searchT>thead>tr:not(:first-child)>th{
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
		<%if(cname != null && cname != "" && searchCar.size() > 0){ %>
					<%for (AdminCar ac : searchCar){ %>
			<table class="searchT">
				<thead>
					<tr>
						<th width="500px" height="300px" colspan="3"><img src="<%=request.getContextPath()%>/image/<%=ac.getImage()%>" alt="<%=ac.getCname() %>" width="500px"></th>
					</tr>
					<tr>
						<th width="300px" height="30">차량 이름</th>
						<th width="250px" height="30">제조사</th>
						<th width="250px" height="30">가격</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td height="50"><a href="<%=request.getContextPath()%>/car/car.jsp?cname=<%=ac.getCname()%>"><%=ac.getCname()%></a></td>
						<td height="50"><%=ac.getMake() %></td>
						<td height="50"><%=ac.getPrice1() %> ~ <%=ac.getPrice2() %>만원</td>
					</tr>
					<%} %>
				</tbody>
			</table>
		<%}else{ %>
			<article>
				<h4>검색 결과가 없습니다.</h4>
			</article>
		<%} %>
		</article>
	</section>
</body>
</html>