<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title></title>

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

<!-- jQuery Plugins -->
<script src="./js/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/slick.min.js"></script>
<script src="./js/nouislider.min.js"></script>
<script src="./js/jquery.zoom.min.js"></script>
<script src="./js/main.js"></script>


<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<style>
	th, td{
		text-align: center;
	}
	td:nth-child(2){
		text-align: left;
	}
	th:nth-child(1), th:nth-child(3), th:nth-child(4), th:nth-child(5){
		width: 10%;
	}
	th:nth-child(2){
		width: 40%;
	}
	th:nth-child(6){
		width: 20%;
	}
	td:nth-child(2){
		text-align: left;
	}
</style>
<script type="text/javascript">
	function linkPage(pageNo) {
		if(${not empty searchColumn} && ${not empty searchValue}){
			location.href = "./notice.do?pageNo=" + pageNo + "&searchColumn=${searchColumn}&searchValue=${searchValue}";
		} else{
			location.href = "./notice.do?pageNo=" + pageNo;
		}
	}
	
	function noticeDetail(n_no) {
		if(${not empty searchColumn} && ${not empty searchValue}){
			location.href = "./noticeDetail.do?n_no=" + n_no + "&pageNo=" + ${pageNo} + "&searchColumn=${searchColumn}&searchValue=${searchValue}";
		} else{
			location.href = "./noticeDetail.do?n_no=" + n_no + "&pageNo=" + ${pageNo};
		}
	}
	
	function sendFile(file, el) {
		var form_data = new FormData();
		form_data.append('file', file);
		$.ajax({
			data : form_data,
			type : "POST",
			url : './noticeImage.do',
			cache : false,
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(url) {
				$(el).summernote('insertImage', url, function($image) {
					$image.css('width', "25%");
				});
			}
		});
	}
</script>
</head>
<body>
	<!-- HEADER -->
	<header>
		<c:import url="/header.do"></c:import>
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
		<c:import url="./communityNav.jsp"></c:import>
	<!-- /NAVIGATION -->
	
	<section>
		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">글쓴이</th>
							<th scope="col">조회수</th>
							<th scope="col">좋아요</th>
							<th scope="col">작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="n" items="${noticeList}">
							<tr>
								<td>${n.n_no }</td>
								<td onclick="noticeDetail(${n.n_no})">${n.n_title } <small style="color:red;">${n.n_commentCount }</small></td>
								<td>${n.u_nickname }</td>
								<td>${n.n_count }</td>
								<td>${n.n_like }</td>
								<fmt:parseDate value="${n.n_date}" var="time"
									pattern="yyyy-MM-dd HH:mm:ss.S" />
								<fmt:formatDate value="${time}" var="time"
									pattern="yyyy-MM-dd HH:mm:ss" />
								<td>${time }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div style="text-align: center; margin-bottom: 10px;">
					<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage" />
				</div>
				<div style="text-align: center;">
					<form action="./notice.do?pageNo=${pageNo }">
						<select name="searchColumn">
							<option value="n_title" ${searchColumn eq 'n_title'?'selected':'' }>제목</option>
							<option value="n_content" ${searchColumn eq 'n_content'?'selected':''}>내용</option>
							<option value="u_nickname" ${searchColumn eq 'u_nickname'?'selected':''}>작성자</option>
						</select>
						<input type="text" name="searchValue" value="${searchValue}">
						<button type="submit"><i class="fa fa-search" aria-hidden="true"></i>검색</button>
					</form>
				</div>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<div style="float:right;">
						<button type="button" onclick="showWriteDialog()"><i class="fa fa-pencil" aria-hidden="true"></i>글쓰기</button>
					</div>
				</sec:authorize>
				<sec:authorize access="not authenticated">
					<div style="float:right;">
						<button type="button" onclick="location.href='./login.do'"><i class="fa fa-user" aria-hidden="true"></i>로그인</button>
					</div>
				</sec:authorize>
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->
	</section>
	
	<!-- FOOTER -->
	<footer id="footer">
		<c:import url="./footer.jsp"></c:import>
	</footer>
	<!-- /FOOTER -->

<!-- 관리자만 공지사항 작성 가능 -->
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<dialog id="noticeWriteDialog">
		<div>
			<form action="./noticeWrite.do" method="post">
				<div style="padding-bottom: 10px;">
					<h2><label>제목</label></h2>
					<input style="width: 100%;" type="text" name="n_title" required>
				</div>
				<div style="padding-bottom: 10px;">
					<h4><label>내용</label></h4>
					<textarea id="summernote" name="n_content" required></textarea>
				</div>
				<input type="hidden" name="pageNo" value="${pageNo }">
				<div>
					<button type="submit">글쓰기</button>
					<button type="button" onclick="hideWriteDialog()">닫기</button>
				</div>
			</form>
		</div>
	</dialog>
	
<script>
var noticeWriteDialog = document.getElementById('noticeWriteDialog');

function showWriteDialog(){
	noticeWriteDialog.showModal();
}
function hideWriteDialog(){
	noticeWriteDialog.close();
}

$(document).ready(function() {
	  $('#summernote').summernote({
		  height: 400,
		  callbacks : {
				onImageUpload : function(files, editor, welEditable) {       
					for (var i = 0; i < files.length; i++) {
						sendFile(files[i], this);
					}
				}
			}
	  });
});
</script>
</sec:authorize>

</body>
</html>
