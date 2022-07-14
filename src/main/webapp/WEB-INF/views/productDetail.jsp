<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title>상품 상세 페이지</title>

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
<style type="text/css">
textarea {
	resize: none;
}
/* 이모지 별점 */
#myform fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    border: 0; /* 필드셋 테두리 제거 */
}

#myform label:hover {
	text-shadow: 0 0 0 #a00; /* 마우스 호버 */
}

#myform label:hover ~ label {
	text-shadow: 0 0 0 #a00; /* 마우스 호버 뒤에오는 이모지들 */
}
</style>
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		<!-- jQuery Plugins -->
		<script src="./js/jquery.min.js"></script>
		<script src="./js/bootstrap.min.js"></script>
		<script src="./js/slick.min.js"></script>
		<script src="./js/nouislider.min.js"></script>
		<script src="./js/jquery.zoom.min.js"></script>
		<script src="./js/main.js"></script>
	<script>
		$(function(){
			if(${not empty param.result} && ${param.result == 1}){
				alert("장바구니 추가 성공")
			} else if(${not empty param.result} && ${param.result == 0}){
				alert("장바구니 추가 실패")
			} 
		})
		function loginBtn(){
			alert('로그인을 하세요');
			location.href='./login.do';
		}
		/* $(document).ready(function(){
			$("#Btn").click(function(){
				alert('리뷰 등륵 완료하였습니다!');
			});
		}); */
		function linkPage(reviewPageNo){
			location.href = "./productDetail.do?p_no=${param.p_no}&reviewPageNo=" + reviewPageNo;
		}
	</script>

</head>
	<body>
		<!-- HEADER -->
		<header>
			<c:import url="./header.jsp"></c:import>
		</header>
		<!-- /HEADER -->

		<!-- NAVIGATION -->
		<nav id="navigation">
			<c:import url="./nav.jsp"></c:import>
		</nav>
		<!-- /NAVIGATION -->
		<!-- BREADCRUMB -->
		<section>
			<div id="breadcrumb" class="section">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<div class="col-md-12">
							<ul class="breadcrumb-tree">
								<li><a href="./">Home</a></li>
								<li><a href="./category.do">All Categories</a></li>
								<li><a href="#">Accessories</a></li>
								<li><a href="#">Headphones</a></li>
								<li class="active">Product name goes here</li>
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
						<!-- Product main img -->
						<div class="col-md-5 col-md-push-2">
							<div id="product-main-img">
								<div class="product-preview">
									<img src="./productUpload/${productDetail.p_img}" alt="">
								</div>
	
								<div class="product-preview">
									<img src="./img/product03.png" alt="">
								</div>
	
								<div class="product-preview">
									<img src="./img/product06.png" alt="">
								</div>
	
								<div class="product-preview">
									<img src="./img/product08.png" alt="">
								</div>
							</div>
						</div>
						<!-- /Product main img -->
	
						<!-- Product thumb imgs -->
						<div class="col-md-2  col-md-pull-5">
							<div id="product-imgs">
								<div class="product-preview">
									<img src="./productUpload/${productDetail.p_img}" alt="">
								</div>
	
								<div class="product-preview">
									<img src="./img/product03.png" alt="">
								</div>
	
								<div class="product-preview">
									<img src="./img/product06.png" alt="">
								</div>
	
								<div class="product-preview">
									<img src="./img/product08.png" alt="">
								</div>
							</div>
						</div>
						<!-- /Product thumb imgs -->
	
						<!-- Product details -->
						<div class="col-md-5">
							<div class="product-details">
								<h2 class="product-name">${productDetail.p_name}</h2>
								<div>
									<div class="product-rating">
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star-o"></i>
									</div>
									<a class="review-link" href="#">10 Review(s) | Add your review</a>
								</div>
								<div>
									<h3 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h3>
									<span class="product-available">In Stock</span>
								</div>
								${productDetail.p_description}
	
								<div class="product-options">
									<label>
										Size
										<select class="input-select">
											<option value="0">X</option>
										</select>
									</label>
									<label>
										Color
										<select class="input-select">
											<option value="0">Red</option>
										</select>
									</label>
								</div>
	
								<form action="./cartAdd.do" method="post">
								<div class="add-to-cart">
									<div class="qty-label">
										Qty
										<div class="input-number">
											<input type="number" name="p_count" required >
											<span class="qty-up">+</span>
											<span class="qty-down">-</span>
										</div>
									</div>
									<input type="hidden" value="${productDetail.p_no }" name="p_no">
									<sec:authentication property="principal" var="user"/>
									<c:if test="${user ne 'anonymousUser'}">
										<input type="hidden" value="<sec:authentication property="principal.no"/>" name="u_no">
									</c:if>
									<sec:authorize access="authenticated">
										<button type="submit" class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
									</sec:authorize>
									<sec:authorize access="not authenticated">
										<button type="button" class="add-to-cart-btn" onclick="loginBtn()"><i class="fa fa-shopping-cart"></i> add to cart</button>
									</sec:authorize>
								</div>
								</form>
	
								<ul class="product-btns">
									<li><a href="#"><i class="fa fa-heart-o"></i> add to wishlist</a></li>
									<li><a href="#"><i class="fa fa-exchange"></i> add to compare</a></li>
								</ul>
	
								<ul class="product-links">
									<li>Category:</li>
									<li><a href="#">Headphones</a></li>
									<li><a href="#">Accessories</a></li>
								</ul>
	
								<ul class="product-links">
									<li>Share:</li>
									<li><a href="#"><i class="fa fa-facebook"></i></a></li>
									<li><a href="#"><i class="fa fa-twitter"></i></a></li>
									<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
									<li><a href="#"><i class="fa fa-envelope"></i></a></li>
								</ul>
	
							</div>
						</div>
						<!-- /Product details -->
	
						<!-- Product tab -->
						<div class="col-md-12">
							<div id="product-tab">
								<!-- product tab nav -->
								<ul class="tab-nav">
									<li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
									<li><a data-toggle="tab" href="#tab2">Details</a></li>
									<li><a data-toggle="tab" href="#tab3">Reviews (3)</a></li>
								</ul>
								<!-- /product tab nav -->
	
								<!-- product tab content -->
								<div class="tab-content">
									<!-- tab1  -->
									<div id="tab1" class="tab-pane fade in active">
										<div class="row">
											<div class="col-md-12">
												<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
											</div>
										</div>
									</div>
									<!-- /tab1  -->
	
									<!-- tab2  -->
									<div id="tab2" class="tab-pane fade in">
										<div class="row">
											<div class="col-md-12">
												<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
											</div>
										</div>
									</div>
									<!-- /tab2  -->
	
									<!-- tab3  -->
									<div id="tab3" class="tab-pane fade in">
										<div class="row">
											<!-- Rating -->
											<div class="col-md-3">
												<div id="rating">
													<div class="rating-avg">
														<span>4.5</span>
														<div class="rating-stars">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o"></i>
														</div>
													</div>
													<ul class="rating">
														<li>
															<div class="rating-stars">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
															</div>
															<div class="rating-progress">
																<div style="width: 80%;"></div>
															</div>
															<span class="sum">3</span>
														</li>
														<li>
															<div class="rating-stars">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o"></i>
															</div>
															<div class="rating-progress">
																<div style="width: 60%;"></div>
															</div>
															<span class="sum">2</span>
														</li>
														<li>
															<div class="rating-stars">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
															</div>
															<div class="rating-progress">
																<div></div>
															</div>
															<span class="sum">0</span>
														</li>
														<li>
															<div class="rating-stars">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
															</div>
															<div class="rating-progress">
																<div></div>
															</div>
															<span class="sum">0</span>
														</li>
														<li>
															<div class="rating-stars">
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
															</div>
															<div class="rating-progress">
																<div></div>
															</div>
															<span class="sum">0</span>
														</li>
													</ul>
												</div>
											</div>
											<!-- /Rating -->
	
											<!-- Reviews -->
											<div class="col-md-6">
												<div id="reviews">
													<ul class="reviews">
														<li>
															<div class="review-heading">
																<h5 class="name">John</h5>
																<p class="date">27 DEC 2018, 8:0 PM</p>
																<div class="review-rating">
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star-o empty"></i>
																</div>
															</div>
															<div class="review-body">
																<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua</p>
															</div>
														</li>
														<li>
															<div class="review-heading">
																<h5 class="name">John</h5>
																<p class="date">27 DEC 2018, 8:0 PM</p>
																<div class="review-rating">
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star-o empty"></i>
																</div>
															</div>
															<div class="review-body">
																<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua</p>
															</div>
														</li>
														<li>
															<div class="review-heading">
																<h5 class="name">John</h5>
																<p class="date">27 DEC 2018, 8:0 PM</p>
																<div class="review-rating">
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star"></i>
																	<i class="fa fa-star-o empty"></i>
																</div>
															</div>
															<div class="review-body">
																<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua</p>
															</div>
														</li>
													</ul>
													<ul class="reviews-pagination">
														<li class="active">1</li>
														<li><a href="#">2</a></li>
														<li><a href="#">3</a></li>
														<li><a href="#">4</a></li>
														<li><a href="#"><i class="fa fa-angle-right"></i></a></li>
													</ul>
												</div>
											</div>
											<!-- /Reviews -->
										</div>
									</div>
									<!-- /tab3  -->
								</div>
								<!-- /product tab content  -->
							</div>
						</div>
						<!-- /product tab -->
					</div>
					<!-- /row -->
				</div>
				<!-- /container -->
			</div>
			<!-- /SECTION -->
		<div class="section">
				<div class="container">
					<div class="row">
							<div id="product-tab">
						<ul class="tab-nav">
							<li><a href="#tab3">Reviews (3)</a></li>
						</ul>
						</div>
							<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_BUSINESS','ROLE_USER')">
							<c:choose>
								<c:when test="${not empty reviewStatus and reviewStatus eq 0}">
									<form action="./productReview.do" method="POST" id="join" class="joinForm" name="reviewAdd">
											<div class="form-group row">
												<label class="col-sm-3">리뷰 제목</label>
												<div class="com-sm-3">
													<input type="text" id="r_title" name="r_title" class="form-control" required>
												</div>
											</div>
											<div class="form-group row">
												<label class="col-sm-3">리뷰 내용</label>
												<div class="com-sm-5">
													<textarea name="r_content" cols="50" rows="2" class="form-control" required></textarea>
												</div>
											</div>
											<div class="form-group row">
												<fieldset name="myform" id="myform">
													<legend>이모지 별점</legend>
													<input type="radio" name="r_rating" value="1" id="rate1"><label for="rate1">⭐</label>
													<input type="radio" name="r_rating" value="2" id="rate2"><label for="rate2">⭐⭐</label>
													<input type="radio" name="r_rating" value="3" id="rate3"><label for="rate3">⭐⭐⭐</label>
													<input type="radio" name="r_rating" value="4" id="rate4"><label for="rate4">⭐⭐⭐⭐</label>
													<input type="radio" name="r_rating" value="5" id="rate5"><label for="rate5">⭐⭐⭐⭐⭐</label>
												</fieldset>
											</div>
											<br>
										<input type="hidden" value="${productDetail.p_no }" name="p_no">
											<input type="hidden" value="<sec:authentication property="principal.no"/>" name="u_no">
										<button type="submit" id="Btn" class="primary-btn" value="등록하기" onclick="reviewAdd()">등록하기</button>
									</form>
								</c:when>
								<c:otherwise>
									<form action="./productReview.do" method="POST" id="join" class="joinForm" name="reviewAdd">
											<div class="form-group row">
												<label class="col-sm-3">리뷰 제목</label>
												<div class="com-sm-3">
													<input type="text" id="r_title" name="r_title" class="form-control" disabled="disabled" placeholder="리뷰를 등록한 상품입니다.">
												</div>
											</div>
											<div class="form-group row">
												<label class="col-sm-3">리뷰 내용</label>
												<div class="com-sm-5">
													<textarea name="r_content" cols="50" rows="2" class="form-control" disabled="disabled"></textarea>
												</div>
											</div>
											<div class="form-group row">
												<fieldset name="myform" id="myform" disabled="disabled">
													<legend>별점</legend>
													<input type="radio" name="r_rating" value="1" id="rate1"><label for="rate1">⭐</label>
													<input type="radio" name="r_rating" value="2" id="rate2"><label for="rate2">⭐⭐</label>
													<input type="radio" name="r_rating" value="3" id="rate3"><label for="rate3">⭐⭐⭐</label>
													<input type="radio" name="r_rating" value="4" id="rate4"><label for="rate4">⭐⭐⭐⭐</label>
													<input type="radio" name="r_rating" value="5" id="rate5"><label for="rate5">⭐⭐⭐⭐⭐</label>
												</fieldset>
											</div>
											<br>
											<input type="hidden" value="${productDetail.p_no }" name="p_no">
											<input type="hidden" value="<sec:authentication property="principal.no"/>" name="u_no">
										<button type="button" id="Btn" class="primary-btn" value="등록하기">등록하기</button>
									</form>
								</c:otherwise>
							</c:choose>
						</sec:authorize>
						
					</div>
				</div>
			</div>
				<!-- Section -->
			<div class="section">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<div id="tab3" class="tab-pane fade in">
							<div class="row">
								<!-- Rating -->
								<div class="col-md-3">
									<div id="rating">
										<div class="rating-avg">
											<span>점수 들어 갈 것</span>
											<div class="rating-stars">
												<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
													class="fa fa-star"></i> <i class="fa fa-star"></i> <i
													class="fa fa-star-o"></i>
											</div>
										</div>
										<ul class="rating">
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star"></i>
												</div>
												<div class="rating-progress">
													<div style="width: 80%;"></div>
												</div> <span class="sum">3</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div style="width: 60%;"></div>
												</div> <span class="sum">2</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i
														class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div></div>
												</div> <span class="sum">0</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
														class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div></div>
												</div> <span class="sum">0</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i
														class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
														class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div></div>
												</div> <span class="sum">0</span>
											</li>
										</ul>
									</div>
								</div>
		
								<!-- /Rating -->
								<!-- Reviews -->
								<div class="col-md-6">
									<div id="reviews">
										<table class="table table-bordered">
											<c:forEach items="${reviewList}" var="r">
												<ul class="reviews">
													<li>
														<div class="review-heading">
															<h5 class="name">${r.u_nickname}</h5>
															<p class="date">
															<fmt:parseDate value="${r.r_date}" var="time"
																pattern="yyyy-MM-dd HH:mm:ss.S" />
															<fmt:formatDate value="${time}" var="time"
																pattern="yyyy-MM-dd HH:mm:ss" />
															${time }
															<%-- ${r.r_date} --%>
															</p>
															<div class="review-rating">
																<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
																	class="fa fa-star"></i> <i class="fa fa-star"></i> <i
																	class="fa fa-star-o empty"></i>
															</div>
														</div>
														<div class="review-body">
															<h6>${r.r_title}</h6>
															<p>${r.r_content}</p>
														</div>
													</li>
												</ul>
											</c:forEach>
										</table>
										<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage"/>
									</div>
								</div>
		
								<!-- /Reviews -->
							</div>
						</div>
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

	</body>
</html>
