<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "UMoCha.*" %>
<% Member counselUserLogin = (Member)session.getAttribute("loginUser"); %>

<nav>
	<div class="carMaker">
		제조사
		<div class="subCM">
			<dl>
				<dt>
					<a href="<%=request.getContextPath()%>/car/hyundai.jsp">
					<img src="<%=request.getContextPath()%>/image/현대로고.jpg" alt="현대로고" width="60px"><br>
					<span class="txt" style="color : black">현대자동차</span>
					</a>
				</dt>
				<dt>
					<a href="<%=request.getContextPath()%>/car/kia.jsp">
					<img src="<%=request.getContextPath()%>/image/기아로고.jpg" alt="기아로고" width="60px"><br>
					<span class="txt" style="color : black">기아자동차</span>
					</a>
				</dt>
			</dl>
		</div>
	</div>
	<div class="counseling" onclick="counsel()">
		상담
	</div>
</nav>
<script>
	function counsel(){
		<%if(counselUserLogin != null && counselUserLogin.getType().equals("N")){%>
			location.href="<%=request.getContextPath()%>/mypage/consultList.jsp"
		<%}else{%>
			alert("로그인이 필요한 서비스 입니다.");
		<%}%>
	}
</script>