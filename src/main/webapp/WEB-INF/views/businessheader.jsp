<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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
					<li><a href="./index.do"><i class="fa fa-lock"></i>사업자페이지</a></li>
				</sec:authorize>
				<li><a href="/wondumall/notice.do"><i class="fa fa-users"></i> 커뮤니티</a></li>
				<li><a href="#"><i class="fa fa-krw"></i> WON</a></li>
				<sec:authorize access="authenticated">
						<li><a href="/wondumall/logout.do"><i class="fa fa-user-o"></i> 로그아웃</a></li>
						<li><a href="/wondumall/mypage"><i class="fa fa-user-o"></i> 마이페이지</a></li>
				</sec:authorize>
				<sec:authorize access="not authenticated">
						<li><a href="/wondumall/login.do"><i class="fa fa-user-o"></i> 로그인</a></li>
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
					<a href="/wondumall/" class="logo"> <img src="/wondumall/img/wondumallLogo.png" alt="">
					</a>
				</div>
			</div>
			<!-- /LOGO -->

			<!-- ACCOUNT -->
			<div class="col-md-3 clearfix">
				<div class="header-ctn">
					

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