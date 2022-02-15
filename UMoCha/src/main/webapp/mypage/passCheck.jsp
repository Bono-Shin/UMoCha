<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<% Member nUserLogin = (Member)session.getAttribute("loginUser"); %>
<%if(nUserLogin != null){ %>

<%
	int midx = 	nUserLogin.getMidx();
	String pass = "";

	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from member where blackYN = 'n' and delYN = 'n' and midx = "+midx;
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			pass = rs.getString("password");
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
<title>비밀번호 확인</title>
<style>
	.pcheck{
		margin : auto;
		position : relative;
		top : 150px;
		left : 150px;
	}
	
	#pw{
		width : 250px;
		height : 35px;
	}
	
	#pwb{
		height : 40px;
	}
</style>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<form method="post">
		<div class="pcheck">
			비밀번호 확인<br>
			<input type="password" name="pass" id="pw">
			<input type="submit" value="확인" onclick="passOk(this);" id="pwb">
		</div>
	</form>
	<script>
		
		function passOk(obj){
			
			$.ajax({
				url : "passCheck2.jsp",
				type : "post",
				data : $("form").serialize(),
				success : function(data){
					if(data.trim() > 0){
						opener.document.location.href="userInfoModify.jsp";
						self.close();
					}
				}
			});
		}
	</script>
</body>
</html>

<%}else{
	response.sendRedirect(request.getContextPath()+"/index.jsp");
}
%>