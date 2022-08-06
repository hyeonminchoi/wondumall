<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<sec:authentication property="principal" var="user"/>
<!-- TOP HEADER -->
<div id="top-header">
	<div class="container">
		<ul class="header-links pull-left">
			<li><a href="#"><i class="fa fa-phone"></i> 010-0000-0000</a></li>
			<li><a href="#"><i class="fa fa-envelope-o"></i>
					gusalsdl5119@naver.com</a></li>
			<li><a href="#"><i class="fa fa-map-marker"></i> 부천우리컴퓨터전산회계학원</a></li>
		</ul>
		<div style="float:right;">
			<ul class="header-links pull-right">
				<sec:authorize access="hasRole('ROLE_BUSINESS')">
					<li><a href="./business/coupon.do"><i class="fa fa-building"></i>사업자페이지</a></li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li><a href="./admin/index.do"><i class="fa fa-lock"></i>관리자페이지</a></li>
				</sec:authorize>
				<li><a href="./notice.do"><i class="fa fa-users"></i> 커뮤니티</a></li>
				<sec:authorize access="authenticated">
						<li><a href="./logout.do"><i class="fa fa-user-o"></i> 로그아웃</a></li>
						<li><a href="./mypage"><i class="fa fa-user-o"></i> 마이페이지</a></li>
				</sec:authorize>
				<sec:authorize access="not authenticated">
					<li><a href="./login.do"><i class="fa fa-user-o"></i> 로그인</a></li>
				</sec:authorize>
		</ul>
		</div>
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
					<a href="./" class="logo"> <img src="./img/wondumallLogo.png" alt="">
					</a>
				</div>
			</div>
			<!-- /LOGO -->

			<!-- SEARCH BAR -->
			<div class="col-md-6">
				<div class="header-search">
					<form action="./search.do" method="get">
						<input class="input" placeholder="검색어를 입력하세요." name="search">
						<button class="search-btn">검색</button>
					</form>
				</div>
			</div>
			<!-- /SEARCH BAR -->

			<!-- ACCOUNT -->
			<div class="col-md-3 clearfix">
				<div class="header-ctn">
					<div class="dropdown">
						<c:choose>
							<c:when test="${user ne 'anonymousUser'}">
								<a href="./cart.do"> <i class="fa fa-shopping-cart"></i> 
								<span>장바구니</span>
									<span class="qty">${qty}</span>
								</a>
							</c:when>
							<c:otherwise>
								<a href="./login.do"> <i class="fa fa-shopping-cart"></i> 
								<span>장바구니</span>
									<span class="qty">0</span>
								</a>
							</c:otherwise>
						</c:choose>
						<!-- Cart -->
						</div>
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