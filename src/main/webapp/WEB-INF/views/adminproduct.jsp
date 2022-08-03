<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>wondumall</title>
 		<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

 		<!-- Bootstrap -->
 		<link type="text/css" rel="stylesheet" href="/wondumall/css/bootstrap.min.css"/>

 		<!-- Slick -->
 		<link type="text/css" rel="stylesheet" href="/wondumall/css/slick.css"/>
 		<link type="text/css" rel="stylesheet" href="/wondumall/css/slick-theme.css"/>

 		<!-- nouislider -->
 		<link type="text/css" rel="stylesheet" href="/wondumall/css/nouislider.min.css"/>

 		<!-- Font Awesome Icon -->
 		<link rel="stylesheet" href="/wondumall/css/font-awesome.min.css">

 		<!-- Custom stlylesheet -->
 		<link type="text/css" rel="stylesheet" href="/wondumall/css/style.css"/>
<style type="text/css">
td, th{
	margin: 0 auto;
	text-align: center;
}
</style>
</head>
<body>
	<header>
		<c:import url="./adminheader.jsp"></c:import>
	</header>
	<nav id="navigation">
		<c:import url="./adminnav.jsp"></c:import>
	</nav>
	<section>
		<div id="section">
			<div id="container">
				<h1 style="margin-top: 20px; margin-bottom: 20px; margin-left: 100px;">제품관리</h1>
				<table class="table" style="width:90%; margin: 0 auto; margin-top: 20px; margin-bottom: 20px;">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">제품이름</th>
							<th scope="col">작성자</th>
							<th scope="col">제품가격</th>
							<th scope="col">등록날짜</th>
							<th scope="col">승인여부</th>
							<th scope="col">삭제여부</th>
							<th scope="col">삭제</th>
							<th scope="col">완전삭제</th>
							<th scope="col">승인</th>
							<th scope="col">상세보기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${productList }" var="p">
							<tr>
								<th scope='row'>${p.p_no }</th>
								<td>${p.p_name }</td>
								<td>${p.u_name }</td>
								<td>${p.p_price }</td>
								<td>${p.p_date }</td>
								<td>
								<c:choose>
									<c:when test="${p.p_confirm eq 1}">
										승인
									</c:when>
									<c:otherwise>
										미승인
									</c:otherwise>
								</c:choose>
								</td>
								<td>
								<c:choose>
									<c:when test="${p.p_del eq 1}">
										O
									</c:when>
									<c:otherwise>
										X
									</c:otherwise>
								</c:choose>
								</td>
								<td>
								<c:choose>
									<c:when test="${p.p_del eq 1 }">
										<button onclick="repair(${p.p_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #A9F5BC;">복구하기</button>
									</c:when>
									<c:otherwise>
										<button onclick="del(${p.p_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #F5A9A9;">삭제하기</button>
									</c:otherwise>
								</c:choose>
								</td>
								<td><button onclick="pdelete(${p.p_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #F5A9A9;">완전삭제</button></td>
								<td>
								<c:choose>
									<c:when test="${p.p_confirm eq 1 }">
										<button onclick="adcancel(${p.p_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #F5A9A9;">승인취소</button>
									</c:when>
									<c:otherwise>
										<button onclick="admission(${p.p_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #A9F5BC;">승인하기</button>
									</c:otherwise>
								</c:choose>
								</td>
								<td><button onclick="detail(${p.p_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #F5D0A9;">상세보기</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div id="pagination" style="text-align: center; margin-bottom: 20px;">
					<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage" />
				</div>
				<form action="/wondumall/admin/product.do?pageNo=${pageNo }" style="display: block; margin: 0 auto; text-align: center; margin-bottom: 20px;">
					<select name="searchColumn">
						<option value="p_name" ${searchColumn eq 'p_name'?'selected':'' }>제품이름</option>
						<option value="u_name" ${searchColumn eq 'u_name'?'selected':''}>작성자</option>
					</select>
					<input type="text" name="searchValue" value="${searchValue}">
					<button type="submit" class="primary-btn order-submit"><i class="fa fa-search" aria-hidden="true"></i>검색</button>
				</form>
			</div>
		</div>
	</section>
	
	<footer id="footer">
		<c:import url="/footer.do"></c:import>
	</footer>
		<!-- jQuery Plugins -->
	<script src="/wondumall/js/jquery.min.js"></script>  
	<script src="/wondumall/js/bootstrap.min.js"></script>
	<script src="/wondumall/js/slick.min.js"></script>
	<script src="/wondumall/js/nouislider.min.js"></script>
	<script src="/wondumall/js/jquery.zoom.min.js"></script>
	<script src="/wondumall/js/main.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
function del(p_no){
	if (confirm("삭제하시겠습니까?")){
		location.href = "/wondumall/admin/del/" + p_no;
	} else {
		
	}
}
function repair(p_no){
	if (confirm("복구하시겠습니까?")){
		location.href = "/wondumall/admin/repair/" + p_no;
	} else {
		
	}
}
function pdelete(p_no){
	if (confirm("삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?")){
		location.href = "/wondumall/admin/pdelete/" + p_no;
	} else {
		
	}	
}
function admission(p_no){
	if (confirm("승인하시겠습니까?")){
		location.href = "/wondumall/admin/admission/" + p_no;
	} else {
		
	}
}
function adcancel(p_no){
	if (confirm("승인을 취소하시겠습니까?")){
		location.href = "/wondumall/admin/adcancel/" + p_no;
	} else {
		
	}
}
function linkPage(pageNo) {
	location.href = "/wondumall/admin/product.do?pageNo=" + pageNo;
}
function detail(p_no){
	location.href= "/wondumall/productDetail.do?p_no=" + p_no;
}
</script>
</body>
</html>