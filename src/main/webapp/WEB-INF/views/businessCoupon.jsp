<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
 		<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

 		<!-- Bootstrap -->
 		<link type="text/css" rel="stylesheet" href="//css/bootstrap.min.css"/>

 		<!-- Slick -->
 		<link type="text/css" rel="stylesheet" href="//css/slick.css"/>
 		<link type="text/css" rel="stylesheet" href="//css/slick-theme.css"/>

 		<!-- nouislider -->
 		<link type="text/css" rel="stylesheet" href="//css/nouislider.min.css"/>

 		<!-- Font Awesome Icon -->
 		<link rel="stylesheet" href="//css/font-awesome.min.css">

 		<!-- Custom stlylesheet -->
 		<link type="text/css" rel="stylesheet" href="//css/style.css"/>
</head>
<body>
	<header>
		<c:import url="./businessheader.jsp"></c:import>
	</header>
	<nav id="navigation">
		<c:import url="./businessnav.jsp"></c:import>
	</nav>
	<section>
		<div id="section">
			<div id="container">
				<h1 style="margin-top: 20px; margin-bottom: 20px; margin-left: 100px;">쿠폰관리</h1>
				<table class="table" style="width:90%; margin: 0 auto; margin-top: 20px; margin-bottom: 20px;">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">쿠폰설명</th>
							<th scope="col">최소주문금액</th>
							<th scope="col">할인비율</th>
							<th scope="col">삭제여부</th>
							<th scope="col">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${couponList }" var="c">
							<th scope="row">${c.coupon_no }</th>
							<td>${c.coupon_description }</td>
							<td>${c.coupon_minorder }</td>
							<td>${c.coupon_per }</td>
							<td>
							<c:choose>
								<c:when test="${c.coupon_del eq 1}">
									O
								</c:when>
								<c:otherwise>
									X
								</c:otherwise>
							</c:choose>
							</td>
							<td>
							<c:choose>
								<c:when test="${c.coupon_del eq 1 }">
									<button onclick="rpr(${b.b_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #A9F5BC;">복구하기</button>
								</c:when>
								<c:otherwise>
									<button onclick="bdel(${b.b_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #F5A9A9;">삭제하기</button>
								</c:otherwise>
							</c:choose>
							</td>
							<td><button onclick="compledel(${b.b_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #F5A9A9;">완전삭제</button></td>
						</c:forEach>
					</tbody>
					<tbody>
					
					</tbody>
				</table>
				<div id="dialogBtnDiv">
					<button class="primary-btn" id="dialogBtn" onclick="showWriteDialog()" style="float: right;">쿠폰작성</button>
				</div>
				<div id="pagination" style="text-align: center; margin-bottom: 20px;">
					<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage" />
				</div>
				<form action="//business/coupon.do?pageNo=${pageNo }" style="display: block; margin: 0 auto; text-align: center; margin-bottom: 20px;">
					<select name="searchColumn">
						<option value="coupon_description" ${searchColumn eq 'coupon_description'?'selected':'' }>쿠폰설명</option>
						<option value="coupon_minorder" ${searchColumn eq 'coupon_minorder'?'selected':''}>최소주문금액</option>
					</select>
					<input type="text" name="searchValue" value="${searchValue}">
					<button type="submit" class="primary-btn order-submit"><i class="fa fa-search" aria-hidden="true"></i>검색</button>
				</form>
				<dialog id="couponWriteDialog">
				<div>
					<form action="./couponWrite.do" method="post">
						<div style="padding-bottom: 10px;">
							<h2>
								<label>쿠폰설명</label>
							</h2>
							<input style="width: 100%;" type="text" name="coupon_description" required>
						</div>
						<div style="padding-bottom: 10px;">
							<h3>
								<label>최소주문금액</label>
							</h3>
							<input style="width: 100%;" type="text" name="coupon_minorder" required>
						</div>
						<div style="padding-bottom: 10px;">
							<h4>
								<label>할인비율</label>
							</h4>
							<input style="width: 100%;" type="text" name="coupon_per" required>
						</div>
						<div>
							<button type="submit">쿠폰작성</button>
							<button type="button" onclick="hideWriteDialog()">닫기</button>
						</div>
					</form>
				</div>
				</dialog>
			</div>
		</div>
	</section>
	<footer id="footer">
		<c:import url="./footer.jsp"></c:import>
	</footer>
		<!-- jQuery Plugins -->
	<script src="//js/jquery.min.js"></script>  
	<script src="//js/bootstrap.min.js"></script>
	<script src="//js/slick.min.js"></script>
	<script src="//js/nouislider.min.js"></script>
	<script src="//js/jquery.zoom.min.js"></script>
	<script src="//js/main.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
var couponWriteDialog = document.getElementById('couponWriteDialog');

function showWriteDialog(){
	couponWriteDialog.showModal();
}
function hideWriteDialog(){
	couponWriteDialog.close();
}
function linkPage(pageNo) {
	location.href = "//business/coupon.do?pageNo=" + pageNo;
}
</script>
</body>
</html>