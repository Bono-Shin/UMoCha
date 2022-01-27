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
	
	#imgD{
		border : 1px solid black;
	}
	
	textarea{
		width : 500px;
		height : 100px;
	}
	
	.price{
		width : 130px;
	}
	
	#priceD{
		margin-bottom : 30px;
	}
	
	.allD{
		margin-bottom : 20px;
	}
	
	#inSub{
		width : 300px;
		height : 40px;
		position : relative;
		left : 90px;
	}
	
	select{
		width : 200px;
		height : 50px;
	}
</style>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
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
			<form action="insertCarOk.jsp" method="post">
				<div class="allD">
					[제조사 선택]<br>
					<select name="cmake">
						<option>현대자동차</option>
						<option>기아자동차</option>
					</select>
				</div>
				<div class="allD">
					[차량 이름] <span></span><br>
					<input type="text" name="cname">
				</div>
				<div id="priceD" class="allD">
					[차량 가격] <span></span><br>
					<input type="text" name="price1" class="price">만원 
					~ 
					<input type="text" name="price2" class="price">만원
				</div>
				<div class="allD trimD">
					<!-- n개의 트림이 있음 -->
					<div class="allD">
						[트림 이름] <span></span><br>
						<input type="text" name="trim0">
					</div>
					<div class="allD">
						[트림 가격] <span></span><br>
						<input type="text" name="trimPrice">만원
					</div>
					<div class="allD">
						[파워트레인] <span></span><br>
						<textarea name="pt"></textarea><br>
					</div>
					<div class="allD">
						[안전 기술] <span></span><br>
						<textarea name="Tsafe"></textarea><br>
					</div>
					<div class="allD">
						[안전] <span></span><br>
						<textarea name="safe"></textarea><br>
					</div>
					<div class="allD">
						[외관] <span></span><br>
						<textarea name="ext"></textarea><br>
					</div>
					<div class="allD">
						[내장] <span></span><br>
						<textarea name="inte"></textarea><br>
					</div>
					<div class="allD">
						[시트] <span></span><br>
						<textarea name="seat"></textarea><br>
					</div>
					<div class="allD">
						[편의] <span></span><br>
						<textarea name="conve"></textarea><br>
					</div>
					<div class="allD">
						[인포테인먼트] <span></span><br>
						<textarea name="info"></textarea>
					</div>
					<div class="allD">
						<!-- n개의 옵션 -->
						[차량 옵션] <span></span><br>
						<textarea name="opt"></textarea>
					</div>
				</div>
				<div class="allD">
					<input type="button" value="트림 추가" onclick="addTrim()">
				</div>
				<div id="imgD" class="allD">
					<div class="allD">
						차량 이미지 삽입 : 
						<input type="file" name="carImg">
					</div>
					<div class="allD">
						차량 색상 삽입 : 
						<input type="file" name="colorImg">
					</div>
					<div>
						차량 휠 삽입 : 
						<input type="file" name="wheelImg">
					</div>
				</div>
				<div>
					<input type="submit" value="등록" id="inSub" onclick="carSub(); return false;">
				</div>
			</form>
		</article>
	</section>
	<script>
	
		function carSub(){
			var result = true;
			
			if(result){
				document.frm.submit();	
			}
			
		}
		
		var trimCnt = 0;
		
		function addTrim(){
				trimCnt += 1;
			var html = "<div class='allD'>";
				html += "<div class='allD trimD'>";
				html += "[트림 이름] <span></span><br>";
				html += "<input type='text' name='trim"+trimCnt+"'>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[트림 가격] <span></span><br>";
				html += "<input type='text' name='trimPrice'>만원";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[파워트레인] <span></span><br>";
				html += "<textarea name='pt'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[안전 기술] <span></span><br>";
				html += "<textarea name='Tsafe'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[안전] <span></span><br>";
				html += "<textarea name='safe'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[외관] <span></span><br>";
				html += "<textarea name='ext'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[내장] <span></span><br>";
				html += "<textarea name='inte'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[시트] <span></span><br>";
				html += "<textarea name='seat'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[편의] <span></span><br>";
				html += "<textarea name='conve'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[인포테인먼트] <span></span><br>";
				html += "<textarea name='info'></textarea>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[차량 옵션] <span></span><br>";
				html += "<textarea name='opt'></textarea>";
				html += "</div>";
				html += "</div><input type='hidden' name='trimCnt' value='"+trimCnt+"'>";
				console.log(trimCnt);
				
				$(".trimD").append(html);	
		}
	</script>
	<%
	}else{
		response.sendRedirect(request.getContextPath());
	}
	%>
</body>
</html>