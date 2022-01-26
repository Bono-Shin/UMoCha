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
		top : 50px;
		left : 100px;
	}
	
	#adminAt>div:nth-child(2){
		position : relative;
		top : 50px;
		left : 300px;
	}
	
	#adminAt>div:nth-child(3){
		position : relative;
		top : 300px;
		left : -311px;
	}
	
	#adminAt>div:nth-child(4){
		position : relative;
		top : 300px;
		left : -111px;
	}
	
	#adminTit{
		position : relative;
		left : 80px;
		background-color : gray;
		width : 800px;
	}
</style>
</head>
<body>
	<% if(adminLogin != null){%>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
	<%@ include file = "/aside.jsp" %>
		<article id="adminTit"><div><h2>관리페이지</h2></div></article>
		<article id="adminAt">
			<div onclick="location.href='<%=request.getContextPath()%>/mypage/insertCar.jsp'">차량 등록</div>
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