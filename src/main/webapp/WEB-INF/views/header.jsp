<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<sec:authentication property="principal" var="user"/>
<!-- TOP HEADER -->
<sec:authorize access="authenticated">
<script type="text/javascript">
function cartCount(u_no){
	$.ajax({
		url:'./cartCount.do',
		type:'post',
		data:{u_no:u_no},
		success: function(data){
			$('.qty').text(data);
		},
		error: function(error){
			console.log(error);
		}
	})
}
window.onload = function(){
	cartCount('<sec:authentication property='principal.no'/>')
}
</script>
</sec:authorize>
<div id="top-header">
	<div class="container">
		<ul class="header-links pull-left">
			<li><a href="#"><i class="fa fa-phone"></i> +021-95-51-84</a></li>
			<li><a href="#"><i class="fa fa-envelope-o"></i>
					email@email.com</a></li>
			<li><a href="#"><i class="fa fa-map-marker"></i> 1734
					Stonecoal Road</a></li>
		</ul>
		<ul class="header-links pull-right">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="./admin/index.do">관리자페이지</a></li>
			</sec:authorize>
			<li><a href="./notice.do"><i class="fa fa-users"></i> 커뮤니티</a></li>
			<li><a href="#"><i class="fa fa-dollar"></i> WON</a></li>
			<sec:authorize access="authenticated">
				<div style="float:right;">
					<li><a href="./logout.do"><i class="fa fa-user-o"></i> 로그아웃</a></li>
				</div>
			</sec:authorize>
			<sec:authorize access="not authenticated">
				<div style="float:right;">
					<li><a href="./login.do"><i class="fa fa-user-o"></i> 로그인</a></li>
				</div>
			</sec:authorize>
		</ul>
	</div>
</div>
<!-- /TOP HEADER -->

<!-- MAIN HEADER -->
<div id="header">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<!-- LOGO -->
			<div class="col-md-3">
				<div class="header-logo">
					<a href="./" class="logo"> <img src="./img/logo.png" alt="">
					</a>
				</div>
			</div>
			<!-- /LOGO -->

			<!-- SEARCH BAR -->
			<div class="col-md-6">
				<div class="header-search">
					<form>
						<select class="input-select">
							<option value="0">All Categories</option>
							<option value="1">Category 01</option>
							<option value="1">Category 02</option>
						</select> <input class="input" placeholder="Search here">
						<button class="search-btn">Search</button>
					</form>
				</div>
			</div>
			<!-- /SEARCH BAR -->

			<!-- ACCOUNT -->
			<div class="col-md-3 clearfix">
				<div class="header-ctn">
					<!-- Wishlist -->
					<div>
						<a href="#"> <i class="fa fa-heart-o"></i> <span>Your
								Wishlist</span>
							<div class="qty">2</div>
						</a>
					</div>
					<!-- /Wishlist -->

					<!-- Cart -->
					<div class="dropdown">
						<c:choose>
							<c:when test="${user ne 'anonymousUser'}">
								<a href="./cart.do?u_no=<sec:authentication property='principal.no'/>" class="dropdown-toggle" > <i class="fa fa-shopping-cart"></i> 
								<span>Your Cart</span>
									<div class="qty">0</div>
								</a>
							</c:when>
							<c:otherwise>
								<a href="./login.do" class="dropdown-toggle" > <i class="fa fa-shopping-cart"></i> 
								<span>Your Cart</span>
									<div class="qty">0</div>
								</a>
							</c:otherwise>
						</c:choose>
						<div class="cart-dropdown">
							<div class="cart-list">
								<div class="product-widget">
									<div class="product-img">
										<img src="./img/product01.png" alt="">
									</div>
									<div class="product-body">
										<h3 class="product-name">
											<a href="#">product name goes here</a>
										</h3>
										<h4 class="product-price">
											<span class="qty">1x</span>$980.00
										</h4>
									</div>
									<button class="delete">
										<i class="fa fa-close"></i>
									</button>
								</div>

								<div class="product-widget">
									<div class="product-img">
										<img src="./img/product02.png" alt="">
									</div>
									<div class="product-body">
										<h3 class="product-name">
											<a href="#">product name goes here</a>
										</h3>
										<h4 class="product-price">
											<span class="qty">3x</span>$980.00
										</h4>
									</div>
									<button class="delete">
										<i class="fa fa-close"></i>
									</button>
								</div>
							</div>
							<div class="cart-summary">
								<small>3 Item(s) selected</small>
								<h5>SUBTOTAL: $2940.00</h5>
							</div>
							<div class="cart-btns">
								<a href="#">View Cart</a> <a href="#">Checkout <i
									class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>
					<!-- /Cart -->

					<!-- Menu Toogle -->
					<div class="menu-toggle">
						<a href="#"> <i class="fa fa-bars"></i> <span>Menu</span>
						</a>
					</div>
					<!-- /Menu Toogle -->
				</div>
			</div>
			<!-- /ACCOUNT -->
		</div>
		<!-- row -->
	</div>
	<!-- container -->
</div>
<!-- /MAIN HEADER -->