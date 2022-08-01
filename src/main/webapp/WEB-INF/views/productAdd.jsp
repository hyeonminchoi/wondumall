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
<style type="text/css">
#flex{
	display: flex;
}
textarea {
	resize: none;
}
</style>
</head>
<body>
	<header>
		<c:import url="/header.do"></c:import>
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<nav id="navigation">
		<c:import url="/nav.do"></c:import>
	</nav>
	<section>
		<div id="section">
			<div id="container">
				<form action="./productAdd.do" method="POST" id="join" class="joinForm" enctype="multipart/form-data">
					<h2>상품등록신청</h2>
					<hr>
					<div class="form-group row">
						<label class="col-sm-3">상품 이름</label>
						<div class="com-sm-3">
							<input type="text" id="p_name" name="p_name" class="form-control" required>
						</div>
					</div>
	
					<div class="form-group row">
						<label class="col-sm-3">분류 번호</label>
						<div class="com-sm-3" id="flex">
							<c:forEach var="c" items="${categoryList }" begin="1" varStatus="">
								<input style="margin-left: 10px;" type="radio" id="cate_no" name="cate_no" value="${c.cate_no }" required>${c.category }					
							</c:forEach>
						</div>
					</div>
	
					<div class="form-group row">
						<label class="col-sm-3">상품 설명</label>
						<div class="com-sm-5">
							<textarea name="p_description" id="p_description" cols="50" rows="2" class="form-control" placeholder="500자 이내로 입력해주세요." maxlength="500" required></textarea>
						</div>
					</div>
	
					<div class="form-group row">
						<label class="col-sm-3">상품 가격</label>
						<div class="com-sm-3">
							<input type="number" id="p_price" name="p_price" class="form-control" required>
						</div>
					</div>
	
					<div class="form-group row">
						<label class="col-sm-3">상품 수량</label>
						<div class="com-sm-3">
							<input type="number" id="p_stock" name="p_stock" class="form-control" min="1" required>
						</div>
					</div>
	
					<div class="form-group row">
						<label class="col-sm-3">상품 이미지</label>
						<div id="image_preview">
							<img src="./img/productImg.png" alt="사진영역" style="width: 100px; height: 100px; margin-right: 220px;">
						</div>
						<div class="f_box">
							<input id="input-file" 
								type="file" name="files" class="form-control" 
								accept=".png, .jpg, .gif, .jpeg, .ico" multiple="multiple" required
							>
							<!-- <input type="file" id="img" name="bf_file[]"> -->
						</div>
						<script>
							// 이미지 업로드
							$('#input-file').on('change',function() {
									ext = $(this).val().split('.').pop().toLowerCase(); //확장자
									//배열에 추출한 확장자가 존재하는지 체크
									if ($.inArray(ext, [ 'gif', 'png', 'jpg', 'jpeg' ]) == -1) {
										resetFormElement($(this)); //폼 초기화
										window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
									} else {
										file = $('#input-file').prop("files")[0];
										blobURL = window.URL.createObjectURL(file);
										$('#image_preview img').attr('src',blobURL);
										$('#image_preview').slideDown(); //업로드한 이미지 미리보기 
									}
								});
						</script>
					</div>
					<input type="submit" id="addBtn" name="addBtn" class="btn" value="등록하기" onclick="productAdd()"/>
				</form>
			</div>
		</div>
	</section>
	<!-- FOOTER -->
	<footer id="footer">
		<c:import url="/footer.do"></c:import>
	</footer>
	<!-- /FOOTER -->

	<!-- jQuery Plugins -->
	<script src="./js/jquery.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/slick.min.js"></script>
	<script src="./js/nouislider.min.js"></script>
	<script src="./js/jquery.zoom.min.js"></script>
	<script src="./js/main.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		$("#addBtn").click(function() {   
			if($('#p_name').val().trim() == ''){
				alert('이름은 필수 입력입니다.');
				$('#p_name').val('');
				$('#p_name').focus();
				return false;
			}
			if($('#p_description').val().trim() == ''){
				alert('상품 설명은 필수 입력입니다.');
				$('#p_description').val('');
				$('#p_description').focus();
				return false;
			}
		})
	});

	/* function productAdd(){
		alert("상품등록이 신청 되었습니다.\n관리자 승인 후 상품이 등록됩니다.");
	} */
</script>
</body>
</html>