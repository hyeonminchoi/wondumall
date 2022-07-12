<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
 		<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

 		<!-- Bootstrap -->
 		<link type="text/css" rel="stylesheet" href="./css/bootstrap.min.css"/>

 		<!-- Slick -->
 		<link type="text/css" rel="stylesheet" href="./css/slick.css"/>
 		<link type="text/css" rel="stylesheet" href="./css/slick-theme.css"/>

 		<!-- nouislider -->
 		<link type="text/css" rel="stylesheet" href="./css/nouislider.min.css"/>

 		<!-- Font Awesome Icon -->
 		<link rel="stylesheet" href="./css/font-awesome.min.css">

 		<!-- Custom stlylesheet -->
 		<link type="text/css" rel="stylesheet" href="./css/style.css"/>
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
						<th scope="col">제품이름</th>
						<th scope="col">제품가격</th>
						<th scope="col">등록날짜</th>
						<th scope="col">승인여부</th>
						<th scope="col">삭제여부</th>
						<th scope="col">삭제</th>
						<th scope="col">완전삭제</th>
						<th scope="col">승인</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${productList }" var="p">
						<tr>
							<th scope='row'>${p.p_no }</th>
							<td>${p.p_name }</td>
							<td>${p.p_price }</td>
							<td>${p.p_date }</td>
							<td>${p.p_confirm }</td>
							<td>${p.p_del }</td>
							<td><button onclick="del(${p.p_no})">삭제</button></td>
							<td><button onclick="pdelete(${p.p_no})">완전삭제</button></td>
							<td><button onclick="admission(${p.p_no})">승인</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<footer>
		<c:import url="./footer.jsp"></c:import>
	</footer>
		<!-- jQuery Plugins -->
	<script src="./js/jquery.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/slick.min.js"></script>
	<script src="./js/nouislider.min.js"></script>
	<script src="./js/jquery.zoom.min.js"></script>
	<script src="./js/main.js"></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
function del(p_no){
	if (confirm("삭제하시겠습니까?")){
		location.href = "./del/" + p_no;
	} else {
		
	}
}
function pdelete(p_no){
	if (confirm("삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?")){
		location.href = "./pdelete/" + p_no;
	} else {
		
	}	
}
function admission(p_no){
	if (confirm("승인하시겠습니까?")){
		location.href = "./admission/" + p_no;
	} else {
		
	}
}
</script>
</body>
</html>