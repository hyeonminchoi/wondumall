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
				<h1 style="margin-top: 20px; margin-bottom: 20px; margin-left: 100px;">질문게시판관리</h1>
				<table class="table" style="width:90%; margin: 0 auto; margin-top: 20px; margin-bottom: 20px;">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">질문제목</th>
							<th scope="col">작성자</th>
							<th scope="col">쓴날짜</th>
							<th scope="col">삭제여부</th>
							<th scope="col">삭제</th>
							<th scope="col">완전삭제</th>
							<th scope="col">상세보기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${questionList }" var="q">
							<tr>
								<th scope='row'>${q.q_no }</th>
								<td>${q.q_title }</td>
								<td>${q.u_nickname }</td>
								<td>${q.q_date }</td>
								<td>
								<c:choose>
									<c:when test="${q.q_del eq 1}">
										O
									</c:when>
									<c:otherwise>
										X
									</c:otherwise>
								</c:choose>
								</td>
								<td>
								<c:choose>
									<c:when test="${q.q_del eq 1 }">
										<button onclick="qrpr(${q.q_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #A9F5BC;">복구하기</button>
									</c:when>
									<c:otherwise>
										<button onclick="qdel(${q.q_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #F5A9A9;">삭제하기</button>
									</c:otherwise>
								</c:choose>
								</td>
								<td><button onclick="qcompledel(${q.q_no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #F5A9A9;">완전삭제</button></td>
								<td><button onclick="detail(${q.q_no}, ${pageNo })" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #F5D0A9;">상세보기</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div id="pagination" style="text-align: center; margin-bottom: 20px;">
					<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage" />
				</div>
				<form action="/wondumall/admin/question.do?pageNo=${pageNo }" style="display: block; margin: 0 auto; text-align: center; margin-bottom: 20px;">
					<select name="searchColumn">
						<option value="q_title" ${searchColumn eq 'q_title'?'selected':'' }>글제목</option>
						<option value="u_nickname" ${searchColumn eq 'u_nickname'?'selected':''}>작성자</option>
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
function linkPage(pageNo) {
	location.href = "/wondumall/admin/question.do?pageNo=" + pageNo;
}
function qdel(q_no){
	if (confirm("삭제하시겠습니까?")){
		location.href = "/wondumall/admin/qdel/" + q_no;
	} else {
		
	}
}
function qrpr(q_no){
	if (confirm("복구하시겠습니까?")){
		location.href = "/wondumall/admin/qrpr/" + q_no;
	} else {
		
	}
}
function qcompledel(q_no){
	if (confirm("삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?")){
		location.href = "/wondumall/admin/qcompledel/" + q_no;
	} else {
		
	}	
}
function detail(q_no, pageNo){
	location.href = "/wondumall/questionDetail.do?q_no=" + q_no + "&pageNo=" + pageNo;
}
</script>
</body>
</html>