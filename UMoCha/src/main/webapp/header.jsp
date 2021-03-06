<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "UMoCha.*" %>

<%
	Member headerLogin = (Member)session.getAttribute("loginUser");
%>
<header>
	<div>
		<img src="<%=request.getContextPath()%>/image/logo2.png" alt="site logo" width="150" id="logo" onclick="location.href='<%=request.getContextPath()%>/index.jsp'">
	</div>
	<div id="search">
		<label id="searchCar">
			<input type="text" placeholder="차량명을 입력하세요. ex)아반떼">
			<button onclick="search()">검색</button>
		</label>
	</div>
	<div id="home">
		<a href="<%=request.getContextPath()%>/index.jsp">홈</a>
	|
	<%
		if(headerLogin != null){
			if(headerLogin.getType().equals("A")){
	%>
				<a href="<%=request.getContextPath()%>/mypage/admin.jsp">마이페이지</a>
	<%
			}else if(headerLogin.getType().equals("N")){
	%>	
				<a href="<%=request.getContextPath()%>/mypage/normalUserMypage.jsp">마이페이지</a>
	<%			
			}else if(headerLogin.getType().equals("D")){				
	%>
				<a href="<%=request.getContextPath()%>/mypage/dealerUserMypage.jsp">마이페이지</a>
	<%		
			}
		}else{
	%>
			<a href="<%=request.getContextPath()%>/login/join.jsp">회원가입</a>
	<%
		}
	%>
	</div>
</header>
<hr>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	
	$("#searchCar").keypress(function (e){
		if(e.keyCode === 13){
			search();
		}
	});

	function search(){
		var searchValue = $("#searchCar").find("input").val();
		
		if(searchValue != null && searchValue != ""){
			location.href="<%=request.getContextPath()%>/car/searchCar.jsp?cname="+searchValue
		}
	}	
</script>
