<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>회원 정보</title>

<!-- Google font -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700"
	rel="stylesheet">

<!-- Bootstrap -->
<link type="text/css" rel="stylesheet" href="./css/bootstrap.min.css" />

<!-- Slick -->
<link type="text/css" rel="stylesheet" href="./css/slick.css" />
<link type="text/css" rel="stylesheet" href="./css/slick-theme.css" />

<!-- nouislider -->
<link type="text/css" rel="stylesheet" href="./css/nouislider.min.css" />

<!-- Font Awesome Icon -->
<link rel="stylesheet" href="./css/font-awesome.min.css">

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet" href="./css/style.css" />

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

<link type="text/css" rel="stylesheet" href="./css/join.css" />


</head>
<body>
	<header>
		<c:import url="/header.do"></c:import>
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<nav id="navigation">
		<c:import url="/nav.do"></c:import>
	</nav>
	<section>
		<div id="section">
			<div id="container">
				<form action="./update.do" method="POST" id="join" class="joinForm" onsubmit="DoJoinForm__submit(this); return false;">
	
					<h2>회원탈퇴</h2>
					<div class="textForm">
					<p class="mypagename" >아이디</p>
						<input autocomplete="off" name="u_email" id="email" minlength="6" type="email" required="required" class="email" value="<sec:authentication property='principal.username' />" disabled="disabled"/>
					</div>
					
					<div class="textForm">
					<p class="mypagename" >비밀번호</p>
						<input autocomplete="off" name="u_pw" type="password" id="pw1" required="required" class="pw" placeholder="비밀번호" onkeyup="passlength()" pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$">
					</div>

					<input type="submit"  id="joinbtn" class="btn" value="탈퇴하기" />
				</form>
			</div>
		</div>
	
	<c:if test="${msg==false} ">
	<p>비밀번호가 일치하지 않습니다.</p>
	</c:if>
	
	
	

	</section>
	<!-- FOOTER -->
	<footer id="footer">
		<c:import url="/footer.do"></c:import>
	</footer>
	<!-- /FOOTER -->

	<!-- jQuery Plugins -->
	<script src="./js/jquery.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/slick.min.js"></script>
	<script src="./js/nouislider.min.js"></script>
	<script src="./js/jquery.zoom.min.js"></script>
	<script src="./js/main.js"></script>

</body>
</html>