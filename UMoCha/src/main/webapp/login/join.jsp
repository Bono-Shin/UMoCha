<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]-회원가입</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/join.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
		<%@ include file = "/aside.jsp" %>
		<article>
			<form action="joinOk.jsp" method="post">
				<h2>회원가입</h2>
				<div>
					<label>
						아이디<b>*</b><br>
						<input type="text" name="id" class="in">
						<br>
						<span></span>
					</label>
				</div>
				<div>
					<label>
						비밀번호<b>*</b><br>
						<input type="password" name="pass" class="in">
						<br>
						<span></span>
					</label>
				</div>
				<div>
					<label>
						이름<b>*</b><br>
						<input type="text" name="name" class="in">
						<br>
						<span></span>
					</label>
				</div>
				<div>
					<label>
						주소<b>*</b><br>
						<input type="text" name="addr" class="in">
						<br>
						<span></span>
					</label>
				</div>
				<div>
					<label>
						연락처<b>*</b> ('-' 빼고 입력하세요.)<br>
						<input type="text" name="phone" maxlength="11" class="in">
						<br>
						<span></span>
					</label>
				</div>
				<div>
					<label>
						E-Mail<b>*</b><br>
						<input type="text" name="email" class="in">
						<br>
						<span></span>
					</label>
				</div>
				<div>
					회원 구분<b>*</b><br>
					<label>
						<input type="radio" name="type" value="N" checked>일반회원
					</label>
					<label>
						<input type="radio" name="type" value="D">딜러회원
					</label>
				</div>
				<div>
					<input type="submit" value="가입하기"  class="joinSub" onclick="submitFn(); return false;">
				</div>
			</form>
		</article>
	</section>
	<script>
	
		function submitFn(){
			var result = true;
			
			//id 정규식
			var reg = /^[a-z]+[a-z0-9]{4,19}$/g;
			var value = $("input[name='id']").val();
			console.log(value);
			var html = "";
			
			if(value == ""){
				result = false;
				html = "필수 입력 사항"
				$("input[name='id']").next().next("span").html(html);
				console.log(value);
			}else if(!(reg.test(value))){
				result = false;
				html = "알파벳+숫자(5~19자리)"
				$("input[name='id']").next().next("span").html(html);
			}else{
				$("input[name='id']").next().next("span").html("");
			}
			
			//비밀번호 정규식
			reg = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{4,}$/;
			value = $("input[name='pass']").val();
			
			if(value == ""){
				result = false;
				html = "필수 입력 사항"
				$("input[name='pass']").next().next("span").html(html);
			}else if(!(reg.test(value))){
				result = false;
				html = "알파벳+숫자+특수문자(최소 4자리)"
				$("input[name='pass']").next().next("span").html(html);
			}else{
				$("input[name='pass']").next().next("span").html("");
			}
			
			//한글이름 정규식
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
				$("input[name='name']").next().next("span").html("");
			}
			
			//주소
			value = $("input[name='addr']").val();
			
			if(value == ""){
				result = false;
				html = "필수 입력 사항"
				$("input[name='addr']").next().next("span").html(html);
			}else{
				$("input[name='addr']").next().next("span").html("");
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
				$("input[name='phone']").next().next("span").html("");
			}
			
			//email
			reg = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
			value = $("input[name='email']").val();
			
			if(value == ""){
				result = false;
				html = "필수 입력 사항"
				$("input[name='email']").next().next("span").html(html);
			}else if(!(reg.test(value))){
				result = false;
				html = "email 형식이 다릅니다."
				$("input[name='email']").next().next("span").html(html);
			}else{
				$("input[name='email']").next().next("span").html("");
			}
			
			if(result){
				document.frm.submit();
			}
		}
		
	</script>
</body>
</html>