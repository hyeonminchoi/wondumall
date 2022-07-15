<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<sec:authentication property="principal" var="user" />
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
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<style>
#back {
	margin-bottom: 10px;
}

#cwriteform, #ceditform {
	width: 100%;
	height: 170px;
	background-color: #c1c1c1;
	padding: 10px;
	margin-bottom: 10px;
}

#cwriteform textarea, #ceditform textarea {
	width: calc(100% - 85px);
	height: 150px;
	margin-right: -3px;
	vertical-align: middle;
	padding: 10px;
	box-sizing: border-box;
	resize: none;
}

#cwriteform button, #ceditform button {
	vertical-align: middle;
	width: 80px;
	height: 150px;
	margin-left: -2px;
	border: 0px;
	background-color: black;
	color: white;
}
#noticeComment{
	width: 100%;
}
pre{
	width: 100%;
	min-height: 50px;
	height : auto;
	box-sizing:border-box;
	white-space: pre-wrap;
	word-break:break-word;
}
td:nth-child(1){
	width:10%;
}
th{
	text-align: right;
}
td:nth-child(2){
	width:90%;
}
label{
	margin-right: 10px;
}
label:hover{
	color: #BDBDBD;
}
img{
	width: 70%;
	height: auto;
}
</style>
<script type="text/javascript">
	function notice() {
		if(${not empty param.searchColumn} && ${not empty param.searchValue}){
			location.href = "./notice.do?pageNo=" + ${pageNo} + "&searchColumn=${param.searchColumn}&searchValue=${param.searchValue}";
		} else{
			location.href = "./notice.do?pageNo=" + ${pageNo};
		}
	}
	
	function noticeDelete(){
		if(confirm("공지사항을 삭제하겠습니까?")){
			if(${not empty param.searchColumn} && ${not empty param.searchValue}){
				location.href = "./noticeDelete.do?pageNo=" + ${pageNo} + "&n_no=${detail.n_no}&u_nickname=${detail.u_nickname}&searchColumn=${param.searchColumn}&searchValue=${param.searchValue}";
			} else{
				location.href = "./noticeDelete.do?pageNo=" + ${pageNo} + "&n_no=${detail.n_no}&u_nickname=${detail.u_nickname}";
			}
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
	
	//댓글 글자수 제한
	$(document).on("input","#nc_comment",function(){
		if($(this).val().length>=300){
			$(this).val($(this).val().substring(0,300));
			$("#commentCount").html("댓글쓰기<br>(300/300)");
			$("#commentCount1").html("댓글수정<br>(300/300)");
			return;
		}
		$("#commentCount").html("댓글쓰기<br>(" + $(this).val().length + "/300)");
		$("#commentCount1").html("댓글수정<br>(" + $(this).val().length + "/300)");
	});
</script>

<c:if test="${user ne 'anonymousUser'}">
<script>

function noticeLike(u_nickname){
	$.ajax({
		  type: 'post',
		  url: './noticeLikeAjax.do',
		  data:{
			  "n_no" : ${detail.n_no},
			  "u_nickname":u_nickname},
		  dataType: 'json',
		  success: function(map){
			  if(map.result == 0){
			  	$('#noticeLikeImg').html(map.count + ' <i class="fa fa-heart" aria-hidden="true" onclick="noticeLike(\'${user.nickname}\')"></i>');
			  } else{
				$('#noticeLikeImg').html(map.count + ' <i class="fa fa-heart-o" aria-hidden="true" onclick="noticeLike(\'${user.nickname}\')"></i>');
			  }
		  },
		  error: function(error){
			  console.log(error);
		  }
	})
}

function noticeCommentDelete(nc_no){
	if(confirm("댓글을 삭제하겠습니까?")){
		if(${not empty param.searchColumn} && ${not empty param.searchValue}){
			location.href = "./noticeCommentDelete.do?pageNo=" + ${pageNo} + "&n_no=${detail.n_no}&nc_no=" + nc_no + "&searchColumn=${param.searchColumn}&searchValue=${param.searchValue}";
		} else{
			location.href = "./noticeCommentDelete.do?pageNo=" + ${pageNo} + "&n_no=${detail.n_no}&nc_no=" + nc_no;
		}
	}
}

function noticeCommentEdit(nc_no, nc_comment){
	if(confirm("댓글을 수정하겠습니까?")){
		var oldComment = nc_comment.trim();
		var temp = ''; 
		temp += '<div id="ceditform">'
		temp += '<form action="./noticeCommentEdit.do" method="post">';
		temp += '<input type="hidden" name="n_no" value="${detail.n_no }">'
		temp += '<input type="hidden" name="nc_no" value="' + nc_no + '">'
		temp += '<textarea name="nc_comment" id="nc_comment" required>' + nc_comment +'</textarea>'
		temp += '<input type="hidden" name="pageNo" value="${pageNo }">'
		temp += '<c:if test="${not empty param.searchColumn && not empty param.searchValue}">'
		temp += '<input type="hidden" name="searchColumn" value="${param.searchColumn }">'
		temp += '<input type="hidden" name="searchValue" value="${param.searchValue }">'
		temp += '</c:if>'
		temp += '<button type="submit" id="commentCount1">댓글수정<br>(' + nc_comment.length + '/300)</button>'
		temp += '</form>'
		temp += '</div>'
		$('#commentList').empty().html(temp);
		$(".commentEdit").remove();
		$(".commentDelete").remove();
		$('#noticeComment').remove();
		$("#cwriteform").remove();
		$('#nc_comment').trigger('input');
	}
}
</script>
</c:if>
</head>
<body>
	<!-- HEADER -->
	<header>
		<c:import url="./header.jsp"></c:import>
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
				<div id="back">
					<label onclick="notice()"><i class="fa fa-arrow-left" aria-hidden="true"></i>뒤로가기</label>
					<sec:authorize access="authenticated">
						<sec:authorize access="hasRole('ROLE_ADMIN') || principal != null && principal.nickname == '${detail.u_nickname }' ">
							<label onclick="showNoticeEditDialog()"><i class="fa fa-pencil" aria-hidden="true"></i>수정</label>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<label onclick="noticeDelete()"><i class="fa fa-trash-o" aria-hidden="true"></i>삭제</label>
						</sec:authorize>
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
						<fmt:parseDate value="${detail.n_date}" var="time"
							pattern="yyyy-MM-dd HH:mm:ss.S" />
						<fmt:formatDate value="${time}" var="time"
							pattern="yyyy-MM-dd HH:mm:ss" />
						<td>${time }</td>
					</tr>
					<tr>
						<th>조회수</th>
						<td>${detail.n_count }</td>
					</tr>
					<tr>
						<th>좋아요</th>
						<td id="noticeLikeImg">
							${detail.n_like }
							<c:if test="${user ne 'anonymousUser'}">
								<c:choose>
									<c:when test="${not empty likeStatus and likeStatus == true }">
										<i class="fa fa-heart" aria-hidden="true" onclick="noticeLike('<c:out value="${user.nickname}"/>')"></i>
									</c:when>
									<c:otherwise>
										<i class="fa fa-heart-o" aria-hidden="true" onclick="noticeLike('<c:out value="${user.nickname}"/>')"></i>
									</c:otherwise>
								</c:choose>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>${detail.n_content }</td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">댓글</th>
						<td><sec:authorize access="authenticated">
								<div id="cwriteform">
									<form action="./noticeComment.do" method="post">
										<input type="hidden" name="n_no" value="${detail.n_no }">
										<textarea name="nc_comment" id="nc_comment" required></textarea>
										<input type="hidden" name="pageNo" value="${pageNo }">
										<c:if
											test="${not empty param.searchColumn && not empty param.searchValue}">
											<input type="hidden" name="searchColumn"
												value="${param.searchColumn }">
											<input type="hidden" name="searchValue"
												value="${param.searchValue }">
										</c:if>
										<button type="submit" id="commentCount">댓글쓰기<br>(0/300)</button>
									</form>
								</div>
							</sec:authorize> <c:choose>
								<c:when test="${fn:length(commentList) gt 0 }">
									<c:forEach var="c" items="${commentList }">
										<div id="commentList">
											<fmt:parseDate value="${c.nc_date}" var="time"
												pattern="yyyy-MM-dd HH:mm:ss.S" />
											<fmt:formatDate value="${time}" var="time"
												pattern="yyyy-MM-dd HH:mm:ss" />
											<strong>${c.u_nickname }</strong> / ${time } <c:if test="${user ne 'anonymousUser' and user.nickname eq c.u_nickname }">
												<i class="fa fa-pencil commentEdit" aria-hidden="true" onclick="noticeCommentEdit(${c.nc_no}, '<c:out value="${c.nc_comment }"/>')"></i><i class="fa fa-trash-o commentDelete" aria-hidden="true" onclick="noticeCommentDelete(${c.nc_no})"></i>
											</c:if>
										</div>
										<div id="noticeComment"><pre>${c.nc_comment }</pre></div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									댓글이 없습니다.
								</c:otherwise>
							</c:choose></td>
					</tr>
				</table>
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


	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<dialog id="noticeEditDialog">
			<div>
				<form action="./noticeEdit.do" method="post">
					<div style="padding-bottom: 10px;">
						<h2>
							<label>제목</label>
						</h2>
						<input style="width: 100%;" type="text" name="n_title"
							value="${detail.n_title }" required>
					</div>
					<div style="padding-bottom: 10px;">
						<h4>
							<label>내용</label>
						</h4>
						<textarea id="summernote" name="n_content" required><c:out value="${detail.n_content}" /></textarea>
					</div>
					<input type="hidden" name="pageNo" value="${pageNo }"> <input
						type="hidden" name="n_no" value="${detail.n_no }">
					<c:if test="${not empty param.searchColumn && not empty param.searchValue}">
						<input type="hidden" name="searchColumn" value="${param.searchColumn }">
						<input type="hidden" name="searchValue" value="${param.searchValue }">
					</c:if>
					<input type="hidden" name="u_nickname" value="${detail.u_nickname }">
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
