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
	
	.sp{
		color : red;
		font-size : 0.6em;
		position : absolute;
	}
	
	.mInfo{
		width : 250px;
		height : 35px;
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
		<form method="post" action="infoUpdate.jsp">
			<article>
				<div id="userInfo">
					<div class="infoSubD">
						[아이디]<br>
						<input type="text" name="id" value="<%=arUser.get(0)%>" disabled class="mInfo">
						<input type="hidden" name="midx" value="<%=midx%>">
					</div>
					<div class="infoSubD">
						[비밀번호]<br>
						<input type="password" name="pass" class="mInfo"><br>
						<span class="sp"></span>
					</div>
					<div class="infoSubD">
						[이름]<br>
						<input type="text" name="name" value="<%=arUser.get(1)%>" disabled class="mInfo">
					</div>
					<div class="infoSubD">
						[주소]<br>
						<input type="text" name="addr" value="<%=arUser.get(2)%>" class="mInfo"><br>
						<span class="sp"></span>
					</div>
					<div class="infoSubD">
						[연락처]<br>
						<input type="text" name="phone" value="<%=arUser.get(3)%>" maxlength="11" placeholder="'-'빼고 입력해 주세요." class="mInfo"><br>
						<span class="sp"></span>
					</div>
					<div class="infoSubD">
						[E-Mail]<br>
						<input type="text" name="email" value="<%=arUser.get(4)%>" class="mInfo"><br>
						<span class="sp"></span>
					</div>
					<div>
						<input type="submit" value="저장" class="infoModi" onclick="infoModi(); return false;">
					</div>
				</div>
			</article>
		</form>
	</section>
	<script>
		var resultPass = true;
		var resultAddr = true;
		var resultPhone = true;
		var resultEmail = true;
		
		function infoModi(){
			//비밀번호
			reg = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{4,}$/;
			value = $("input[name='pass']").val();
			if(value == ""){
				resultPass = false;
			var html = "필수 입력 사항"
				$("input[name='pass']").next().next("span").html(html);
			}else if(!(reg.test(value))){
				resultPass = false;
				html = "알파벳+숫자+특수문자(최소 4자리)"
				$("input[name='pass']").next().next("span").html(html).css("color","red");
			}else if(reg.test(value)){
				resultPass = true;
				html = "사용 가능한 비밀번호 입니다."
				$("input[name='pass']").next().next("span").html(html).css("color","green");
			}
			
			//주소
			value = $("input[name='addr']").val();
			
			if(value == ""){
				resultAddr = false;
				html = "필수 입력 사항"
				$("input[name='addr']").next().next("span").html(html);
			}else{
				resultAddr = true;
				$("input[name='addr']").next().next("span").html("");
			}
			
			//연락처
			reg = /^[0-9]*$/;
			value = $("input[name='phone']").val();
			
			if(value == ""){
				resultPhone = false;
				html = "필수 입력 사항"
				$("input[name='phone']").next().next("span").html(html);
			}else if(!(reg.test(value))){
				resultPhone = false;
				html = "숫자만 사용가능"
				$("input[name='phone']").next().next("span").html(html);
			}else{
				resultPhone = true;
				$("input[name='phone']").next().next("span").html("");
			}
			
			//email
			reg = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
			value = $("input[name='email']").val();
			
			if(value == ""){
				resultEmail = false;
				html = "필수 입력 사항"
				$("input[name='email']").next().next("span").html(html);
			}else if(!(reg.test(value))){
				resultEmail = false;
				html = "email 형식이 다릅니다."
				$("input[name='email']").next().next("span").html(html);
			}else{
				resultEmail = true;
				$("input[name='email']").next().next("span").html("");
			}
			
			if(resultPass && resultAddr && resultPhone && resultEmail){
				document.frm.submit();
			}
		}
	</script>
</body>
</html>

<%}else{
	response.sendRedirect(request.getContextPath()+"/index.jsp");
}
%>