<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "UMoCha.*" %>
<% Member nUserLogin = (Member)session.getAttribute("loginUser"); %>
<%if(nUserLogin != null){ %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]-마이페이지</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	#nUserAt{
		text-align : center;
		font-size : 1.3em;
		font-weight : bold;
	}

	#nUserAt>div{
		width : 300px;
		height : 280px;
		border-radius : 5px;
		line-height : 280px;
		background-color : #5F9EA0;
		display : inline-block;
	}
	
	#nUserAt>div:hover{
		cursor : pointer;
	}
	
	#nUserAt>div:nth-child(1){
		position : relative;
		top : 100px;
		left : -60px;
	}
	
	#nUserAt>div:nth-child(2){
		position : relative;
		top : 100px;
		left : 60px;
	}
	
	#nUserTit{
		position : relative;
		left : 80px;
		background-color : gray;
		width : 800px;
	}
</style>
</head>
<body>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
	<%@ include file = "/aside.jsp" %>
		<article id="nUserTit"><div><h2>마이페이지</h2></div></article>
		<article id="nUserAt">
			<div onclick="location.href='<%=request.getContextPath()%>/mypage/normalUserInfo.jsp'">내 정보 보기</div>
			<div onclick="location.href='<%=request.getContextPath()%>/mypage/myConsultList.jsp?midx=<%=nUserLogin.getMidx()%>'">내 상담 내역</div>
		</article>
	</section>
</body>
</html>
<%}else{
	response.sendRedirect(request.getContextPath()+"/index.jsp");
}
%>