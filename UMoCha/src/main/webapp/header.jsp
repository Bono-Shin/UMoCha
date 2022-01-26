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
		<label>
			<input type="text" placeholder="차량명을 입력하세요. ex)아반떼">
			<button>검색</button>
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
				<a href="">마이페이지</a>
	<%			
			}else if(headerLogin.getType().equals("D")){				
	%>
				<a href="">마이페이지</a>
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
