<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "UMoCha.*" %>
<% Member adminLogin = (Member)session.getAttribute("loginUser"); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]-관리자페이지</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	#adminAt{
		text-align : center;
	}

	#adminAt>div{
		width : 200px;
		height : 180px;
		border-radius : 5px;
		line-height : 180px;
		background-color : #5F9EA0;
		display : inline-block;
	}
	
	#adminAt>div:hover{
		cursor : pointer;
	}
	
	#adminAt>div:nth-child(1){
		position : relative;
		top : 100px;
		left : 30px;
	}
	
	#adminAt>div:nth-child(2){
		position : relative;
		top : 100px;
		left : 250px;
	}
	
	#adminAt>div:nth-child(3){
		position : relative;
		top : 350px;
		left : -381px;
	}
	
	#adminAt>div:nth-child(4){
		position : relative;
		top : 350px;
		left : -161px;
	}
</style>
</head>
<body>
	<% if(adminLogin != null){%>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
	<%@ include file = "/aside.jsp" %>
		<article id="adminAt">
			<div onclick="#">차량 등록</div>
			<div onclick="#">차량 업데이트</div>
			<div onclick="#">차량 삭제</div>
			<div onclick="#">회원 관리</div>
		</article>
	</section>
	<%
	}else{
		response.sendRedirect(request.getContextPath());
	}
	%>
</body>
</html>