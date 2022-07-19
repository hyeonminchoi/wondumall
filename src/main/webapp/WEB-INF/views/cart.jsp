<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title>장바구니</title>

 		<!-- Google font -->
 		<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

 		<!-- Bootstrap -->
 		<link type="text/css" rel="stylesheet" href="./css/bootstrap.min.css"/>

 		<!-- Slick -->
 		<link type="text/css" rel="stylesheet" href="./css/slick.css"/>
 		<link type="text/css" rel="stylesheet" href="./css/slick-theme.css"/>

 		<!-- nouislider -->
 		<link type="text/css" rel="stylesheet" href="./css/nouislider.min.css"/>

 		<!-- Font Awesome Icon -->
 		<link rel="stylesheet" href="./css/font-awesome.min.css">

 		<!-- Custom stlylesheet -->
 		<link type="text/css" rel="stylesheet" href="./css/style.css"/>
 		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
		<link type="text/css" rel="stylesheet" href="./css/cart.css" />

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		<script src="./js/jquery.min.js"></script>  
		<script src="./js/bootstrap.min.js"></script>
		<script src="./js/slick.min.js"></script>
		<script src="./js/nouislider.min.js"></script>
		<script src="./js/jquery.zoom.min.js"></script>
		<script src="./js/main.js"></script>
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		
<style type="text/css">
.basketdiv .row.head {
	border-bottom: 2px solid #888;
	box-sizing: border-box;
	background-color: #f4f4f4;
	font-weight: 500;
}
</style>
		<script type="text/javascript">
			function del(cart_no){
				if (confirm("삭제하시겠습니까?")){
					location.href = "./cartDelete.do?cart_no=" + cart_no;
				} else {
					
				}
			}
		</script>
    </head>
	<body>
		<!-- HEADER -->
		<header>
			<c:import url="/header.do"></c:import>
		</header>
		<!-- /HEADER -->

		<!-- NAVIGATION -->
		<nav id="navigation">
			<c:import url="./nav.jsp"></c:import>
		</nav>
		<!-- /NAVIGATION -->
		<section>
			<div id="breadcrumb" class="section">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<div class="col-md-12">
							<h3 class="breadcrumb-header">장바구니</h3>
							<ul class="breadcrumb-tree">
								<li><a href="./">Home</a></li>
								<li class="active">Cart</li>
							</ul>
						</div>
					</div>
					<!-- /row -->
				</div>
				<!-- /container -->
			</div>
			<!-- /BREADCRUMB -->
	
			<!-- SECTION -->
			<div class="section">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<form name="orderform" id="orderform" method="post" class="orderform" action="/checkout" onsubmit="return false;">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">선택</th>
										<th scope="col">이미지</th>
										<th scope="col">상품명</th>
										<th scope="col">가격</th>
										<th scope="col">수량</th>
										<th scope="col">합계</th>
										<th scope="col">삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${cart}" var="c">
										<tr>
											<th scope='row'>
												<input type="checkbox" name="buy" value="260" checked=""
														onclick="javascript:basket.checkItem();"
												>&nbsp;
											</th>
											<td><img src="./productUpload/${p.p_img}" style="width: 60px;"></td>
											<td>${c.p_name }</td>
											<td>${c.p_price }원</td>
											<td class="updown">
												<input type="text" name="p_num3" id="p_num3" size="2"
														maxlength="4" class="p_num" value="${c.p_count }"
														style="text-align: right;"
														onkeyup="javascript:basket.changePNum(3);"
												>
												<span onclick="javascript:basket.changePNum(3);">
													<i class="fas fa-arrow-alt-circle-up up" style="cursor: pointer;"></i>
												</span>
												<span onclick="javascript:basket.changePNum(3);">
													<i class="fas fa-arrow-alt-circle-down down" style="cursor: pointer;"></i>
												</span>
											</td>
											<td>${c.sumPrice}원</td>
											<td><button class="abutton" onclick="del(${c.cart_no})">삭제</button></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="right-align basketrowcmd">
								<a href="javascript:void(0)" class="abutton"
									onclick="javascript:basket.delCheckedItem();">선택상품삭제</a> <a
									href="javascript:void(0)" class="abutton"
									onclick="javascript:basket.delAllItem();">장바구니비우기</a>
							</div>
							<div class="bigtext right-align sumcount" id="sum_p_num">
								상품갯수:${qty}개
							</div>
							<div class="bigtext right-align box blue summoney" id="sum_p_price">
								합계금액:74,200원
							</div>
							<div id="goorder" class="">
								<div class="clear"></div>
								<div class="buttongroup center-align cmd">
									<a href="javascript:void(0);">선택한 상품 주문</a>
								</div>
							</div>
						</form>
					 <%-- <td><a href="./cartDelete.do?cart_no=${cart.cart_no}">[삭제]</a></td> --%>
					<!-- 삭제 버튼을 누르면 delete.do로 장바구니 개별 id (삭제하길원하는 장바구니 id)를 보내서 삭제한다. -->
					</div>
				<!-- /row -->
				</div>
			<!-- /container -->
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

	</body>
</html>
