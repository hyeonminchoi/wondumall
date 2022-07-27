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

<title></title>

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

<style type="text/css">
th, td{
font-size: 20px;
}
</style>
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
				<table class="table" style="width:90%; margin: 0 auto; margin-top: 20px; margin-bottom: 20px;">
					<thead>
						<tr>
							<th>#</th>
							<th>이메일</th>
							<th>이름</th>
							<th>전화번호</th>
							<th>우편번호</th>
							<th>도로명주소</th>
							<th>상세주소</th>
							<th>결제상태</th>
							<th>결제금액</th>
							<th>환불하기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${orderList }" var="o">
							<tr>
								<th>${o.o_no }</th>
								<td>${o.o_email }</td>
								<td>${o.o_name }</td>
								<td>${o.o_tel }</td>
								<td>${o.o_postcode }</td>
								<td>${o.o_roadAddress }</td>
								<td>${o.o_detailAddress }</td>
								<td>${o.o_status }</td>
								<td>${o.o_price }</td>
								<td><button class="primary btn" id="refund" onclick="refund()">환불하기</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
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
<script type="text/javascript">
function refund(){
	jQuery.ajax({
		"url": "./refund", // 예: http://www.myservice.com/payments/cancel
		"type": "POST",
		"contentType": "application/json",
	    "data": JSON.stringify({
	    	"merchant_uid": merchant_uid, // 예: ORD20180131-0000011
	        "cancel_request_amount": o_price, // 환불금액
	      }),
	      "dataType": "json"
	});
}
</script>
</body>
</html>