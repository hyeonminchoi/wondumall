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

.webtong_tab_type02 { display:table; width:100%; table-layout:fixed; border-left:1px solid #e7e7e7;position:relative;background-color: #f1f1f1}
.webtong_tab_type02 li { display:table-cell; height:50px}
.webtong_tab_type02 li a { display:block;position:relative;height:50px;border-top:1px solid #e7e7e7;border-bottom:1px solid #e7e7e7;line-height:50px;text-align:center;background-color: #fff}
.webtong_tab_type02 li a:after { content:''; display:block; position:absolute; top:0; right:0; bottom:0; width:1px; background:#e6e3df}
.webtong_tab_type02 li.current a, .webtong_tab_type02 li:hover a {border-bottom-color:#f34b53; border-top:1px solid #f34b53;z-index: 1;background-color: #fd7c82;color:#fff}
.webtong_tab_type02 li.current a:after, .webtong_tab_type02 li:hover a:after { content:''; display:block; position:absolute; top:0; right:0; bottom:-1px; width:1px; background:#f34b53}
.webtong_tab_type02 li.current a:before, .webtong_tab_type02 li:hover a:before { content:''; display:block; position:absolute; top:0; left:0; bottom:-1px; width:1px; background:#f34b53}

.tab-content{
  	display: none;
  	background-color: rgba(255,255,255,0.4);
}
.tab-content.current{
	background-color: rgba(255,255,255,0.4);
 	display: block;
 	height: 350px;
	width: 100%;
}

.answer {
	display: none;
}

</style>

<script type="text/javascript">
	
	function sendFile(file, el) {
		var form_data = new FormData();
		form_data.append('file', file);
		$.ajax({
			data : form_data,
			type : "POST",
			url : './faqImage.do',
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
	
	$(document).ready(function(){
	    $('ul.tabs li').click(function(){
	        var tab_id = $(this).attr('data-tab');
	        $('ul.tabs li').removeClass('current');
	        $('.tab-content').removeClass('current');
	        $(this).addClass('current');
	        $("#"+tab_id).addClass('current');
	    });
	    
	    $('.question').on('click',function(){
	    	if($(this).children('i').hasClass('fa-angle-down')){
	    		$(this).children('i').removeClass('fa-angle-down');
	    		$(this).children('i').addClass('fa-angle-up');
	    	} else{
	    		$(this).children('i').addClass('fa-angle-down');
	    		$(this).children('i').removeClass('fa-angle-up');
	    	}
	    	$(this).parent().children('.answer').toggle(500);
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
		<c:import url="./communityNav.jsp"></c:import>
	<!-- /NAVIGATION -->
	
	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<h2 class="title01">자주묻는질문</h2>
			<ul class="webtong_tab_type02 tabs">
				<li class="tab-link current" data-tab="tab-0"><a>전체</a></li>
				<c:forEach var="fc" items="${faqCategory }" varStatus="status">
					<li class="tab-link" data-tab="tab-${status.count}"><a>${fc.fc_category }</a>
				</c:forEach>
			</ul>
			<div id="tab-0" class="tab-content current owl-example owl-carousel">
					<c:forEach var="i" items="${faqAll}">
						<div class="items">
							<div class="question">
								${i.faq_question}<i class="fa fa-angle-down" aria-hidden="true"></i>
							</div>
							<div class="answer">
								${i.faq_answer }
							</div>
						</div>
					</c:forEach>
			</div>
			<c:forEach var="j" items="${faqCategoryDetail}" varStatus="status" >
				<div id="tab-${status.count}" class="tab-content owl-example owl-carousel">
					<c:forEach var="k" items="${j}">
						<div class="items">
							<div class="question">
								${k.faq_question }<i class="fa fa-angle-down" aria-hidden="true"></i>
							</div>
							<div class="answer">
								${k.faq_answer }
							</div>
						</div>
					</c:forEach>
				</div>
			</c:forEach>
							
			
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div style="float:right;">
					<button type="button" onclick="showFaqWriteDialog()"><i class="fa fa-pencil" aria-hidden="true"></i>글쓰기</button>
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

<!-- 관리자만 자주묻는 질문 작성 가능 -->
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<dialog id="faqWriteDialog">
		<div>
			<form action="./faqWrite.do" method="post">
				<div style="padding-bottom: 10px;">
					<label>카테고리
						<select style="width: 100%;" name="fc_category" required>
							<option value="">카테고리를 선택해주세요</option>
							<c:forEach var="category" items="${faqCategory }">
								<option value="${category.fc_category }">${category.fc_category }</option>
							</c:forEach>
						</select>
					</label>
				</div>
				<div style="padding-bottom: 10px;">
					<h2><label>제목</label></h2>
					<input style="width: 100%;" type="text" name="faq_question" required>
				</div>
				<div style="padding-bottom: 10px;">
					<h4><label>내용</label></h4>
					<textarea id="summernote" name="faq_answer" required></textarea>
				</div>
				<input type="hidden" name="u_nickname" value="<sec:authentication property="principal.nickname" />">
				<div>
					<button type="submit">글쓰기</button>
					<button type="button" onclick="hideFaqWriteDialog()">닫기</button>
				</div>
			</form>
		</div>
	</dialog>
	
<script>
var faqWriteDialog = document.getElementById('faqWriteDialog');

function showFaqWriteDialog(){
	faqWriteDialog.showModal();
}
function hideFaqWriteDialog(){
	faqWriteDialog.close();
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
