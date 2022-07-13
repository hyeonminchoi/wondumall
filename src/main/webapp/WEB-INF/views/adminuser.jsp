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
						<th scope="col">이름</th>
						<th scope="col">닉네임</th>
						<th scope="col">가입날짜</th>
						<th scope="col">등급</th>
						<th scope="col">승인여부</th>
						<th scope="col">탈퇴여부</th>
						<th scope="col">탈퇴</th>
						<th scope="col">완전탈퇴</th>
						<th scope="col">승인</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userList }" var="u">
						<tr>
							<th scope='row'>${u.u_no }</th>
							<td>${u.u_name }</td>
							<td>${u.u_nickname }</td>
							<td>${u.u_joindate }</td>
							<td>${u.u_grade }</td>
							<td>${u.u_confirm }</td>
							<td>${u.u_resign }</td>
							<td>
							<button onclick="del(${u.u_no})">탈퇴</button>
							<button onclick="repair(${u.u_no})">복구</button>
							</td>
							<td><button onclick="pdelete(${u.u_no})">완전탈퇴</button></td>
							<td>
							<button onclick="admission(${u.u_no})">승인</button>
							<button onclick="adcancel(${u.u_no})">취소</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div id="pagination" style="text-align: center;">
				<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage" />
			</div>
			<form action="//admin/user.do?pageNo=${pageNo }" style="display: block; margin: 0 auto; text-align: center;">
				<select name="searchColumn">
					<option value="u_name" ${searchColumn eq 'u_name'?'selected':'' }>이름</option>
					<option value="u_nickname" ${searchColumn eq 'u_nickname'?'selected':''}>별명</option>
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
	location.href = "//admin/user.do?pageNo=" + pageNo;
}
</script>
</body>
</html>