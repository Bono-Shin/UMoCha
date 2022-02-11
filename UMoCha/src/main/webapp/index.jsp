<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	
	ArrayList<AdminCar> newCar = new ArrayList<>();
	ArrayList<String> popCar = new ArrayList<>();
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from adminCar where delYN = 'n' order by cname desc";
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		while(rs.next()){
			AdminCar adminCar = new AdminCar();
			
			adminCar.setBidx(rs.getString("bidx"));
			adminCar.setCname(rs.getString("cname"));
			adminCar.setMake(rs.getString("make"));
			adminCar.setImage(rs.getString("image"));
			
			newCar.add(adminCar);
		}
	
		sql = "select * from adminCar where delYN = 'n'";
		
		psmt = conn.prepareStatement(sql);
		
		rs2 = psmt.executeQuery();
		
		while(rs2.next()){
			
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
		if(rs2 != null){
			rs2.close();
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file = "header.jsp" %>
	<%@ include file = "nav.jsp" %>
	<section>
		<%@ include file = "aside.jsp" %>
		<article>
			<div>
				<table class="banner1">
					<tr>
						<td>광고1</td>
					</tr>
				</table>
			</div>
		</article>
		<article class="pnCar">
			<div class="pCar">
				<table border="1">
					<tbody>
						<tr>
							<td colspan="2">인기차량</td>
						</tr>
						<%for(int i=0; i<2; i++){ %>
						<tr>
							<td><img src="<%=request.getContextPath()%>/image/<%=newCar.get(i).getImage()%>" alt="<%=newCar.get(i).getCname()%>" width="200px"></td>
							<td><%=newCar.get(i).getCname()%></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div>
			<div class="nCar">
				<table border="1">
					<tbody>
						<tr>
							<td colspan="2">신규차량</td>
						</tr>
						<%for(int i=0; i<2; i++){ %>
						<tr>
							<td><img src="<%=request.getContextPath()%>/image/<%=newCar.get(i).getImage()%>" alt="<%=newCar.get(i).getCname()%>" width="200px"></td>
							<td><%=newCar.get(i).getCname()%></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div>
		</article>
	</section>
</body>
</html>