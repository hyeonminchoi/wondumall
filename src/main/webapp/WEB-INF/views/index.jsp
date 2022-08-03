<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title>wondumall</title>

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
		/* 별점 */
		.starRev{
			width: 170px;
			margin: 0 auto;
			height: 30px;
			display: inline-block;
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
    </head>
	<body>
		<!-- HEADER -->
		<header>
			<c:import url="/header.do"></c:import>
		</header>
		<!-- /HEADER -->

		<!-- NAVIGATION -->
		<nav id="navigation">
			<c:import url="/nav.do"></c:import>
		</nav>
		<!-- /NAVIGATION -->
		<!-- HEADER -->
		<main>
			<div id="cont">
				<div id="float_layer">
					<c:import url="./recentlySee.jsp"></c:import>
				</div>
			</div>
		</main>
		<!-- /HEADER -->
		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- shop -->
					<div class="col-md-4 col-xs-6">
						<div class="shop">
							<div class="shop-img">
								<img src="./img/coffeeBean.png" alt="" onclick="location.href='./category.do?cate_no=2';" style="cursor: pointer;">
							</div>
							<div class="shop-body">
								<h3>Coffee Beans<br>Collection</h3>
								<a href="./category.do?cate_no=2" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>
					<!-- /shop -->

					<!-- shop -->
					<div class="col-md-4 col-xs-6">
						<div class="shop">
							<div class="shop-img">
								<img src="./img/coffeeMachine.png" alt="" onclick="location.href='./category.do?cate_no=3';" style="cursor: pointer;">
							</div>
							<div class="shop-body">
								<h3>Coffee Machine<br>Collection</h3>
								<a href="./category.do?cate_no=3" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>
					<!-- /shop -->

					<!-- shop -->
					<div class="col-md-4 col-xs-6">
						<div class="shop">
							<div class="shop-img">
								<img src="./img/Accessory.png" alt="" onclick="location.href='./category.do?cate_no=4';" style="cursor: pointer;">
							</div>
							<div class="shop-body">
								<h3>Accessories<br>Collection</h3>
								<a href="./category.do?cate_no=4" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>
					<!-- /shop -->
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->

		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">

					<!-- section title -->
					<div class="col-md-12">
						<div class="section-title">
							<h3 class="title">New Products</h3>
							<div class="section-nav">
								<ul class="section-tab-nav tab-nav">
									<c:forEach var="c" items="${categoryList }" varStatus="status">
										<li ${status.index eq 0?'class="active"':'' }><a data-toggle="tab" href="#tab${status.index }">${c.category }</a>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
					<!-- /section title -->
					
					<!-- Products tab & slick -->
					<div class="col-md-12">
						<div class="row">
							<div class="products-tabs">
								<!-- tab -->
								<c:forEach var="c" items="${productList }" varStatus="status">
									<div id="tab${status.index }" class="tab-pane ${status.index eq 0?'active':'' }">
										<div class="products-slick" data-nav="#slick-nav-${status.index }">
											<c:forEach items="${c}" var="p">
												<!-- product -->
												<div class="product">
													<div class="product-img">
														<img src="./productUpload/${p.p_img}" alt="로딩 실패">
														<div class="product-label">
															<span class="new">NEW</span>
														</div>
													</div>
													<div class="product-body">
														<p class="product-category">${p.category }</p>
														<h3 class="product-name"><a href="./productDetail.do?p_no=${p.p_no}">${p.p_name}</a></h3>
														<h4 class="product-price">$${p.p_price}</h4>
														<div class="starRev">
															<span class="starR1 ${p.rating>=0.5?'on':'' }"></span>
															<span class="starR2 ${p.rating>=1?'on':'' }"></span>
															<span class="starR1 ${p.rating>=1.5?'on':'' }"></span>
															<span class="starR2 ${p.rating>=2?'on':'' }"></span>
															<span class="starR1 ${p.rating>=2.5?'on':'' }"></span>
															<span class="starR2 ${p.rating>=3?'on':'' }"></span>
															<span class="starR1 ${p.rating>=3.5?'on':'' }"></span>
															<span class="starR2 ${p.rating>=4?'on':'' }"></span>
															<span class="starR1 ${p.rating>=4.5?'on':'' }"></span>
															<span class="starR2 ${p.rating>=5?'on':'' }"></span>
														</div>
													</div>
													<div class="add-to-cart">
														<button class="add-to-cart-btn" onclick="location.href='./productDetail.do?p_no=${p.p_no}'"><i class="fa fa-shopping-cart"></i>상세보기</button>
													</div>
												</div>
												<!-- /product -->
											</c:forEach>
										</div>
										<div id="slick-nav-${status.index }" class="products-slick-nav"></div>
									</div>
									<!-- /tab -->
								</c:forEach>
							</div>
						</div>
					</div>
					<!-- Products tab & slick -->

				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->

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
