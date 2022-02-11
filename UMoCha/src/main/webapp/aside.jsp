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
			<tbody>
				<tr>
					<td>광고2</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div>
		<table class="banner3">
			<tbody>
				<tr>
					<td width="149px" height="249px"><a href="https://v-kool.co.kr/"><img src="<%=request.getContextPath()%>/image/틴팅광고.jpg" alt="틴팅광고" width="150px" height="250px"></a></td>
				</tr>
			</tbody>
		</table>
	</div>
</aside>
