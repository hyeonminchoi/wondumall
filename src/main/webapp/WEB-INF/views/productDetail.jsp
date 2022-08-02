<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
.starRev {
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

.starP1 {
	background: url('./img/star.png') no-repeat -52px 0;
	background-size: auto 100%;
	width: 15px;
	height: 30px;
	float: left;
	text-indent: -9999px;
	cursor: pointer;
}

.starP2 {
	background: url('./img/star.png') no-repeat right 0;
	background-size: auto 100%;
	width: 15px;
	height: 30px;
	float: left;
	text-indent: -9999px;
	cursor: pointer;
}

.starP1.on {
	background-position: 0 0;
}

.starP2.on {
	background-position: -15px 0;
}

/* .c_product_title_style2 .title, .c_product_title_style3 .title {
    color: #111;
    font-size: 22px;
}
.c_product_title .title {
    display: inline-block;
    font-weight: bold;
    font-size: 18px;
    color: #000;
}
body, h1, h2, h3, h4, th, td, input, select, textarea, button {
    font-size: 14px;
    line-height: 1.5;
    font-family: "Noto Sans KR", "Helvetica Neue", "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", "돋움", dotum, sans-serif;
    color: #666;
    letter-spacing: 0;
} */
textarea {
	resize: none;
}
/* 이모지 별점 */
#myform fieldset {
	display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
	border: 0; /* 필드셋 테두리 제거 */
}

#myform label:hover {
	text-shadow: 0 0 0 #a00; /* 마우스 호버 */
}

#myform label:hover ~ label {
	text-shadow: 0 0 0 #a00; /* 마우스 호버 뒤에오는 이모지들 */
}

.review-body {
	margin-left: 30px;
}

.link-icon {
	position: relative;
	display: inline-block;
	width: auto;
	font-size: 14px;
	font-weight: 500;
	color: #333;
	background-repeat: no-repeat;
	cursor: pointer;
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
			location.href = "./productDetail.do?p_no=${param.p_no}&reviewPageNo=" + reviewPageNo + "#reviewHref";
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
		<!-- HEADER -->
		<main>
			<div id="cont">
				<div id="float_layer">
					<c:import url="./recentlySee.jsp"></c:import>
				</div>
			</div>
		</main>
	<!-- /HEADER -->
		<!-- BREADCRUMB -->
		<section>
			<div id="breadcrumb" class="section">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<div class="col-md-12">
							<h3 class="breadcrumb-header" style="font-size: 24px; color: #2B2D42; line-height: 1.1;">상세상품</h3>
							<ul class="breadcrumb-tree">
								<li><a href="./">Home</a></li>
								<li><a href="./category.do">All Categories</a></li>
								<li><a href="./category.do?cate_no=${cateName.cate_no }">${cateName.category}</a></li>
								<li class="active">${productDetail.p_name}</li>
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
								<div class="product-preview"  style="display: block;">
									<img src="./productUpload/${productDetail.p_img}" alt="">
								</div>
							</div>
						</div>
						<!-- /Product main img -->
	
						<!-- Product thumb imgs -->
						<div class="col-md-2  col-md-pull-5">
						</div>
						<!-- /Product thumb imgs -->
	
						<!-- Product details -->
						<div class="col-md-5">
							<div class="product-details">
								<h2 class="product-name">${productDetail.p_name}</h2>
								<div>
									<div class="starRev">
										<span class="starR1 ${reviewRating>=0.5?'on':'' }">0.5</span>
										<span class="starR2 ${reviewRating>=1?'on':'' }">1</span>
										<span class="starR1 ${reviewRating>=1.5?'on':'' }">1.5</span>
										<span class="starR2 ${reviewRating>=2?'on':'' }">2</span>
										<span class="starR1 ${reviewRating>=2.5?'on':'' }">2.5</span>
										<span class="starR2 ${reviewRating>=3?'on':'' }">3</span>
										<span class="starR1 ${reviewRating>=3.5?'on':'' }">3.5</span>
										<span class="starR2 ${reviewRating>=4?'on':'' }">4</span>
										<span class="starR1 ${reviewRating>=4.5?'on':'' }">4.5</span>
										<span class="starR2 ${reviewRating>=5?'on':'' }">5</span>
									</div>
									<a class="review-link" href="#reviewHref">${reviewCount} Review(s) | Add your review</a>
								</div>
								<div>
									<h3 class="product-price"><fmt:formatNumber pattern="###,###,###" value="${productDetail.p_price}" />원</h3>
									<span class="product-available">남은 수량</span> <div class="product-old-price" style="display: inline;">${productDetail.p_stock}개</div>
								</div>
								${productDetail.p_description}
	
								<div class="product-options">
								</div>
	
								<form action="./cartAdd.do" method="post">
								<div class="add-to-cart">
									<div class="qty-label">
										Qty
										<div class="input-number">
											<input type="number" name="p_count" required >
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
	
								<ul class="product-links">
									<li>Category:</li>
									<li><a href="./category.do?cate_no=${cateName.cate_no }">${cateName.category}</a></li>
								</ul>
	
								<ul class="product-links">
									<li>Share:</li>
									<!-- <li><a href="javascript:shareTwitter();"><i class="fa fa-twitter"></i></a></li>
									<li><a href="javascript:shareFacebook();"><i class="fa fa-facebook"></i></a></li>
									<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
									<li><a href="#"><i class="fa fa-envelope"></i></a></li> -->
									<li><a id="btnTwitter" href="javascript:shareTwitter();"><img src="./img/icon-twitter.png" class="link-icon twitter"></a></li>
									<li><a id="btnFacebook" href="javascript:shareFacebook();"><img src="./img/icon-facebook.png" class="link-icon facebook"></a></li>
									<li><a id="btnKakao" href="javascript:shareKakao();"><img src="./img/icon-kakao.png" class="link-icon kakao"></a></li>
								</ul>
	
							</div>
						</div>
						<!-- /Product details -->
	
						<!-- Product tab -->
						<div class="col-md-12">
							<div id="product-tab">
								<!-- product tab nav -->
								<ul class="tab-nav">
									<!-- <li class="active"><a data-toggle="tab" href="#tab1">Description</a></li> -->
									<li><a data-toggle="tab" href="#tab2">Details</a></li>
								</ul>
								<!-- /product tab nav -->
	
								<!-- product tab content -->
								<div class="tab-content">
									<!-- tab1  -->
									<div id="tab1" class="tab-pane fade in active">
										<div class="row">
											<div class="col-md-12">
												<p>${productDetail.p_description}</p>
											</div>
										</div>
									</div>
									<!-- /tab1  -->
	
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
		<div class="section" >
				<div class="container">
					<div class="row">
						<div id="reviewHref">
							<div id="product-tab">
								<ul class="tab-nav">
									<li><a href="#tab3">Reviews (${reviewCount})</a></li>
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
														<legend>별점</legend>
														<input type="radio" name="r_rating" value="1" id="rate1" required><label for="rate1">⭐</label>
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
			</div>
				<!-- Section -->
			<div class="section" style="margin-bottom: 150px;">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<div id="tab3" class="tab-pane fade in">
							<div class="row">
								<!-- Rating -->
								<div class="col-md-3">
									<div id="rating">
											<c:choose>
												<c:when test="${reviewRating ne null}">
										<div class="rating-avg">
													<span>구매만족도</span>
											<div>
												${reviewRating}
												<div style="display: inline;">
												<i style="font-size: 17px; margin-left: 7px;">${reviewCount}건</i>
												</div>
											</div>
											<div>
											</div>
											<div class="starRev">
												<span class="starR1 ${reviewRating>=0.5?'on':'' }">0.5</span>
												<span class="starR2 ${reviewRating>=1?'on':'' }">1</span>
												<span class="starR1 ${reviewRating>=1.5?'on':'' }">1.5</span>
												<span class="starR2 ${reviewRating>=2?'on':'' }">2</span>
												<span class="starR1 ${reviewRating>=2.5?'on':'' }">2.5</span>
												<span class="starR2 ${reviewRating>=3?'on':'' }">3</span>
												<span class="starR1 ${reviewRating>=3.5?'on':'' }">3.5</span>
												<span class="starR2 ${reviewRating>=4?'on':'' }">4</span>
												<span class="starR1 ${reviewRating>=4.5?'on':'' }">4.5</span>
												<span class="starR2 ${reviewRating>=5?'on':'' }">5</span>
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
													<div style="width: ${rating[5] * 100 / reviewCount}%;"></div>
												</div> <span class="sum">${rating[5]}</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div style="width: ${rating[4] * 100 / reviewCount}%;"></div>
												</div> <span class="sum">${rating[4]}</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i
														class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div style="width: ${rating[3] * 100 / reviewCount}%;"></div>
												</div> <span class="sum">${rating[3]}</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
														class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div style="width: ${rating[2] * 100 / reviewCount}%;"></div>
												</div> <span class="sum">${rating[2]}</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i
														class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
														class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div style="width: ${rating[1] * 100 / reviewCount}%;"></div>
												</div> <span class="sum">${rating[1]}</span>
											</li>
										</ul>
												</c:when>
												<c:otherwise>
												<h4 class="rTitle">상품리뷰
													<span class="rSub"><i>0</i>건</span>
												</h4>
												</c:otherwise>
											</c:choose>
											
									</div>
								</div>
		
								<!-- /Rating -->
								<!-- Reviews -->
								<div class="col-md-6">
									<div id="reviews">
										<c:choose>
											<c:when test="${fn:length(reviewList) > 0}">
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
																<div class="starRev">
																	<span class="starP1 ${r.r_rating>=0.5?'on':'' }">0.5</span>
																	<span class="starP2 ${r.r_rating>=1?'on':'' }">1</span>
																	<span class="starP1 ${r.r_rating>=1.5?'on':'' }">1.5</span>
																	<span class="starP2 ${r.r_rating>=2?'on':'' }">2</span>
																	<span class="starP1 ${r.r_rating>=2.5?'on':'' }">2.5</span>
																	<span class="starP2 ${r.r_rating>=3?'on':'' }">3</span>
																	<span class="starP1 ${r.r_rating>=3.5?'on':'' }">3.5</span>
																	<span class="starP2 ${r.r_rating>=4?'on':'' }">4</span>
																	<span class="starP1 ${r.r_rating>=4.5?'on':'' }">4.5</span>
																	<span class="starP2 ${r.r_rating>=5?'on':'' }">5</span>
																</div>
															</div>
															<div class="review-body">
																<h6>${r.r_title}</h6>
																<p>${r.r_content}</p>
															</div>
														</li>
													</ul>
												</c:forEach>
												<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage"/>
											</c:when>
											<c:otherwise>
												<div>
													<h4>등록된 리뷰가 없습니다.</h4>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<!-- /Reviews -->
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /Section -->
		</section>
		

		<!-- FOOTER -->
		<footer id="footer">
			<c:import url="./footer.jsp"></c:import>
		</footer>
		<!-- /FOOTER -->
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			shareKakao()
		});
		
		function shareTwitter() {
		    var sendText = "twitter"; // 전달할 텍스트
		    var sendUrl = "twitter.com"; // 전달할 URL
		    window.open("https://twitter.com/intent/tweet?text=" + sendText + "&url=" + sendUrl);
		}
		function shareFacebook() {
		    var sendUrl = "facebook.com/"; // 전달할 URL
		    window.open("http://www.facebook.com/sharer/sharer.php?u=" + sendUrl);
		}

		function shareKakao() {
		 
		  // 사용할 앱의 JavaScript 키 설정
		  Kakao.init('');
		 
		  // 카카오링크 버튼 생성
		  Kakao.Link.createDefaultButton({
		    container: '#btnKakao', // 카카오공유버튼ID
		    objectType: 'feed',
		    content: {
		      title: "WonduMall test", // 보여질 제목
		      description: "Spring Project Test입니다.", // 보여질 설명
		      imageUrl: "https://developers.kakao.com", // 콘텐츠 URL
		      link: {
		         mobileWebUrl: window.location.href,
		         webUrl: window.location.href
		      }
		    }
		  });
		}
	</script>
	</body>
</html>