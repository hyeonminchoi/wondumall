<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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
	#back{
		margin-bottom: 10px;
	}
</style>
<script type="text/javascript">
	function linkPage(pageNo) {
		location.href = "./notice.do?pageNo=" + pageNo;
	}
	
	function noticeDelete(){
		if(confirm("공지사항을 삭제하겠습니까?")){
			location.href= './noticeDelete.do?pageNo=${pageNo}&n_no=${detail.n_no}';
		}
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
					<li><a href="#">질문게시판</a></li>
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
			<div id="back">
				<button type="button" onclick="location.href='./notice.do?pageNo=${pageNo}'">뒤로가기</button>
				<sec:authentication property="principal" var="user"/>
					<c:if test="${user.nickname eq detail.u_nickname }">
						<button type="button" onclick="showNoticeEditDialog()">수정</button>
					</c:if>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<button type="button" onclick="noticeDelete()">삭제</button>
				</sec:authorize>
			</div>
			<table class="table table-bordered">
				<tr>
					<th>번호</th>
					<td>${detail.n_no }</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${detail.n_title }</td>
				</tr>
				<tr>
					<th>글쓴이</th>
					<td>${detail.u_nickname }</td>
				</tr>
				<tr>
					<th>작성일</th>
					<fmt:parseDate value="${detail.n_date}" var="time" pattern="yyyy-MM-dd HH:mm:ss.S"/>
					<fmt:formatDate value="${time}" var="time"  pattern="yyyy-MM-dd HH:mm:ss"/>
					<td>${time }</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>${detail.n_count }</td>
				</tr>
				<tr>
					<th>좋아요</th>
					<td>${detail.n_like }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${detail.n_content }</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">댓글</th>
					<td>
						<sec:authorize access="authenticated">
							<div>
								<form action="./noticeComment.do" method="post">
									<input type="hidden" name="n_no" value="${detail.n_no }">
									<textarea name="nc_comment" required></textarea>
									<input type="hidden" name="pageNo" value="${pageNo }">
									<input type="hidden" name="u_nickname" value="<sec:authentication property="principal.nickname" />">
									<button type="submit">댓글쓰기</button>
								</form>
							</div>
						</sec:authorize>
						<c:choose>
							<c:when test="${fn:length(commentList) gt 0 }">
								<c:forEach var="c" items="${commentList }">
									<div>
										<fmt:parseDate value="${c.nc_date}" var="time" pattern="yyyy-MM-dd HH:mm:ss.S"/>
										<fmt:formatDate value="${time}" var="time"  pattern="yyyy-MM-dd HH:mm:ss"/>
										${c.u_nickname } / ${time }
									</div>
									<div>
										${c.nc_comment }
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								댓글이 없습니다.
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->

	<!-- FOOTER -->
	<footer id="footer">
		<c:import url="./footer.jsp"></c:import>
	</footer>
	<!-- /FOOTER -->


<sec:authorize access="hasRole('ROLE_ADMIN')">
	<dialog id="noticeEditDialog">
		<div>
			<form action="./noticeEdit.do" method="post">
				<div style="padding-bottom: 10px;">
					<h2><label>제목</label></h2>
					<input style="width: 100%;" type="text" name="n_title" value="${detail.n_title }" required>
				</div>
				<div style="padding-bottom: 10px;">
					<h4><label>내용</label></h4>
					<textarea id="summernote" name="n_content">${detail.n_content }</textarea>
				</div>
				<input type="hidden" name="pageNo" value="${pageNo }">
				<input type="hidden" name="n_no" value="${detail.n_no }">
				<input type="hidden" name="u_nickname" value="<sec:authentication property="principal.nickname" />">
				<div>
					<button type="submit">수정</button>
					<button type="button" onclick="hideNoticeEditDialog()">닫기</button>
				</div>
			</form>
		</div>
	</dialog>
	
<script>

var noticeEditDialog = document.getElementById('noticeEditDialog');

function showNoticeEditDialog(){
	noticeEditDialog.showModal();
}
function hideNoticeEditDialog(){
	noticeEditDialog.close();
}
</script>
</sec:authorize>
</body>
</html>
