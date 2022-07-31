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
							<th>결제번호</th>
							<th>주문번호</th>
							<th>결제일</th>
							<th>가격</th>
							<th>결제상태</th>
							<th>환불하기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${orderList }" var="o">
							<tr>
								<td>${o.imp_uid }</td>
								<td>${o.merchant_uid }</td>
								<td>${o.o_date }</td>
								<td>${o.o_price }</td>
								<td>${o.o_status }</td>
								<td>
									<c:if test="${o.o_status == '결제완료' }">
										<button class="primary btn" id="refund" onclick="cancelPay('${o.merchant_uid}', ${o.o_price })">환불하기</button>
									</c:if>
								</td>
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
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript">
function cancelPay(merchant_uid, o_price){
	$.ajax({
		url: "./refund", // 예: http://www.myservice.com/payments/cancel
		type: "POST",
	    data: {
	    	"merchant_uid": merchant_uid, // 예: ORD20180131-0000011
	        "amount": o_price, // 환불금액
	        "reason": "사용자 환불 요청" // 환불사유
	    	},
	    success: function(result){
	    	alert("환불 성공");
	    	location.href = location.href; history.go(0);
	    },
	    error: function(error){
	    	alert("환불 실패");
	    	location.href = location.href; history.go(0);
	    }
	})
}
</script>
</body>
</html>