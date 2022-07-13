<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!-- TOP HEADER -->

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
				<li><a href="./index.do">관리자페이지</a></li>
			</sec:authorize>
			<li><a href="//notice.do"><i class="fa fa-users"></i> 커뮤니티</a></li>
			<li><a href="#"><i class="fa fa-dollar"></i> WON</a></li>
			<sec:authorize access="authenticated">
				<div style="float:right;">
					<li><a href="//logout.do"><i class="fa fa-user-o"></i> 로그아웃</a></li>
				</div>
			</sec:authorize>
			<sec:authorize access="not authenticated">
				<div style="float:right;">
					<li><a href="//login.do"><i class="fa fa-user-o"></i> 로그인</a></li>
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