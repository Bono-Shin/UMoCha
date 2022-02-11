<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
	//인기차량
	String cname = null;
	String image = null;
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	
	ArrayList<AdminCar> newCar = new ArrayList<>();
	ArrayList<String> arpopCarName = new ArrayList<>();
	ArrayList<String> arpopCarImg = new ArrayList<>();
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		//최신 차량
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
	
		//인기 차량
		sql = "select * from adminCar where delYN = 'n' order by hit desc";
		
		psmt = conn.prepareStatement(sql);
		
		rs2 = psmt.executeQuery();
		
		while(rs2.next()){
			cname = rs2.getString("cname");
			arpopCarName.add(cname);
			
			image = rs2.getString("image");
			arpopCarImg.add(image);
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
						<td><img src="<%=request.getContextPath()%>/image/그랜저광고.jpg" alt="그랜저광고" width="850px"></td>
					</tr>
				</table>
				<div id="b1">
					<div id="b1-1">GRANDUER</div>
					<div id="b1-2">성공을 새롭게 정의하다.</div>
				</div>
			</div>
		</article>
		<article class="pnCar">
			<div class="pCar">
				<table>
					<tbody>
						<tr>
							<td colspan="2"><b>인기차량</b></td>
						</tr>
						<%for(int i=0; i<2; i++){ %>
						<tr>
							<td width="210px" height="120px"><img src="<%=request.getContextPath()%>/image/<%=arpopCarImg.get(i)%>" alt="<%=arpopCarName.get(i)%>" width="200px"></td>
							<td width="190px"><a href="<%=request.getContextPath()%>/car/car.jsp?cname=<%=arpopCarName.get(i)%>"><%=arpopCarName.get(i)%></a></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div>
			<div class="nCar">
				<table>
					<tbody>
						<tr>
							<td colspan="2"><b>신규차량</b></td>
						</tr>
						<%for(int i=0; i<2; i++){ %>
						<tr>
							<td width="210px" height="120px"><img src="<%=request.getContextPath()%>/image/<%=newCar.get(i).getImage()%>" alt="<%=newCar.get(i).getCname()%>" width="200px"></td>
							<td width="190px"><a href="<%=request.getContextPath()%>/car/car.jsp?cname=<%=newCar.get(i).getCname()%>"><%=newCar.get(i).getCname()%></a></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div>
		</article>
	</section>
</body>
</html>