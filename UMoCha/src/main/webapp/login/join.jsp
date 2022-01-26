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
						<input type="text" name="id" class="in" oninput="idInput()">
						<br>
						<span></span>
					</label>
				</div>
				<div>
					<label>
						비밀번호<b>*</b><br>
						<input type="password" name="pass" class="in" oninput="passInput()">
						<br>
						<span></span>
					</label>
				</div>
				<div>
					<label>
						이름<b>*</b><br>
						<input type="text" name="name" class="in" oninput="nameInput()">
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
	
		var result = true;
		
		function submitFn(){
			//아이디 미입력
			var value = $("input[name='id']").val();
			if(value == ""){
				result = false;
				var html = "필수 입력 사항"
				$("input[name='id']").next().next("span").html(html);
			}
		
			//비밀번호 미입력
			value = $("input[name='pass']").val();
			if(value == ""){
				result = false;
				html = "필수 입력 사항"
				$("input[name='pass']").next().next("span").html(html);
			}
			
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
				$("input[name='name']").next().next("span").html("");
			}
			
			//주소 미입력
			value = $("input[name='addr']").val();
			
			if(value == ""){
				result = false;
				html = "필수 입력 사항"
				$("input[name='addr']").next().next("span").html(html);
			}else{
				result = true;
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
				result = true;
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
				result = true;
				$("input[name='email']").next().next("span").html("");
			}
			
			if(result){
				document.frm.submit();
			}
			
		}
		
		//아이디 체크
		function idInput(){
			var id = $("input[name='id']").val();
			
			$.ajax({
				url : "check.jsp",
				type : "post",
				data : "id="+id,
				success : function(data){
					var reg = /^[a-z]+[a-z0-9]{4,19}$/g;

					if(data.trim() == 0){
						if(reg.test(id)){
							result = true;
							var html = "사용 가능한 아이디 입니다.";	
							$("input[name='id']").next().next("span").html(html).css("color","green");
						}else if(!(reg.test(id))){
							result = false;
							html = "알파벳 또는 +숫자(5~19자리)";
							$("input[name='id']").next().next("span").html(html).css("color","red");
						}
						
						if(id == ""){
							result = false;
							html = "필수 입력 사항";
							$("input[name='id']").next().next("span").html(html).css("color","red");
						}
					}else if(data.trim() == 1){
						result = false;
						html = "이미 사용중인 아이디 입니다.";
						$("input[name='id']").next().next("span").html(html).css("color","red");
					}
				}
			});
		}
		//비밀번호 체크
		function passInput(){
			var reg = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{4,}$/;
			var value = $("input[name='pass']").val();
			
			if(value == ""){
				result = false;
				html = "필수 입력 사항"
				$("input[name='pass']").next().next("span").html(html).css("color","red");
			}else if(!(reg.test(value))){
				result = false;
				html = "알파벳+숫자+특수문자(최소 4자리)"
				$("input[name='pass']").next().next("span").html(html).css("color","red");
			}else if(reg.test(value)){
				result = true;
				html = "사용 가능한 비밀번호 입니다."
				$("input[name='pass']").next().next("span").html(html).css("color","green");
			}
		}
		//이름 체크
		function nameInput(){
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
		}
		
	</script>
</body>
</html>