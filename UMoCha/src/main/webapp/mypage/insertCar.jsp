<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "UMoCha.*" %>
<% Member insertCarLogin = (Member)session.getAttribute("loginUser"); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]-차량등록</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	#insertCarTit{
		position : relative;
		left : 80px;
		background-color : gray;
		width : 800px;
	}
	
	#insertCarAt{
		margin : auto;
		width : 500px;
	}
</style>
</head>
<body>
	<% if(insertCarLogin != null){%>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
	<%@ include file = "/aside.jsp" %>
	<%@ include file = "/asideLeft.jsp" %>
		<article id="insertCarTit"><div><h2>차량 등록</h2></div></article>
		<article id="insertCarAt">
			<form>
				<div>
					제조사 : 
					<select>
						<option>현대자동차</option>
						<option>기아자동차</option>
					</select>
				</div>
				<div>
					차량 이미지 삽입 : 
					<input type="file" name="carImg">
				</div>
				<div>
					차량 색상 삽입 : 
					<input type="file" name="colorImg">
				</div>
				<div>
					차량 휠 삽입 : 
					<input type="file" name="wheelImg">
				</div>
				<div>
					차량 이름 : 
					<input type="text" name="cname">
				</div>
				<div>
					<!-- n개의 트림이 있음 -->
					트림<br>
					파워트레인 : <textarea></textarea><br>
					안전 기술 : <textarea></textarea><br>
					안전 : <textarea></textarea><br>
					안전 : <textarea></textarea><br>
					외관 : <textarea></textarea><br>
					내장 : <textarea></textarea><br>
					시트 : <textarea></textarea><br>
					편의 : <textarea></textarea><br>
					인포테인먼트 : <textarea></textarea>
				</div>
				<div>
					<!-- n개의 옵션 -->
					차량 옵션 : <textarea></textarea>
				</div>
				<div>
					차량 가격 : 
					<input type="text" name="price1">만원 
					~
					<input type="text" name="price2">만원
				</div>
			</form>
		</article>
	</section>
	<%
	}else{
		response.sendRedirect(request.getContextPath());
	}
	%>
</body>
</html>