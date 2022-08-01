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
		<c:import url="/nav.do"></c:import>
	</nav>
	<section>
		<div id="section">
			<div id="container">
				<div  id="join" class="joinForm" >
					<h2>마이페이지</h2>
					<input type="button"  id="orderBtn" class="btn" value="주문내역" />
					<div class="textForm">
						<p class="mypagename" >아이디</p>
						<input autocomplete="off" name="u_email" id="email" minlength="6" type="email" required="required" class="email" value="<sec:authentication property='principal.username' />" disabled="disabled"/>
					</div>				
					
					<div class="textForm">
						<p class="mypagename" >이름</p>
						<input autocomplete="off" name="u_name" minlength="2" type="text" class="name" required="required" placeholder="이름" pattern="^[가-힣]{2,20}|[a-zA-Z]{2,20}\s[a-zA-Z]{2,20}$" value="<sec:authentication property='principal.name' />" disabled="disabled">
					</div>
					<input class="btn" type="button" value="비밀번호변경하기" onclick="location.href='./pwchange'"/>
					<div class="textForm">
						<p class="mypagename" >핸드폰 번호</p>
						<input autocomplete="off" name="u_tel" type="text" minlength="10" class="name" required="required" placeholder="핸드폰번호 ( - 없이 입력)" value="<sec:authentication property='principal.tel' />" disabled="disabled">
					</div>
					<div class="textForm">
						<select name="u_grade" required="required" class="nickname" id="grade" onchange="gradeText()" disabled="disabled">
							<option <sec:authentication property='principal.grade' /> eq 0 ? 'checked':''>일반</option>
							<option <sec:authentication property='principal.grade' /> eq 1 ? 'checked':''>사업자</option>
						</select>
					</div>
					
					<div class="textForm">
						<p class="mypagename" >닉네임</p>
						<input autocomplete="off" name="u_nickname" type="text" id="nickname" minlength="1" required="required" class="nickname" placeholder="닉네임" oninput = "checknickname()" pattern="^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$" value="<sec:authentication property='principal.nickname' />" disabled="disabled" >
					</div>
					
					<div>
					
					<div class="textForm">
						<p class="mypagename" >우편번호</p>
						<input autocomplete="off" type="text" id="sample6_postcode" required="required" class="postcode"  name="u_postcode" placeholder="우편번호 찾기 Click" type="button" onclick="sample6_execDaumPostcode()" class="postbtn" value="<sec:authentication property='principal.postcode' />" disabled="disabled">
						<!-- <input type="button" onclick="sample6_execDaumPostcode()" class="postbtn" value="우편번호 찾기"> -->
					</div> 
	
	
					<div class="textForm">
						<p class="mypagename" >주소</p>
						<input autocomplete="off" type="text" id="sample6_address" required="required" class="roadAddress" name="u_roadAddress" placeholder="주소" value="<sec:authentication property='principal.roadAddress' />" disabled="disabled"><br>
					</div>
					<div class="textForm">
						<input autocomplete="off" type="text" id="sample6_detailAddress" required="required" class="detailAddress" name="u_detailAddress" placeholder="상세주소" value="<sec:authentication property='principal.detailAddress' />" disabled="disabled">
					</div>
					<div class="textForm">
						<input autocomplete="off" type="text" id="sample6_extraAddress" class="roadAddress"  name="u_extraAddress" placeholder="참고항목" value="<sec:authentication property='principal.extraAddress' />" disabled="disabled">
					</div>
	
					</div>
					<input class="btn" type="button" value="회원정보수정" onclick="location.href='./update'"/>
					<input type="button"  id="deletebtn" class="btn" value="회원탈퇴" />
				</div>
			</div>
		</div>
	
	
	
	
	
	
	
	
	

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
<script type="text/javascript">
$(document).ready(function(){
	$('#orderBtn').click(function(){
		location.href="./orderHistory.do";
	});
	$('#deletebtn').click(function(){
		if(confirm("정말로 탈퇴하시겠습니까?"))
			location.href="./resign.do";
	});
});
</script>
</body>
</html>