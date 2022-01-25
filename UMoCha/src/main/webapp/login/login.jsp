<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]-로그인</title>
<link href="<%=request.getContextPath()%>/css/login.css" rel="stylesheet">
</head>
<body>
	<section>
		<article>
			<form method="post">
				<img src="<%=request.getContextPath()%>/image/logo2.png" width="150" alt="site logo" class="logo" onclick="location.href='<%=request.getContextPath()%>/index.jsp'">
				<div>
					<label>
						아이디<br>
						<input type="text" name="id" class="in">
					</label>
				</div>
				<div>
					<label>
						비밀번호<br>
						<input type="password" name="pass" class="in">
					</label>
				</div>
				<div>
					<input type="submit" value="로그인"  class="joinSub">
				</div>
			</form>
		</article>
	</section>
</body>
</html>