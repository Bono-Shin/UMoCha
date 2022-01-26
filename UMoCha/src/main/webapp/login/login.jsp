<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]-로그인</title>
<link href="<%=request.getContextPath()%>/css/login.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<section>
		<article>
			<form action="loginOk.jsp" method="post">
				<img src="<%=request.getContextPath()%>/image/logo2.png" width="150" alt="site logo" class="logo" onclick="location.href='<%=request.getContextPath()%>/index.jsp'">
				<div>
					<label>
						아이디<br>
						<input type="text" name="id" class="in">
						<br>
						<span></span>
					</label>
				</div>
				<div>
					<label>
						비밀번호<br>
						<input type="password" name="pass" class="in">
						<br>
						<span></span>
					</label>
				</div>
				<div>
					<input type="submit" value="로그인"  class="joinSub" onclick="login(); return false;">
				</div>
			</form>
		</article>
	</section>
	
	<script>
		function login(){
			var result = true;
			//아이디 미입력
			var value = $("input[name='id']").val();
			if(value == ""){
				result = false;
				var html = "아이디를 입력하세요."
				$("input[name='id']").next().next("span").html(html);
			}else{
				result = true;
				$("input[name='id']").next().next("span").html("");
			}
			
			//비밀번호 미입력
			value = $("input[name='pass']").val();
			if(value == ""){
				result = false;
				var html = "비밀번호를 입력하세요."
				$("input[name='pass']").next().next("span").html(html);
			}else{
				result = true;
				$("input[name='pass']").next().next("span").html("");
			}
			
			if(result){
				document.frm.submit();
			}
		}
	</script>
</body>
</html>