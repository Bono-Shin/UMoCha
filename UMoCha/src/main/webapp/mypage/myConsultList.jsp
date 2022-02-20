<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<% Member UserLogin = (Member)session.getAttribute("loginUser"); %>
<% if(UserLogin != null){%>

<%
	String midx = request.getParameter("midx");
	String cname = "";
	String make = "";
	String id = "";
	
	ArrayList<String> arMidx = new ArrayList<>();
	ArrayList<String> arCname = new ArrayList<>();
	ArrayList<String> arMake = new ArrayList<>();
	ArrayList<String> arId = new ArrayList<>();

	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from consult c, member m where c.midx = m.midx and m.delYN = 'n' and c.midx = "+midx;
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		while(rs.next()){
			midx = String.valueOf(UserLogin.getMidx());
			arMidx.add(midx);
			
			cname = rs.getString("cname");
			arCname.add(cname);
			
			make = rs.getString("make");
			arMake.add(make);
			
			id = rs.getString("id");
			arId.add(id);
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
<title>유모차[당신이 찾는 모든 차]-나의 상담리스트</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	#consultTable{
		border : 1px solid black;
		border-collapse : collapse;
		margin : auto;
		text-align : center;
		width : 630px;
		position : relative;
		top : 100px;
	}
	
	#consultTable td{
		font-size : 1.2em;
		height : 50px;
	}
	
	#consultArticle{
		width : 600px;
		margin : auto;
		position : relative;
		top : 50px;
		right : 20px;
	}
	
	#notConsult{
		position : relative;
		top : 100px;
		left : 150px;
	}
</style>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
		<%@ include file = "/aside.jsp" %>
		<%@ include file = "/userAsideLeft.jsp" %>
		<article id="consultArticle">
			<h3>나의 상담 리스트</h3>
			<hr>
		</article>
		<article>
		<%if(arMidx.size() > 0){ %>
			<table id="consultTable" border="1">
				<thead>
					<tr>
						<th width="70px">번호</th>
						<th width="230px">상담 차량</th>
						<th width="130px">제조사</th>
						<th widht="200px">신청인 ID</th>
					</tr>
				</thead>
				<tbody>
				<%for(int i=0; i<arCname.size(); i++){ %>
					<tr>
						<td><%=i+1 %></td>
						<td><a href="<%=request.getContextPath()%>/mypage/consultView.jsp?midx=<%=arMidx.get(i) %>&bidx=<%=i+1%>"><%=arCname.get(i) %></a></td>
						<td><%=arMake.get(i) %></td>
						<td><%=arId.get(i) %></td>
					</tr>
				<%} %>
				</tbody>
			</table>
		<%}else{ %>
			<div id="notConsult">신청 내역이 없습니다.</div>
		<%} %>
		</article>
	</section>
</body>
</html>

<%
	}else{
		response.sendRedirect(request.getContextPath());
	}
%>