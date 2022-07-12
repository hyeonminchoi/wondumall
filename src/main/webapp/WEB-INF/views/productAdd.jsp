<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>상품등록</title>

<!-- Google font -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700"
	rel="stylesheet">

<!-- Bootstrap -->
<link type="text/css" rel="stylesheet" href="./css/bootstrap.min.css" />

<!-- Slick -->
<link type="text/css" rel="stylesheet" href="./css/slick.css" />
<link type="text/css" rel="stylesheet" href="./css/slick-theme.css" />

<!-- nouislider -->
<link type="text/css" rel="stylesheet" href="./css/nouislider.min.css" />

<!-- Font Awesome Icon -->
<link rel="stylesheet" href="./css/font-awesome.min.css">

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet" href="./css/style.css" />

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

<link type="text/css" rel="stylesheet" href="./css/join.css" />


</head>
<body>
	<header>
		<c:import url="./header.jsp"></c:import>
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<nav id="navigation">
		<c:import url="./nav.jsp"></c:import>
	</nav>

	<div id="section">
		<div id="container">
			<form action="./productAdd.do" method="POST" id="join" class="joinForm" enctype="multipart/form-data">

				<h2>상품등록</h2>
				
				<!-- <div class="textForm">
					<input name="p_name" id="email" type="text" class="email" placeholder="상품명" >
				</div>
				<div class="textForm">
					<input name="cate_no" id="email" type="text" class="email" placeholder="카테고리 번호">
				</div>
				<div class="textForm">
					<textarea name="p_description" id="email" class="email" rows="50" cols="10"  placeholder="상품설명"></textarea>
					<input name="p_description" id="email" type="" class="email" placeholder="상품설명" >
				</div>
				<div class="textForm">
					<input name="p_price" id="email" type="number" class="email" placeholder="상품가격">
				</div>
				<div class="textForm">
					<input name="p_stock" id="email" type="number" class="email" placeholder="수량" >
				</div> -->
				<!-- <div class="textForm">
					<input name="p_img" id="email" type="text" class="email" placeholder="상품사진">
				</div> -->
				<hr>

				<div class="form-group row">
					<label class="col-sm-3">상품 이름</label>
					<div class="com-sm-3">
						<input type="text" id="p_name" name="p_name" class="form-control">
					</div>
				</div>

				<div class="form-group row">
					<label class="col-sm-3">분류 번호</label>
					<div class="com-sm-3">
						<input type="number" id="cate_no" name="cate_no" class="form-control">
					</div>
				</div>

				<div class="form-group row">
					<label class="col-sm-3">상품 설명</label>
					<div class="com-sm-5">
						<textarea name="p_description" cols="50" rows="2" class="form-control"></textarea>
					</div>
				</div>

				<div class="form-group row">
					<label class="col-sm-3">상품 가격</label>
					<div class="com-sm-3">
						<input type="text" id="unitPrice" name="p_price" class="form-control">
					</div>
				</div>

				<div class="form-group row">
					<label class="col-sm-3">상품 수량</label>
					<div class="com-sm-3">
						<input type="number" id="p_stock" name="p_stock" class="form-control">
					</div>
				</div>

				<div class="form-group row">
					<label class="col-sm-3">상품 이미지</label>
					<div>
					<!-- <button type="button" class="btn_upload">
						<img src="">
					</button> -->
						<input 
							type="file" name="files" class="form-control" 
							accept=".png, .jpg, .gif, .jpeg, .ico" multiple="multiple"
						>
					</div>
				</div>

				<input type="submit"  id="addBtn" class="btn" value="등록하기" />
			</form>
		</div>
	</div>

<script type="text/javascript">
</script>










	
	<!-- FOOTER -->
	<footer id="footer">
		<c:import url="./footer.jsp"></c:import>
	</footer>
	<!-- /FOOTER -->

	<!-- jQuery Plugins -->
	<script src="./js/jquery.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/slick.min.js"></script>
	<script src="./js/nouislider.min.js"></script>
	<script src="./js/jquery.zoom.min.js"></script>
	<script src="./js/main.js"></script>

</body>
</html>