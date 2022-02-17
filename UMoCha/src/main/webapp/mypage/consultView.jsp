<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<% Member UserLogin = (Member)session.getAttribute("loginUser"); %>
<% if(UserLogin != null){%>

<%
	String midx = request.getParameter("midx");
	String bidx = request.getParameter("bidx");
	String cname = "";
	String make = "";
	String id = "";
	String carColor = "";
	String carTrim = "";
	String carOpt = "";
	String carPrice = "";
	
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
		
		if(rs.next()){
			cname = rs.getString("cname");
			make = rs.getString("make");
			id = rs.getString("id");
			carColor = rs.getString("carColor");
			carTrim = rs.getString("carTrim");
			carOpt = rs.getString("carOpt");
			carPrice = rs.getString("carPrice");
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
<title>유모차[당신이 찾는 모든 차] - 상담신청 내역</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	#conViewTable{
		width : 800px;
		border-collapse : collapse;
	}
	
	#conViewTable>thead td{
		text-align : center;
	}
</style>
</head>
<body>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
		<%@ include file = "/aside.jsp" %>
		<article>
			<table border = "1" id="conViewTable">
				<thead>
					<tr>
						<th height="50px">번호</th>
						<td width = "50px"><%=bidx %></td>
						<th width = "50px">상담 차량</th>
						<td><%=cname %></td>
						<th width = "50px">제조사</th>
						<td><%=make %></td>
						<th width = "50px">신청인 ID</th>
						<td width = "150px"><%=id %></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th height="600px">내용</th>
						<td colspan="7">
							차종 : <%=cname %><br><br>
							트림 : <%=carTrim %><br><br>
							색상 : <%=carColor %><br><br>
							옵션 : <%=carOpt %><br><br>
							가격 : <%=carPrice %> 만원
						</td>
					</tr>
				</tbody>
			</table>
		</article>
	</section>
</body>
</html>
<%
	}else{
		response.sendRedirect(request.getContextPath());
	}
%>