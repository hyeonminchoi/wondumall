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
#boardComment{
	width: 100%;
}
pre{
	width: 100%;
	min-height: 50px;
	height : auto;
	box-sizing:border-box;
	white-space: pre-wrap;
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
</style>
<script type="text/javascript">
	function board() {
		if(${not empty param.searchColumn} && ${not empty param.searchValue}){
			location.href = "./board.do?pageNo=" + ${pageNo} + "&searchColumn=${param.searchColumn}&searchValue=${param.searchValue}";
		} else{
			location.href = "./board.do?pageNo=" + ${pageNo};
		}
	}
	
	function boardDelete(){
		if(confirm("글을 삭제하겠습니까?")){
			if(${not empty param.searchColumn} && ${not empty param.searchValue}){
				location.href = "./boardDelete.do?pageNo=" + ${pageNo} + "&b_no=${detail.b_no}&searchColumn=${param.searchColumn}&searchValue=${param.searchValue}";
			} else{
				location.href = "./boardDelete.do?pageNo=" + ${pageNo} + "&b_no=${detail.b_no}";
			}
		}
	}
	
	function sendFile(file, el) {
		var form_data = new FormData();
		form_data.append('file', file);
		$.ajax({
			data : form_data,
			type : "POST",
			url : './boardImage.do',
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
	$(document).on("input","#c_comment",function(){
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

function boardLike(u_nickname){
	$.ajax({
		  type: 'post',
		  url: './boardLikeAjax.do',
		  data:{
			  "b_no" : ${detail.b_no},
			  "u_nickname":u_nickname},
		  dataType: 'json',
		  success: function(map){
			  if(map.result == 0){
			  	$('#boardLikeImg').html(map.count + ' <i class="fa fa-heart" aria-hidden="true" onclick="boardLike(\'${user.nickname}\')"></i>');
			  } else{
				$('#boardLikeImg').html(map.count + ' <i class="fa fa-heart-o" aria-hidden="true" onclick="boardLike(\'${user.nickname}\')"></i>');
			  }
		  },
		  error: function(error){
			  console.log(error);
		  }
	})
}

function boardCommentDelete(c_no){
	if(confirm("댓글을 삭제하겠습니까?")){
		if(${not empty param.searchColumn} && ${not empty param.searchValue}){
			location.href = "./boardCommentDelete.do?pageNo=" + ${pageNo} + "&b_no=${detail.b_no}&c_no=" + c_no + "&searchColumn=${param.searchColumn}&searchValue=${param.searchValue}";
		} else{
			location.href = "./boardCommentDelete.do?pageNo=" + ${pageNo} + "&b_no=${detail.b_no}&c_no=" + c_no;
		}
	}
}

function boardCommentEdit(c_no, c_comment){
	if(confirm("댓글을 수정하겠습니까?")){
		var oldComment = c_comment.trim();
		var temp = ''; 
		temp += '<div id="ceditform">'
		temp += '<form action="./boardCommentEdit.do" method="post">';
		temp += '<input type="hidden" name="b_no" value="${detail.b_no }">'
		temp += '<input type="hidden" name="c_no" value="' + c_no + '">'
		temp += '<textarea name="c_comment" id="c_comment" required>' + c_comment +'</textarea>'
		temp += '<input type="hidden" name="pageNo" value="${pageNo }">'
		temp += '<c:if test="${not empty param.searchColumn && not empty param.searchValue}">'
		temp += '<input type="hidden" name="searchColumn" value="${param.searchColumn }">'
		temp += '<input type="hidden" name="searchValue" value="${param.searchValue }">'
		temp += '</c:if>'
		temp += '<input type="hidden" name="u_nickname" value="<sec:authentication property="principal.nickname" />">'
		temp += '<button type="submit" id="commentCount1">댓글수정<br>(' + c_comment.length + '/300)</button>'
		temp += '</form>'
		temp += '</div>'
		$('#commentList').empty().html(temp);
		$(".commentEdit").remove();
		$(".commentDelete").remove();
		$('#boardComment').remove();
		$("#cwriteform").remove();
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
				<label onclick="board()"><i class="fa fa-arrow-left" aria-hidden="true"></i>뒤로가기</label>
				<sec:authorize access="authenticated">
					<sec:authorize access="principal.nickname == '${detail.u_nickname }' ">
						<label onclick="showBoardEditDialog()"><i class="fa fa-pencil" aria-hidden="true"></i>수정</label>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_ADMIN') || principal.nickname == '${detail.u_nickname }' ">
						<label onclick="boardDelete()"><i class="fa fa-trash-o" aria-hidden="true"></i>삭제</label>
					</sec:authorize>
				</sec:authorize>
			</div>
			<table class="table table-bordered">
				<tr>
					<th>번호</th>
					<td>${detail.b_no }</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${detail.b_title }</td>
				</tr>
				<tr>
					<th>글쓴이</th>
					<td>${detail.u_nickname }</td>
				</tr>
				<tr>
					<th>작성일</th>
					<fmt:parseDate value="${detail.b_date}" var="time"
						pattern="yyyy-MM-dd HH:mm:ss.S" />
					<fmt:formatDate value="${time}" var="time"
						pattern="yyyy-MM-dd HH:mm:ss" />
					<td>${time }</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>${detail.b_count }</td>
				</tr>
				<tr>
					<th>좋아요</th>
					<td id="boardLikeImg">
						${detail.b_like }
						<c:if test="${user ne 'anonymousUser'}">
							<c:choose>
								<c:when test="${not empty likeStatus and likeStatus == true }">
									<i class="fa fa-heart" aria-hidden="true" onclick="boardLike('${user.nickname}')"></i>
								</c:when>
								<c:otherwise>
									<i class="fa fa-heart-o" aria-hidden="true" onclick="boardLike('${user.nickname}')"></i>
								</c:otherwise>
							</c:choose>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${detail.b_content }</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">댓글</th>
					<td><sec:authorize access="authenticated">
							<div id="cwriteform">
								<form action="./boardComment.do" method="post">
									<input type="hidden" name="b_no" value="${detail.b_no }">
									<textarea name="c_comment" id="c_comment" required></textarea>
									<input type="hidden" name="pageNo" value="${pageNo }">
									<c:if
										test="${not empty param.searchColumn && not empty param.searchValue}">
										<input type="hidden" name="searchColumn"
											value="${param.searchColumn }">
										<input type="hidden" name="searchValue"
											value="${param.searchValue }">
									</c:if>
									<input type="hidden" name="u_nickname"
										value="<sec:authentication property="principal.nickname" />">
									<button type="submit" id="commentCount">댓글쓰기<br>(0/300)</button>
								</form>
							</div>
						</sec:authorize> <c:choose>
							<c:when test="${fn:length(commentList) gt 0 }">
								<c:forEach var="c" items="${commentList }">
									<div id="commentList">
										<fmt:parseDate value="${c.c_date}" var="time"
											pattern="yyyy-MM-dd HH:mm:ss.S" />
										<fmt:formatDate value="${time}" var="time"
											pattern="yyyy-MM-dd HH:mm:ss" />
										<strong>${c.u_nickname }</strong> / ${time } <c:if test="${user ne 'anonymousUser' and user.nickname eq c.u_nickname }">
											<i class="fa fa-pencil commentEdit" aria-hidden="true" onclick="boardCommentEdit(${c.c_no}, '${c.c_comment }')"></i><i class="fa fa-trash-o commentDelete" aria-hidden="true" onclick="boardCommentDelete(${c.c_no})"></i>
										</c:if>
									</div>
									<div id="boardComment"><pre>${c.c_comment }</pre></div>
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

	<!-- FOOTER -->
	<footer id="footer">
		<c:import url="./footer.jsp"></c:import>
	</footer>
	<!-- /FOOTER -->

<sec:authorize access="authenticated">
	<dialog id="boardEditDialog">
		<div>
			<form action="./boardEdit.do" method="post">
				<div style="padding-bottom: 10px;">
					<h2>
						<label>제목</label>
					</h2>
					<input style="width: 100%;" type="text" name="b_title"
						value="${detail.b_title }" required>
				</div>
				<div style="padding-bottom: 10px;">
					<h4>
						<label>내용</label>
					</h4>
					<textarea id="summernote" name="b_content" required><c:out value="${detail.b_content}" /></textarea>
				</div>
				<input type="hidden" name="pageNo" value="${pageNo }"> <input
					type="hidden" name="b_no" value="${detail.b_no }">
				<c:if
					test="${not empty param.searchColumn && not empty param.searchValue}">
					<input type="hidden" name="searchColumn"
						value="${param.searchColumn }">
					<input type="hidden" name="searchValue"
						value="${param.searchValue }">
				</c:if>
				<input type="hidden" name="u_nickname"
					value="<sec:authentication property="principal.nickname" />">
				<div>
					<button type="submit">수정</button>
					<button type="button" onclick="hideBoardEditDialog()">닫기</button>
				</div>
			</form>
		</div>
	</dialog>

	<script>
	
	var boardEditDialog = document.getElementById('boardEditDialog');
	
	function showBoardEditDialog(){
		boardEditDialog.showModal();
	}
	function hideBoardEditDialog(){
		boardEditDialog.close();
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
