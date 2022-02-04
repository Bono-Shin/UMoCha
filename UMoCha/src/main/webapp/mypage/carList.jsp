<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<% Member insertCarLogin = (Member)session.getAttribute("loginUser"); %>

<%
	int bidx = 0;
	String cname = "";
	String make = "";

	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from adminCar";
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		while(rs.next()){
			
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
			<table>
				<thead>
					<tr>
						<th>No</th>
						<th>차량 이름</th>
						<th>제조사</th>
					</tr>
				</thead>
				<tbody>
					<td></td>
					<td></td>
					<td></td>
				</tbody>
			</table>
		</article>
	</section>

	<%
	}else{
		response.sendRedirect(request.getContextPath());
	}
	%>
</body>
</html>