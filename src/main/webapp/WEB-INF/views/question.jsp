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
	th:nth-child(1), th:nth-child(3){
		width: 10%;
	}
	th:nth-child(2){
		width: 60%;
	}
	th:nth-child(4){
		width: 20%;
	}
	td:nth-child(2){
		text-align: left;
	}
</style>
<script type="text/javascript">
	function linkPage(pageNo) {
		if(${not empty searchColumn} && ${not empty searchValue}){
			location.href = "./question.do?pageNo=" + pageNo + "&searchColumn=${searchColumn}&searchValue=${searchValue}";
		} else{
			location.href = "./question.do?pageNo=" + pageNo;
		}
	}
	
	function questionDetail(q_no) {
		if(${not empty searchColumn} && ${not empty searchValue}){
			location.href = "./questionDetail.do?q_no=" + q_no + "&pageNo=" + ${pageNo} + "&searchColumn=${searchColumn}&searchValue=${searchValue}";
		} else{
			location.href = "./questionDetail.do?q_no=" + q_no + "&pageNo=" + ${pageNo};
		}
	}
	
	function sendFile(file, el) {
		var form_data = new FormData();
		form_data.append('file', file);
		$.ajax({
			data : form_data,
			type : "POST",
			url : './questionImage.do',
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
		<c:import url="./header.jsp"></c:import>
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<nav id="navigation">
		<div class="container">
			<!-- responsive-nav -->
			<div id="responsive-nav">
				<!-- NAV -->
				<ul class="main-nav nav navbar-nav" id="nav">
					<li><a href="./notice.do">공지사항</a></li>
					<li><a href="./board.do">자유게시판</a></li>
					<li><a href="./question.do">질문게시판</a></li>
					<li><a href="#">자주묻는질문</a></li>
					<li><a href="#">실시간문의</a></li>
				</ul>
				<!-- /NAV -->
			</div>
			<!-- /responsive-nav -->
		</div>
	</nav>
	<!-- /NAVIGATION -->
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
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="q" items="${questionList}">
						<tr>
							<td>${q.q_no }</td>
							<sec:authorize access="not authenticated">
								<td >${q.q_title } <small style="color:red;">${q.q_commentCount }</small></td>
							</sec:authorize>
							<sec:authorize access="authenticated">
								<sec:authorize access="!hasRole('ROLE_ADMIN') && !(principal.nickname == '${q.u_nickname }')">
									<td>${q.q_title } <small style="color:red;">${q.q_commentCount }</small></td>
								</sec:authorize>
							</sec:authorize>
							<sec:authorize access="authenticated">
								<sec:authorize access="hasRole('ROLE_ADMIN') || principal.nickname == '${q.u_nickname }'">
									<td onclick="questionDetail(${q.q_no})">${q.q_title } <small style="color:red;">${q.q_commentCount }</small></td>
								</sec:authorize>
							</sec:authorize>
							<td>${q.u_nickname }</td>
							<fmt:parseDate value="${q.q_date}" var="time"
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
				<form action="./question.do?pageNo=${pageNo }">
					<select name="searchColumn">
						<option value="q_title" ${searchColumn eq 'q_title'?'selected':'' }>제목</option>
						<option value="q_content" ${searchColumn eq 'q_content'?'selected':''}>내용</option>
						<option value="u_nickname" ${searchColumn eq 'u_nickname'?'selected':''}>작성자</option>
					</select>
					<input type="text" name="searchValue" value="${searchValue}">
					<button type="submit"><i class="fa fa-search" aria-hidden="true"></i>검색</button>
				</form>
			</div>
			
			<sec:authorize access="authenticated">
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

	<!-- FOOTER -->
	<footer id="footer">
		<c:import url="./footer.jsp"></c:import>
	</footer>
	<!-- /FOOTER -->

<!-- 로그인한 유저는 글쓰기 가능 -->
<sec:authorize access="authenticated">
	<dialog id="questionWriteDialog">
		<div>
			<form action="./questionWrite.do" method="post">
				<div style="padding-bottom: 10px;">
					<h2><label>제목</label></h2>
					<input style="width: 100%;" type="text" name="q_title" required>
				</div>
				<div style="padding-bottom: 10px;">
					<h4><label>내용</label></h4>
					<textarea id="summernote" name="q_content" required></textarea>
				</div>
				<input type="hidden" name="pageNo" value="${pageNo }">
				<input type="hidden" name="u_nickname" value="<sec:authentication property="principal.nickname" />">
				<div>
					<button type="submit">글쓰기</button>
					<button type="button" onclick="hideWriteDialog()">닫기</button>
				</div>
			</form>
		</div>
	</dialog>
	
<script>
var questionWriteDialog = document.getElementById('questionWriteDialog');

function showWriteDialog(){
	questionWriteDialog.showModal();
}
function hideWriteDialog(){
	questionWriteDialog.close();
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
