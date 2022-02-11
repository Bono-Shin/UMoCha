<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<% Member insertCarLogin = (Member)session.getAttribute("loginUser"); %>

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
		
		String sql = "select * from adminCar where delYN = 'n'";
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		while(rs.next()){
			AdminCar adminCar = new AdminCar();
			
			adminCar.setBidx(rs.getString("bidx"));
			adminCar.setCname(rs.getString("cname"));
			adminCar.setMake(rs.getString("make"));
			
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
<title>유모차[당신이 찾는 모든 차]-차량리스트</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	#carListTit{
		position : relative;
		left : 80px;
		background-color : gray;
		width : 800px;
	}
	
	#carListAt{
		margin : auto;
		width : 500px;
	}
	
	#imgD{
		border : 1px solid black;
	}
	
	textarea{
		width : 500px;
		height : 100px;
	}
	
	.price{
		width : 130px;
	}
	
	#priceD{
		margin-bottom : 30px;
	}
	
	.allD{
		margin-bottom : 20px;
	}
	
	#inSub{
		width : 300px;
		height : 40px;
		position : relative;
		left : 90px;
	}
	
	select{
		width : 200px;
		height : 50px;
	}
	
	.t1{
		border : 1px solid black;
		border-collapse : collapse;
		text-align : center;
		font-size : 1.1em;
		position : relative;
		left : 30px;
		top : 30px;
	}
	
	.t1 th{
		border : 1px solid black;
		border-collapse : collapse;
	}
	
	.t1 td{
		border : 1px solid black;
		border-collapse : collapse;
	}
	
</style>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<% if(insertCarLogin != null){%>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
	<%@ include file = "/aside.jsp" %>
	<%@ include file = "/asideLeft.jsp" %>
		<article id="carListTit"><div><h2>차량 리스트</h2></div></article>
		<article id="carListAt">
			<table class="t1">
				<thead>
					<tr>
						<th width="70px" height="30">No</th>
						<th width="500px" height="30">차량 이름</th>
						<th width="250px" height="30">제조사</th>
						<th width="250px" height="30">수정/삭제</th>
					</tr>
				</thead>
				<tbody>
					<%for (AdminCar ac : carList){ %>
					<tr>
						<td height="50"><%=ac.getBidx() %></td>
						<td height="50"><a href="<%=request.getContextPath()%>/car/car.jsp?cname=<%=ac.getCname()%>"><%=ac.getCname()%></a></td>
						<td height="50"><%=ac.getMake() %></td>
						<td height="50">
							<input type="button" value="수정" onclick="location.href='<%=request.getContextPath()%>/mypage/modifyCar.jsp?cname=<%=ac.getCname()%>'">
							|
							<input type="button" value="삭제" onclick="del(this)">
						</td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</article>	
	</section>
	
		<script>
			
			function del(obj){
				var bidx = $(obj).parent().prev().prev().prev().html();
				console.log(bidx);
				
				if(confirm("정말 삭제 하시겠습니까?")){
					
					$.ajax({
						url : "delCar.jsp",
						type : "post",
						data : "bidx="+bidx,
						success : function(data){
							if(data.trim() > 0){
								$(obj).parent().parent().remove();
							}
						}
					});
				}
			}
				
		</script>

	<%
	}else{
		response.sendRedirect(request.getContextPath());
	}
	%>
</body>
</html>