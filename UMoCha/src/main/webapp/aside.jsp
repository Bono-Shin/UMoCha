<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "UMoCha.*" %>
<%
	Member asidLogin = (Member)session.getAttribute("loginUser");
%>
    
<aside id="aside">
	<div>
		<%
			if(asidLogin != null){
		%>
			<div class="loginB">
				<div><span><%=asidLogin.getName() %></span>님<br>환영합니다.</div>
				<div><a href="<%=request.getContextPath()%>/login/logout.jsp">로그아웃</a></div>
			</div>
		<%
			}else{
		%>
			<button class="loginB" onclick="location.href='<%=request.getContextPath()%>/login/login.jsp'">로그인</button>
		<%
			}
		%>
	</div>
	<div>
		<table class="banner2">
			<tr>
				<td>광고2</td>
			</tr>
		</table>
	</div>
	<div>
		<table class="banner3">
			<tr>
				<td>광고3</td>
			</tr>
		</table>
	</div>
</aside>
