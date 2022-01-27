<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "UMoCha.*" %>    


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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
		<div><h3>비밀번호 찾기</h3></div>
		<form action="passF.jsp" method="post" class="findF">
			<div>
				이름<br>
				<input type="text" name="name">
				<br>
				<span></span>
			</div>
			<div>
				아이디<br>
				<input type="text" name="id">
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
			
			//이름
			var reg = /^[ㄱ-힣]+$/;
			var value = $("input[name='name']").val();
			
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
			
			//아이디
			reg = /^[a-z]+[a-z0-9]{4,19}$/g;
			value = $("input[name='id']").val();
			
			if(value == ""){
				result = false;
				html = "필수 입력 사항"
				$("input[name='id']").next().next("span").html(html);
			}else if(!(reg.test(value))){
				result = false;
				html = "알파벳 또는 +숫자(5~19자리)"
				$("input[name='id']").next().next("span").html(html);
			}else{
				result = true;
				$("input[name='id']").next().next("span").html("");
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
			
			//패스워드 출력
			if(result){
				$.ajax({
					url : "idF.jsp",
					type : "post",
					data : $("form").serialize(),
					success : function(data){
						var json = JSON.parse(data.trim());
						
						if(json != null){
							var html = "<div><b>"+json[0].id+"</b>의 비밀번호는 <b>"+json[0].pass+"</b>입니다.</div>"
							$("form").html(html);
						}else{
							html = "등록되지 않았거나 입력 정보가 틀렸습니다.";
							$("form").html(html);
						}
					}
				});
			}
		}
	</script>
</body>
</html>