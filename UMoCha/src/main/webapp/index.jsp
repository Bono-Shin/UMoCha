<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file = "header.jsp" %>
	<hr>
	<div>
		<button class="loginB">로그인</button>
	</div>
	<div class="carMaker">
		제조사
	</div>
	<div class="counseling">
		상담
	</div>
	<div>
		<table class="banner1">
			<tr>
				<td>광고1</td>
			</tr>
		</table>
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
	<div class="pCar">
		<table border="1">
			<tbody>
				<tr>
					<td colspan="2">인기차량</td>
				</tr>
				<tr>
					<td>사진</td>
					<td>
						현대 아반떼<br>
						출시일
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="nCar">
		<table border="1">
			<tbody>
				<tr>
					<td colspan="2">신규차량</td>
				</tr>
				<tr>
					<td>사진</td>
					<td>
						현대 아반떼<br>
						출시일
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>