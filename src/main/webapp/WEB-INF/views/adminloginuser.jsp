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
	<section>
		<div id="section">
			<div id="container">
				<h1 style="margin-top: 20px; margin-bottom: 20px; margin-left: 100px;">로그인유저관리</h1>
				<table class="table" style="width:90%; margin: 0 auto; margin-top: 20px; margin-bottom: 20px;">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">이름</th>
							<th scope="col">닉네임</th>
							<th scope="col">가입날짜</th>
							<th scope="col">등급</th>
							<th scope="col">로그아웃</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userList }" var="u">
							<tr>
								<th scope='row'>${u.no }</th>
								<td>${u.name }</td>
								<td>${u.nickname }</td>
								<td>${u.joindate }</td>
								<td>
								<c:choose>
									<c:when test="${u.grade eq 2}">
										관리자	
									</c:when>
									<c:when test="${u.grade eq 1}">
										사업자
									</c:when>
									<c:when test="${u.grade eq 0}">
										일반
									</c:when>
								</c:choose>
								</td>
								<td>
									<button onclick="logout(${u.no})" class="primary-btn order-submit" style="padding: 7px 12px; background-color: #A9F5BC;">로그아웃</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	<footer id="footer">
		<c:import url="/footer.do"></c:import>
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
	location.href = "//admin/user.do?pageNo=" + pageNo;
}
function sec(u_no){
	if (confirm("삭제하시겠습니까?")){
		location.href = "//admin/sec/" + u_no;
	} else {
		
	}
}
function rep(u_no){
	if (confirm("복구하시겠습니까?")){
		location.href = "//admin/rep/" + u_no;
	} else {
		
	}
}
function comsec(u_no){
	if (confirm("삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?")){
		location.href = "//admin/comsec/" + u_no;
	} else {
		
	}	
}
function admiss(u_no){
	if (confirm("승인하시겠습니까?")){
		location.href = "//admin/admiss/" + u_no;
	} else {
		
	}
}
function adcan(u_no){
	if (confirm("승인을 취소하시겠습니까?")){
		location.href = "//admin/adcan/" + u_no;
	} else {
		
	}
}
function logout(u_no){
	if (confirm("해당 사용자 계정을 로그아웃 시키겠습니까?")){
		location.href = "//admin/logout/" + u_no;
	}
}
</script>
</body>
</html>