<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>-로그인</title>

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

<!-- 로그인 부트스트랩 -->

<!--===============================================================================================-->
<link rel="icon" type="image/png" href="./images/icons/favicon.ico" />
<!--===============================================================================================-->
<!-- <link rel="stylesheet" type="text/css"
	href="./vendor/bootstrap/css/bootstrap.min.css"> -->
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="./fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="./fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="./vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="./vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="./vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="./vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="./vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="./css/loginutil.css">
<link rel="stylesheet" type="text/css" href="./css/loginmain.css">


<c:if test="${param.error ne null }">
	<script type="text/javascript">
		alert("로그인 정보가 올바르지 않습니다.\n올바른 아이디와 비밀번호를 입력하세요.");
	</script>
</c:if>

</head>

<body>
	<div id="container">
		<header>
			<c:import url="/header.do"></c:import>
		</header>
		<!-- /HEADER -->

		<!-- NAVIGATION -->
		<nav id="navigation">
			<c:import url="/nav.do"></c:import>
		</nav>
		<section>
			<div class="limiter">
				<div class="container-login100"
					style="background-image: url('images/bg-01.jpg');">
					<div class="wrap-login100 p-l-110 p-r-110 p-t-62 p-b-33">
						<form action="./login.do" method="post"
							class="login100-form validate-form flex-sb flex-w">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<span class="login100-form-title p-b-53"> 로그인 </span>
							<a href="./oauth2/authorization/naver" class="btn-google m-b-20">
							<img src="./img/btnG_아이콘원형.png" aria-hidden="true" />aver</a>
							<a href="./oauth2/authorization/kakao" class="btn-google m-b-20"><img src="./img/kakao_login_medium_narrow.png" style="height: 100%; width: auto;"></a>
							<a href="./oauth2/authorization/google" class="btn-google m-b-20"> <i
								class="fa fa-google" aria-hidden="true"></i> oogle
							</a> <br> <br>

							<div class="p-t-31 p-b-9">
								<span class="txt1"> <strong>아이디</strong> <small>(ex) example@example.com</small> </span>
							</div>
							<div class="wrap-input100 validate-input"
								data-validate="Username is required">
								<input class="input100" type="email" name="u_email"> <span
									class="focus-input100"></span>
							</div>

							<div class="p-t-13 p-b-9">
								<span class="txt1"> <strong>비밀번호</strong> </span> 
							</div>
							<div class="wrap-input100 validate-input"
								data-validate="Password is required">
								<input class="input100" type="password" name="u_pw">
								 <span class="focus-input100"></span>
							</div>
								  <a href="./findid.do" class="txt2 bo1 m-l-5">아이디를 잊으셨나요? </a> 
								  <a href="./findpw.do" class="txt2 bo1 m-l-5">비밀번호를 잊으셨나요? </a> 

							<input type="hidden" value="" name="u_provider">

							<div class="container-login100-form-btn m-t-17">
								<button type="submit" class="login100-form-btn">로그인</button>
							</div>

							<div class="w-full text-center p-t-55">
								<span class="txt2"> 아직 회원이 아니신가요? </span> <a href="./join.do" class="txt2 bo1"> 회원가입 </a>
							</div>
						</form>
					</div>
				</div>8/
			</div>
			</section>
	</div>
	

	<div id="dropDownSelect1"></div>

	<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
	<!--===============================================================================================-->
	<script src="js/loginmain.js"></script>

	

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