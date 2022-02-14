<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<% Member nUserLogin = (Member)session.getAttribute("loginUser"); %>
<%if(nUserLogin != null){ %>  

<%
	int midx = nUserLogin.getMidx();
	String id = "";
	String name = "";
	String addr = "";
	String phone = "";
	String email = "";
	
	ArrayList<String> arUser = new ArrayList<>();

	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from member where delYN = 'n' and blackYN ='n' and midx = "+midx;
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			id = rs.getString("id");
			arUser.add(id);
			
			name = rs.getString("name");
			arUser.add(name);
			
			addr = rs.getString("addr");
			arUser.add(addr);
			
			phone = rs.getString("phone");
			arUser.add(phone);
			
			email = rs.getString("email");
			arUser.add(email);
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
<title>유모차[당신이 찾는 모든 차]-정보 수정</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	#userInfo{
		margin : auto;
		width : 500px;
		position : relative;
		left : 60px;
		top : 80px;
	}
	
	.infoSubD:not(.infoD){
		margin-bottom : 30px;
		font-size : 1.3em;
		font-weight : bold;
		color : #A0A0A0;
	}
	
	.infoD{
		font-size : 1.1em;
		font-weight : normal;
		color : black;
		margin-top : 10px;
	}
	
	.infoModi{
		width : 150px;
		height : 50px;
	}
</style>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<body>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
	<%@ include file = "/aside.jsp" %>
	<%@ include file = "/userAsideLeft.jsp" %>
		<form>
			<article>
				<div id="userInfo">
					<div class="infoSubD">
						[아이디]<br>
						<input type="text" name="id" value="<%=arUser.get(0)%>" disabled>
					</div>
					<div class="infoSubD">
						[비밀번호]<br>
						<input type="password" name="pass">
					</div>
					<div class="infoSubD">
						[이름]<br>
						<input type="text" name="name" value="<%=arUser.get(1)%>" disabled>
					</div>
					<div class="infoSubD">
						[주소]<br>
						<input type="text" name="addr" value="<%=arUser.get(2)%>">
					</div>
					<div class="infoSubD">
						[연락처]<br>
						<input type="text" name="phone" value="<%=arUser.get(3)%>">
					</div>
					<div class="infoSubD">
						[E-Mail]<br>
						<input type="text" name="email" value="<%=arUser.get(4)%>">
					</div>
					<div>
						<input type="button" value="저장" class="infoModi" onclick="modi(this)">
					</div>
				</div>
			</article>
		</form>
	</section>
	<script>
		function modi(obj){
			window.open("<%=request.getContextPath()%>/mypage/passCheck.jsp","비밀번호 확인","width=500px, height=400px, left=750px, top=270px, scrollbars=no, resizable=yes");
		}
	</script>
</body>
</html>

<%}else{
	response.sendRedirect(request.getContextPath()+"/index.jsp");
}
%>