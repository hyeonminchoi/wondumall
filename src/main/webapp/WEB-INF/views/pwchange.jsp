<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>회원가입</title>

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
		<c:import url="./nav.jsp"></c:import>
	</nav>
	<section>
		<div id="section">
			<div id="container">
				<form action="./pwchange.do" method="POST" id="join" class="joinForm">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<h2>회원가입</h2>
					<div class="textForm">
						<input autocomplete="off" name="u_email" id="email" minlength="6" type="email" required="required" class="email" placeholder="아이디(이메일 형식)" oninput = "checkemail()" value="<sec:authentication property='principal.username' />" disabled="disabled"/>
					</div>				
			
					<div class="textForm">
						<input autocomplete="off" name="u_pw" type="password" id="pw" required="required" class="pw" placeholder="현재 비밀번호" onkeyup="passlength()" pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$">
					</div>
					<div class="textForm">
						<input autocomplete="off" name="changepw" type="password" id="pw1" required="required" class="pw" placeholder="새로운 비밀번호" onkeyup="passlength()" pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$">
					</div>
					<div class="textForm">
						<input autocomplete="off" type="password" minlength="4" required="required" id="pw2" class="pw" placeholder="새로운 비밀번호 확인" onkeyup="passConfirm()" pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$">
					</div>
					<span id ="confirmMsg"><br></span> 
					<span id ="confirmMsg2"></span>
					

					<input type="submit"  id="joinbtn" class="btn" value="비밀번호변경하기" />
				</form>
			</div>
		</div>
	
	<script type="text/javascript">
		/* 자바 스크립트 함수 선언(비밀번호 확인) */
	
		function passConfirm() {
		/* 비밀번호, 비밀번호 확인 입력창에 입력된 값을 비교해서 같다면 비밀번호 일치, 그렇지 않으면 불일치 라는 텍스트 출력.*/
		/* document : 현재 문서를 의미함. 작성되고 있는 문서를 뜻함. */
		/* getElementByID('아이디') : 아이디에 적힌 값을 가진 id의 value를 get을 해서 password 변수 넣기 */
			var password = document.getElementById('pw1');					//비밀번호 
			var passwordConfirm = document.getElementById('pw2');	//비밀번호 확인 값
			var confrimMsg = document.getElementById('confirmMsg');				//확인 메세지
			var correctColor = "#228B22";	//맞았을 때 출력되는 색깔.
			var wrongColor = "#FF00FF";	//틀렸을 때 출력되는 색깔
						
			if(password.value == passwordConfirm.value){//password 변수의 값과 passwordConfirm 변수의 값과 동일하다.
				confirmMsg.style.color = correctColor;/* span 태그의 ID(confirmMsg) 사용  */
				confirmMsg.innerHTML ="비밀번호 일치";/* innerHTML : HTML 내부에 추가적인 내용을 넣을 때 사용하는 것. */
				$('#joinbtn').attr('disabled', false);
			}else{
				confirmMsg.style.color = wrongColor;
				confirmMsg.innerHTML ="비밀번호 불일치";
				$('#joinbtn').attr('disabled', true);
			}
		}
	
	</script>
	
	
	
	
	
	
	
	
	

	</section>
	<!-- FOOTER -->
	<footer id="footer">
		<c:import url="./footer.jsp"></c:import>
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