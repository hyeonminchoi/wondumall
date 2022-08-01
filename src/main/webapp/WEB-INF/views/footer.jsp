<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- top footer -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-3 col-xs-6">
				<div class="footer">
					<h3 class="footer-title">개발자</h3>
					<ul class="footer-links">
						<li><a href="https://github.com/hwangjeho"><i class="fa fa-github"></i>황제호</a></li>
						<li><a href="https://github.com/cheuljin"><i class="fa fa-github"></i>황철진</a></li>
						<li><a href="https://github.com/hyeonminchoi"><i class="fa fa-github"></i>최현민</a></li>
						<li><a href="https://github.com/newbieccc"><i class="fa fa-github"></i>서승준</a></li>
					</ul>
				</div>
			</div>

			<div class="col-md-3 col-xs-6">
				<div class="footer">
					<h3 class="footer-title">카테고리</h3>
					<ul class="footer-links" id="category">
						<c:forEach var="c" items="${categoryList }">
							<li><a href="./category.do?cate_no=${c.cate_no }">${c.category }</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>

			<div class="clearfix visible-xs"></div>

			<div class="col-md-3 col-xs-6">
				<div class="footer">
					<h3 class="footer-title">커뮤니티</h3>
					<ul class="footer-links">
						<li><a href="./board.do">자유게시판</a></li>
						<li><a href="./notice.do">공지사항</a></li>
						<li><a href="./question.do">질문게시판</a></li>
					</ul>
				</div>
			</div>

			<div class="col-md-3 col-xs-6">
				<div class="footer">
					<h3 class="footer-title">서비스</h3>
					<ul class="footer-links">
						<li><a href="./mypage">마이페이지</a></li>
						<li><a href="./cart.do">장바구니</a></li>
						<li><a href="./faq.do">FAQ</a></li>
						<li><a href="./chatting.do">실시간문의</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /top footer -->

<!-- bottom footer -->
<div id="bottom-footer" class="section">
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12 text-center">
				<ul class="footer-payments">
					<li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
					<li><a href="#"><i class="fa fa-credit-card"></i></a></li>
					<li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
					<li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
					<li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
					<li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
				</ul>
				<span class="copyright"> <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					Copyright &copy;<script>document.write(new Date().getFullYear());</script>
					All rights reserved | This template is made with <i
					class="fa fa-heart-o" aria-hidden="true"></i> by <a
					href="https://colorlib.com" target="_blank">Colorlib</a> <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
				</span>
			</div>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /bottom footer -->