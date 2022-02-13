<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<% Member nUserLogin = (Member)session.getAttribute("loginUser"); %>
<%if(nUserLogin != null){ %>

<%
String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
String user = "root";
String userPass = "1234";

Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;

try{
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url,user,userPass);
	
	String sql = "select * from member where delYN = 'n' and black ='n'";
	
	psmt = conn.prepareStatement(sql);
	
	rs = psmt.executeQuery();
	
	if(rs.next()){
		
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
<title>유모차[당신이 찾는 모든 차]-마이페이지</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	#userInfo{
		margin : auto;
		width : 500px;
		position : relative;
		left : 40px;
		top : 60px;
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
		<article>
			<div id="userInfo">
				<div>
					아이디<br>
					<div><%=nUserLogin.getId() %></div>
				</div>
				<div>
					비밀번호<br>
					<div></div>
				</div>
				<div>
					이름<br>
					<div><%=nUserLogin.getName() %></div>
				</div>
				<div>
					주소<br>
					<div><%=nUserLogin.getAddr() %></div>
				</div>
				<div>
					연락처<br>
					<div><%=nUserLogin.getPhone() %></div>
				</div>
				<div>
					E-Mail<br>
					<div><%=nUserLogin.getEmail() %></div>
				</div>
				<div>
					<input type="button" value="정보 수정">
				</div>
			</div>
		</article>
	</section>
</body>
</html>
<%}else{
	response.sendRedirect(request.getContextPath()+"/index.jsp");
}
%>