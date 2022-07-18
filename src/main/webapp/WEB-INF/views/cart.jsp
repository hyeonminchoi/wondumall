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
	
						<input type="hidden" name="cmd" value="order">
						<div class="basketdiv" id="basket">
							<div class="row head">
								<div class="subdiv">
									<div class="check">선택</div>
									<div class="img">이미지</div>
									<div class="pname">상품명</div>
								</div>
								<div class="subdiv">
									<div class="basketprice">가격</div>
									<div class="num">수량</div>
									<div class="sum">합계</div>
								</div>
								<div class="subdiv">
	
									<div class="basketcmd">삭제</div>
								</div>
								<div class="split"></div>
							</div>
	
							<div class="row data">
								<div class="subdiv">
									<div class="check">
										<input type="checkbox" name="buy" value="260" checked=""
											onclick="javascript:basket.checkItem();">&nbsp;
									</div>
									<div class="img">
										<img src="./img/basket1.jpg" width="60">
									</div>
									<div class="pname">
										<span>찜마마(XJ-92214/3)</span>
									</div>
								</div>
								<div class="subdiv">
									<div class="basketprice">
										<input type="hidden" name="p_price" id="p_price1"
											class="p_price" value="20000">20,000원
									</div>
									<div class="num">
										<div class="updown">
											<input type="text" name="p_num1" id="p_num1" size="2"
												maxlength="4" class="p_num" value="2"
												onkeyup="javascript:basket.changePNum(1);"> <span
												onclick="javascript:basket.changePNum(1);"><i
												class="fas fa-arrow-alt-circle-up up"></i></span> <span
												onclick="javascript:basket.changePNum(1);"><i
												class="fas fa-arrow-alt-circle-down down"></i></span>
										</div>
									</div>
									<div class="sum">40,000원</div>
								</div>
								<div class="subdiv">
									<div class="basketcmd">
										<a href="javascript:void(0)" class="abutton"
											onclick="javascript:basket.delItem();">삭제</a>
									</div>
								</div>
							</div>
							<div class="row data">
								<div class="subdiv">
									<div class="check">
										<input type="checkbox" name="buy" value="261" checked=""
											onclick="javascript:basket.checkItem();">&nbsp;
									</div>
									<div class="img">
										<img src="./img/basket2.jpg" width="60">
									</div>
									<div class="pname">
										<span>노바 요거팜(JP-268T)</span>
									</div>
								</div>
								<div class="subdiv">
									<div class="basketprice">
										<input type="hidden" name="p_price" id="p_price2"
											class="p_price" value="19000">19,000원
									</div>
									<div class="num">
										<div class="updown">
											<input type="text" name="p_num2" id="p_num2" size="2"
												maxlength="4" class="p_num" value="1"
												onkeyup="javascript:basket.changePNum(2);"> <span
												onclick="javascript:basket.changePNum(2);"><i
												class="fas fa-arrow-alt-circle-up up"></i></span> <span
												onclick="javascript:basket.changePNum(2);"><i
												class="fas fa-arrow-alt-circle-down down"></i></span>
										</div>
									</div>
									<div class="sum">19,000원</div>
								</div>
								<div class="subdiv">
									<div class="basketcmd">
										<a href="javascript:void(0)" class="abutton"
											onclick="javascript:basket.delItem();">삭제</a>
									</div>
								</div>
							</div>
							<div class="row data">
								<div class="subdiv">
									<div class="check">
										<input type="checkbox" name="buy" value="262" checked=""
											onclick="javascript:basket.checkItem();">&nbsp;
									</div>
									<div class="img">
										<img src="./img/basket3.jpg" width="60">
									</div>
									<div class="pname">
										<span>아날도 바시니 보스톤 가방 20인치 (ab-380)</span>
									</div>
								</div>
								<div class="subdiv">
									<div class="basketprice">
										<input type="hidden" name="p_price" id="p_price3"
											class="p_price" value="15200">15,200원
									</div>
									<div class="num">
										<div class="updown">
											<input type="text" name="p_num3" id="p_num3" size="2"
												maxlength="4" class="p_num" value="1"
												onkeyup="javascript:basket.changePNum(3);"> <span
												onclick="javascript:basket.changePNum(3);"><i
												class="fas fa-arrow-alt-circle-up up"></i></span> <span
												onclick="javascript:basket.changePNum(3);"><i
												class="fas fa-arrow-alt-circle-down down"></i></span>
										</div>
									</div>
									<div class="sum">15,200원</div>
								</div>
								<div class="subdiv">
									<div class="basketcmd">
										<a href="javascript:void(0)" class="abutton"
											onclick="javascript:basket.delItem();">삭제</a>
									</div>
								</div>
							</div>
	
						</div>
	
						<div class="right-align basketrowcmd">
							<a href="javascript:void(0)" class="abutton"
								onclick="javascript:basket.delCheckedItem();">선택상품삭제</a> <a
								href="javascript:void(0)" class="abutton"
								onclick="javascript:basket.delAllItem();">장바구니비우기</a>
						</div>
	
						<div class="bigtext right-align sumcount" id="sum_p_num">상품갯수:
							4개</div>
						<div class="bigtext right-align box blue summoney" id="sum_p_price">합계금액:
							74,200원</div>
	
						<div id="goorder" class="">
							<div class="clear"></div>
							<div class="buttongroup center-align cmd">
								<a href="javascript:void(0);">선택한 상품 주문</a>
							</div>
						</div>
					</form>
					
					
					<table class="table">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">제품이름</th>
							<th scope="col">작성자</th>
							<th scope="col">제품가격</th>
							<th scope="col">등록날짜</th>
							<th scope="col">승인여부</th>
							<th scope="col">삭제여부</th>
							<th scope="col">삭제</th>
							<th scope="col">완전삭제</th>
							<th scope="col">승인</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${cart}" var="c">
							<tr>
								<th scope='row'>${c.cart_no }</th>
								<td>${p.p_name }</td>
								<td>${p.u_name }</td>
								<td>${p.p_price }</td>
								<td>${p.p_date }</td>
								<td>${p.p_confirm }</td>
								<td>${p.p_del }</td>
								<td>
								<button onclick="del(${c.cart_no})">삭제</button>
								<button onclick="repair(${p.p_no})">복구</button>
								</td>
								<td><button onclick="pdelete(${p.p_no})">완전삭제</button></td>
								<td>
								<button onclick="admission(${p.p_no})">승인</button>
								<button onclick="adcancel(${p.p_no})">취소</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
						 <%-- <td><a href="./cartDelete.do?cart_no=${cart.cart_no}">[삭제]</a></td> --%>
						<!-- 삭제 버튼을 누르면 delete.do로 장바구니 개별 id (삭제하길원하는 장바구니 id)를 보내서 삭제한다. -->
					
					${cart}
						
						
						
					</div>
					<!-- /row -->
				</div>
				<!-- /container -->
			</div>
			<!-- /SECTION -->
			
			<div class="section">
				<div class="container">
					<div class="row">
						
						
					</div>
				</div>
			</div>
			
			<!-- Section -->
			<div class="section">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
	
						<div class="col-md-12">
							<div class="section-title text-center">
								<h3 class="title">Related Products</h3>
							</div>
						</div>
	
						<!-- product -->
						<div class="col-md-3 col-xs-6">
							<div class="product">
								<div class="product-img">
									<img src="./img/product01.png" alt="">
									<div class="product-label">
										<span class="sale">-30%</span>
									</div>
								</div>
								<div class="product-body">
									<p class="product-category">Category</p>
									<h3 class="product-name"><a href="#">product name goes here</a></h3>
									<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									<div class="product-rating">
									</div>
									<div class="product-btns">
										<button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
										<button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
										<button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
									</div>
								</div>
								<div class="add-to-cart">
									<button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
								</div>
							</div>
						</div>
						<!-- /product -->
	
						<!-- product -->
						<div class="col-md-3 col-xs-6">
							<div class="product">
								<div class="product-img">
									<img src="./img/product02.png" alt="">
									<div class="product-label">
										<span class="new">NEW</span>
									</div>
								</div>
								<div class="product-body">
									<p class="product-category">Category</p>
									<h3 class="product-name"><a href="#">product name goes here</a></h3>
									<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									<div class="product-rating">
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
									</div>
									<div class="product-btns">
										<button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
										<button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
										<button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
									</div>
								</div>
								<div class="add-to-cart">
									<button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
								</div>
							</div>
						</div>
						<!-- /product -->
	
						<div class="clearfix visible-sm visible-xs"></div>
	
						<!-- product -->
						<div class="col-md-3 col-xs-6">
							<div class="product">
								<div class="product-img">
									<img src="./img/product03.png" alt="">
								</div>
								<div class="product-body">
									<p class="product-category">Category</p>
									<h3 class="product-name"><a href="#">product name goes here</a></h3>
									<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									<div class="product-rating">
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star-o"></i>
									</div>
									<div class="product-btns">
										<button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
										<button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
										<button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
									</div>
								</div>
								<div class="add-to-cart">
									<button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
								</div>
							</div>
						</div>
						<!-- /product -->
	
						<!-- product -->
						<div class="col-md-3 col-xs-6">
							<div class="product">
								<div class="product-img">
									<img src="./img/product04.png" alt="">
								</div>
								<div class="product-body">
									<p class="product-category">Category</p>
									<h3 class="product-name"><a href="#">product name goes here</a></h3>
									<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									<div class="product-rating">
									</div>
									<div class="product-btns">
										<button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
										<button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
										<button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
									</div>
								</div>
								<div class="add-to-cart">
									<button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
								</div>
							</div>
						</div>
						<!-- /product -->
	
					</div>
					<!-- /row -->
				</div>
				<!-- /container -->
			</div>
			<!-- /Section -->
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
