<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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
	<a href="<%=request.getContextPath()%>/login/join.jsp">회원가입</a>
	</div>
</header>
<hr>
