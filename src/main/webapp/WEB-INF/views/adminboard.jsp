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
	<div id="section">
		<div id="container">
			<table class="table">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">글제목</th>
						<th scope="col">이름</th>
						<th scope="col">쓴날짜</th>
						<th scope="col">삭제여부</th>
						<th scope="col">삭제</th>
						<th scope="col">완전삭제</th>
						<th scope="col">상세보기</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${boardList }" var="b">
						<tr>
							<th scope='row'>${b.b_no }</th>
							<td>${b.b_title }</td>
							<td>${b.u_nickname }</td>
							<td>${b.b_date }</td>
							<td>
							<c:choose>
								<c:when test="${b.b_del eq 1}">
									삭제됨
								</c:when>
								<c:otherwise>
									삭제안됨
								</c:otherwise>
							</c:choose>
							</td>
							<td>
							<button onclick="bdel(${b.b_no})">삭제</button>
							<button onclick="rpr(${b.b_no})">복구</button>
							</td>
							<td><button onclick="compledel(${b.b_no})">완전삭제</button></td>
							<td><button onclick="detail(${b.b_no}, ${pageNo })">상세보기</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div id="pagination" style="text-align: center;">
				<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage" />
			</div>
			<form action="//admin/board.do?pageNo=${pageNo }" style="display: block; margin: 0 auto; text-align: center;">
				<select name="searchColumn">
					<option value="b_title" ${searchColumn eq 'b_title'?'selected':'' }>글제목</option>
					<option value="u_nickname" ${searchColumn eq 'u_nickname'?'selected':''}>작성자</option>
				</select>
				<input type="text" name="searchValue" value="${searchValue}">
				<button type="submit"><i class="fa fa-search" aria-hidden="true"></i>검색</button>
			</form>
		</div>
	</div>
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
function linkPage(pageNo) {
	location.href = "//admin/board.do?pageNo=" + pageNo;
}
function bdel(b_no){
	if (confirm("삭제하시겠습니까?")){
		location.href = "//admin/bdel/" + b_no;
	} else {
		
	}
}
function rpr(b_no){
	if (confirm("복구하시겠습니까?")){
		location.href = "//admin/rpr/" + b_no;
	} else {
		
	}
}
function compledel(b_no){
	if (confirm("삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?")){
		location.href = "//admin/compledel/" + b_no;
	} else {
		
	}	
}
function detail(b_no, pageNo){
	location.href = "//boardDetail.do?b_no=" + b_no + "&pageNo=" + pageNo;
}
</script>
</body>
</html>