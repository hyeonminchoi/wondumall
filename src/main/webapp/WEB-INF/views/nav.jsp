<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!-- container -->
<div class="container">
	<!-- responsive-nav -->
	<div id="responsive-nav">
		<!-- NAV -->
		<ul class="main-nav nav navbar-nav" id="nav">
			<c:forEach var="c" items="${categoryList }">
				<li><a href="./category.do?cate_no=${c.cate_no }">${c.category }</a></li>
			</c:forEach>
		</ul>
		<ul class="main-nav nav navbar-nav" style="float: right;">
			<li>
				<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_BUSINESS')">
					<a href="./productAdd.do">제품 등록</a>
				</sec:authorize>
			</li>
		</ul>
		<!-- /NAV -->
	</div>
	<!-- /responsive-nav -->
</div>
<!-- /container -->