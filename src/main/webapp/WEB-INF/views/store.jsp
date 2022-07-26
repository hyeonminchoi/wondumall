<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title></title>

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

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style>
		.starRev{
			margin: 0 auto;
		}
		.starR1 {
			background:
				url('http://miuu227.godohosting.com/images/icon/ico_review.png')
				no-repeat -52px 0;
			background-size: auto 100%;
			width: 15px;
			height: 30px;
			float: left;
			text-indent: -9999px;
			cursor: pointer;
		}
		.starR2 {
			background:
				url('http://miuu227.godohosting.com/images/icon/ico_review.png')
				no-repeat right 0;
			background-size: auto 100%;
			width: 15px;
			height: 30px;
			float: left;
			text-indent: -9999px;
			cursor: pointer;
		}
		.starR1.on {
			background-position: 0 0;
		}
		.starR2.on {
			background-position: -15px 0;
		}
		</style>
		
		<!-- jQuery Plugins -->
		<script src="./js/jquery.min.js"></script>
		<script src="./js/bootstrap.min.js"></script>
		<script src="./js/slick.min.js"></script>
		<script src="./js/nouislider.min.js"></script>
		<script src="./js/jquery.zoom.min.js"></script>
		<script src="./js/main.js"></script>
		
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

		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- ASIDE -->
					<div id="aside" class="col-md-3">
						<!-- aside Widget -->
						<div class="aside">
							<h3 class="aside-title">Categories</h3>
							<div class="checkbox-filter">
								<c:forEach var="c" items="${categoryList }" begin="1">
									<div class="input-checkbox">
										<input type="checkbox" name="category">
										<label>
											${c.category }
										</label>
									</div>
								</c:forEach>
							</div>
						</div>
						<!-- /aside Widget -->

						<!-- aside Widget -->
						<div class="aside">
							<h3 class="aside-title">Price</h3>
							<div class="price-filter">
								<div id="price-slider"></div>
								<div class="input-number price-min">
									<input id="price-min" type="number" >
								</div>
								<span>-</span>
								<div class="input-number price-max">
									<input id="price-max" type="number">
								</div>
							</div>
						</div>
						<!-- /aside Widget -->
					</div>
					<!-- /ASIDE -->

					<!-- STORE -->
					<div id="store" class="col-md-9">
						<!-- store top filter -->
						<div class="store-filter clearfix">
							<div class="store-sort">
								<label>
									Sort By:
									<select class="input-select">
										<option value="0">Price↑</option>
										<option value="1">Price↓</option>
										<option value="2">Rating↑</option>
										<option value="3">Rating↓</option>
									</select>
								</label>
							</div>
						</div>
						<!-- /store top filter -->

						<!-- store products -->
						<div class="row">
							<!-- product -->
							<c:forEach var="p" items="${productList}">
								<div class="col-md-4 col-xs-6">
									<div class="product">
										<div class="product-img">
											<img src="./productUpload/${p.p_img}" alt="">
										</div>
										<div class="product-body">
											<p class="product-category">${p.category }</p>
											<h3 class="product-name"><a href="#">${p.p_name }</a></h3>
											<h4 class="product-price">${p.p_price }</h4>
											<div class="starRev">
												<span class="starR1 ${p.rating>0.5?'on':'' }">0.5</span>
												<span class="starR2 ${p.rating>1?'on':'' }">1</span>
												<span class="starR1 ${p.rating>1.5?'on':'' }">1.5</span>
												<span class="starR2 ${p.rating>2?'on':'' }">2</span>
												<span class="starR1 ${p.rating>2.5?'on':'' }">2.5</span>
												<span class="starR2 ${p.rating>3?'on':'' }">3</span>
												<span class="starR1 ${p.rating>3.5?'on':'' }">3.5</span>
												<span class="starR2 ${p.rating>4?'on':'' }">4</span>
												<span class="starR1 ${p.rating>4.5?'on':'' }">4.5</span>
												<span class="starR2 ${p.rating>5?'on':'' }">5</span>
											</div>
										</div>
										<div class="add-to-cart">
											<button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
										</div>
									</div>
								</div>
								<!-- /product -->
							</c:forEach>
						</div>
						<!-- /store products -->
					</div>
					<!-- /STORE -->
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->

		<!-- FOOTER -->
		<footer id="footer">
			<c:import url="./footer.jsp"></c:import>
		</footer>
		<!-- /FOOTER -->


	</body>
</html>
