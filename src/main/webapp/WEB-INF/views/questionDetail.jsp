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

#awriteform, #aeditform {
	width: 100%;
	height: 170px;
	background-color: #c1c1c1;
	padding: 10px;
	margin-bottom: 10px;
}

#awriteform textarea, #aeditform textarea {
	width: calc(100% - 85px);
	height: 150px;
	margin-right: -3px;
	vertical-align: middle;
	padding: 10px;
	box-sizing: border-box;
	resize: none;
}

#awriteform button, #aeditform button {
	vertical-align: middle;
	width: 80px;
	height: 150px;
	margin-left: -2px;
	border: 0px;
	background-color: black;
	color: white;
}
#answer{
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
	function answer() {
		if(${not empty param.searchColumn} && ${not empty param.searchValue}){
			location.href = "./question.do?pageNo=" + ${pageNo} + "&searchColumn=${param.searchColumn}&searchValue=${param.searchValue}";
		} else{
			location.href = "./question.do?pageNo=" + ${pageNo};
		}
	}
	
	function questionDelete(){
		if(confirm("질문을 삭제하겠습니까?")){
			if(${not empty param.searchColumn} && ${not empty param.searchValue}){
				location.href = "./questionDelete.do?pageNo=" + ${pageNo} + "&q_no=${detail.q_no}&searchColumn=${param.searchColumn}&searchValue=${param.searchValue}";
			} else{
				location.href = "./questionDelete.do?pageNo=" + ${pageNo} + "&q_no=${detail.q_no}";
			}
		}
	}
	
	function sendFile(file, el) {
		var form_data = new FormData();
		form_data.append('file', file);
		$.ajax({
			data : form_data,
			type : "POST",
			url : './answerImage.do',
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
	
	//답변 글자수 제한
	$(document).on("input","#answer",function(){
		if($(this).val().length>=300){
			$(this).val($(this).val().substring(0,300));
			$("#answerCount").html("답변쓰기<br>(300/300)");
			$("#answerCount1").html("답변수정<br>(300/300)");
			return;
		}
		$("#answerCount").html("답변쓰기<br>(" + $(this).val().length + "/300)");
		$("#answerCount1").html("답변수정<br>(" + $(this).val().length + "/300)");
	});
</script>

<sec:authorize access="hasRole('ROLE_ADMIN')">
<script>

function answerDelete(a_no){
	if(confirm("답변을 삭제하겠습니까?")){
		if(${not empty param.searchColumn} && ${not empty param.searchValue}){
			location.href = "./answerDelete.do?pageNo=" + ${pageNo} + "&q_no=${detail.q_no}&a_no=" + a_no + "&searchColumn=${param.searchColumn}&searchValue=${param.searchValue}";
		} else{
			location.href = "./answerDelete.do?pageNo=" + ${pageNo} + "&q_no=${detail.q_no}&a_no=" + a_no;
		}
	}
}

function answerEdit(a_no, answer){
	if(confirm("답변을 수정하겠습니까?")){
		var oldComment = answer.trim();
		var temp = ''; 
		temp += '<div id="aeditform">'
		temp += '<form action="./answerEdit.do" method="post">';
		temp += '<input type="hidden" name="q_no" value="${detail.q_no }">'
		temp += '<input type="hidden" name="a_no" value="' + a_no + '">'
		temp += '<textarea name="a_answer" id="a_answer" required>' + answer +'</textarea>'
		temp += '<input type="hidden" name="pageNo" value="${pageNo }">'
		temp += '<c:if test="${not empty param.searchColumn && not empty param.searchValue}">'
		temp += '<input type="hidden" name="searchColumn" value="${param.searchColumn }">'
		temp += '<input type="hidden" name="searchValue" value="${param.searchValue }">'
		temp += '</c:if>'
		temp += '<input type="hidden" name="u_nickname" value="<sec:authentication property="principal.nickname" />">'
		temp += '<button type="submit" id="answerCount1">답변수정<br>(' + answer.length + '/300)</button>'
		temp += '</form>'
		temp += '</div>'
		$('#answerList').empty().html(temp);
		$(".answerEdit").remove();
		$(".answerDelete").remove();
		$('#answer').remove();
		$("#awriteform").remove();
	}
}
</script>
</sec:authorize>
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
	
	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<div id="back">
				<label onclick="answer()"><i class="fa fa-arrow-left" aria-hidden="true"></i>뒤로가기</label>
				<sec:authorize access="authenticated">
					<sec:authorize access="principal.nickname == '${detail.u_nickname }' ">
						<label onclick="showQuestionEditDialog()"><i class="fa fa-pencil" aria-hidden="true"></i>수정</label>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_ADMIN') || principal.nickname == '${detail.u_nickname }' ">
						<label onclick="questionDelete()"><i class="fa fa-trash-o" aria-hidden="true"></i>삭제</label>
					</sec:authorize>
				</sec:authorize>
			</div>
			<table class="table table-bordered">
				<tr>
					<th>번호</th>
					<td>${detail.q_no }</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${detail.q_title }</td>
				</tr>
				<tr>
					<th>글쓴이</th>
					<td>${detail.u_nickname }</td>
				</tr>
				<tr>
					<th>작성일</th>
					<fmt:parseDate value="${detail.q_date}" var="time"
						pattern="yyyy-MM-dd HH:mm:ss.S" />
					<fmt:formatDate value="${time}" var="time"
						pattern="yyyy-MM-dd HH:mm:ss" />
					<td>${time }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${detail.q_content }</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">답변</th>
					<td><sec:authorize access="authenticated">
							<div id="awriteform">
								<form action="./answer.do" method="post">
									<input type="hidden" name="q_no" value="${detail.q_no }">
									<textarea name="a_answer" id="a_answer" required></textarea>
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
									<button type="submit" id="answerCount">답변쓰기<br>(0/300)</button>
								</form>
							</div>
						</sec:authorize> <c:choose>
							<c:when test="${fn:length(answerList) gt 0 }">
								<c:forEach var="a" items="${answerList }">
									<div id="answerList">
										<fmt:parseDate value="${a.a_date}" var="time"
											pattern="yyyy-MM-dd HH:mm:ss.S" />
										<fmt:formatDate value="${time}" var="time"
											pattern="yyyy-MM-dd HH:mm:ss" />
										<strong>${a.u_nickname }</strong> / ${time } <c:if test="${user ne 'anonymousUser' and user.nickname eq a.u_nickname }">
											<i class="fa fa-pencil answerEdit" aria-hidden="true" onclick="answerEdit(${a.a_no}, '${a.a_answer }')"></i><i class="fa fa-trash-o answerDelete" aria-hidden="true" onclick="answerDelete(${a.a_no})"></i>
										</c:if>
									</div>
									<div id="answer"><pre>${a.a_answer }</pre></div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								답변이 없습니다.
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
	<dialog id="questionEditDialog">
		<div>
			<form action="./questionEdit.do" method="post">
				<div style="padding-bottom: 10px;">
					<h2>
						<label>제목</label>
					</h2>
					<input style="width: 100%;" type="text" name="q_title"
						value="${detail.q_title }" required>
				</div>
				<div style="padding-bottom: 10px;">
					<h4>
						<label>내용</label>
					</h4>
					<textarea id="summernote" name="q_content" required><c:out value="${detail.q_content}" /></textarea>
				</div>
				<input type="hidden" name="pageNo" value="${pageNo }"> <input
					type="hidden" name="q_no" value="${detail.q_no }">
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
					<button type="button" onclick="hideQuestionEditDialog()">닫기</button>
				</div>
			</form>
		</div>
	</dialog>

	<script>
	
	var questionEditDialog = document.getElementById('questionEditDialog');
	
	function showQuestionEditDialog(){
		questionEditDialog.showModal();
	}
	function hideQuestionEditDialog(){
		questionEditDialog.close();
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
