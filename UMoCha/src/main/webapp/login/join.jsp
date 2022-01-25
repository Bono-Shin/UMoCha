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
			<form action="#" method="#">
				<h2>회원가입</h2>
				<div>
					<label>
						아이디<br>
						<input type="text" name="id" class="in">
						<span></span>
					</label>
				</div>
				<div>
					<label>
						비밀번호<br>
						<input type="password" name="pass" class="in">
						<span></span>
					</label>
				</div>
				<div>
					<label>
						이름<br>
						<input type="text" name="name" class="in">
						<span></span>
					</label>
				</div>
				<div>
					<label>
						주소<br>
						<input type="text" name="addr" class="in">
						<span></span>
					</label>
				</div>
				<div>
					<label>
						연락처 ('-' 빼고 입력하세요.)<br>
						<input type="text" name="phone" maxlength="11" class="in">
						<span></span>
					</label>
				</div>
				<div>
					<label>
						E-Mail<br>
						<input type="password" name="pass" class="in">
						<span></span>
					</label>
				</div>
				<div>
					회원 구분<br>
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
			var reg = /^[a-z]+[a-z0-9]{5,19}$/g;
			var value = $("input[name='id']").value();
			console.log(value);
			
			
		}
	</script>
</body>
</html>