<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "UMoCha.*" %>    


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style>
	.findD{
		margin : 20vh auto;
		width : 300px;
		height : 200px;
	}
	
	.findF{
		margin : auto;
		position : relative;
		left : 30px;
	}
	
	.findF>div{
		margin-bottom : 20px;
	}
	
	input{
		width : 200px;
		height : 30px;
	}
	
	span{
		font-size : 0.8em;
		color : red;
		position : absolute;
	}
</style>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="findD">
		<div><h3>아이디 찾기</h3></div>
		<form action="idF.jsp" method="post" class="findF">
			<div>
				이름<br>
				<input type="text" name="name">
				<br>
				<span></span>
			</div>
			<div>
				핸드폰번호<br>
				<input type="text" name="phone" maxlength="11" placeholder="('-' 빼고 입력하세요.)">
				<br>
				<span></span>
			</div>
			<div>
				<input type="submit" value="아이디 찾기" onclick="findSub(); return false;">
			</div>
		</form>
	</div>
	<script>
		function findSub(){
			var result = true;
			
			//이름 미입력
			reg = /^[ㄱ-힣]+$/;
			value = $("input[name='name']").val();
			
			if(value == ""){
				result = false;
				html = "필수 입력 사항"
				$("input[name='name']").next().next("span").html(html);
			}else if(!(reg.test(value))){
				result = false;
				html = "한글만 사용가능"
				$("input[name='name']").next().next("span").html(html);
			}else{
				result = true;
				$("input[name='name']").next().next("span").html("");
			}
			
			//연락처
			reg = /^[0-9]*$/;
			value = $("input[name='phone']").val();
			
			if(value == ""){
				result = false;
				html = "필수 입력 사항"
				$("input[name='phone']").next().next("span").html(html);
			}else if(!(reg.test(value))){
				result = false;
				html = "숫자만 사용가능"
				$("input[name='phone']").next().next("span").html(html);
			}else{
				result = true;
				$("input[name='phone']").next().next("span").html("");
			}
			
			//아이디 조회 후 출력
			if(result){
				$.ajax({
					url : "idF.jsp",
					type : "post",
					data : $("form").serialize(),
					success : function(data){
						var json = JSON.parse(data.trim());
						
						if(json != null){
							var html = "<div><b>"+json[0].name+"</b>님의 아이디는 <b>"+json[0].id+"</b>입니다.</div>"
							$("form").html(html);
						}else{
							html = "등록되지 않았거나<br>입력 정보가 틀립니다.";
							$("form").html(html);
						}
					}
				});
			}
		}
	</script>
</body>
</html>