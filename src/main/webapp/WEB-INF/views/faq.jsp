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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
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

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

<!-- jQuery Plugins -->
<script src="./js/jquery.min.js"></script>
<script src="./js/jquery.min.js"></script>
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
 	height: auto;
	width: 100%;
}

.answer {
	display: none;
}

.navbar-nav{
	flex-direction: inherit;
}
img{
	width: 70%;
	height: auto;
}
label{
	margin-left: 20px;
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
	<section>
		<div class="section">
			<!-- container -->
			<div class="container">
				<div class="accordion">
					<h2 class="title01">자주묻는질문</h2>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<div style="float:right; margin-bottom: 20px;">
							<button type="button" onclick="showFaqWriteDialog()"><i class="fa fa-pencil" aria-hidden="true"></i>글쓰기</button>
						</div>
					</sec:authorize>
					
					<ul class="webtong_tab_type02 tabs">
						<c:forEach var="fc" items="${faqCategory }" varStatus="fcvar">
							<li class="tab-link ${fcvar.index eq 0 ? 'current':'' }" data-tab="tab-${fcvar.index}"><strong><a>${fc.fc_category }</a></strong>
						</c:forEach>
					</ul>
					
					<c:forEach var="j" items="${faqCategoryDetail}" varStatus="jvar" >
						<div id="tab-${jvar.index}" class="tab-content accordion-item ${jvar.index eq 0 ?'current':'' }">
							<c:forEach var="k" items="${j}" varStatus="kvar">
								<h2 class="accordion-header" id="headingOne">
							      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${jvar.index }${kvar.index }" aria-expanded="true" aria-controls="collapse${jvar.index }${kvar.index }">
							        <h4 id="question">${k.faq_question }</h4>
							      </button>
							    </h2>
							    <div id="collapse${jvar.index }${kvar.index }" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent=".accordion">
							    	<div class="accordion-body">
							        	${k.faq_answer }
								    </div>
									<sec:authorize access="authenticated">
										<sec:authorize access="hasRole('ROLE_ADMIN')">
											<label onclick="showFaqEditDialog(${k.faq_no})"><i class="fa fa-pencil" aria-hidden="true"></i>수정</label>
											<label onclick="faqDelete(${k.faq_no})"><i class="fa fa-trash-o" aria-hidden="true"></i>삭제</label>
										</sec:authorize>
									</sec:authorize>
							    </div>
							</c:forEach>
						</div>
					</c:forEach>
				</div>
			</div>
			<!-- /container -->
		</div>
	</section>
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
				<div>
					<button type="submit">글쓰기</button>
					<button type="button" onclick="hideFaqWriteDialog()">닫기</button>
				</div>
			</form>
		</div>
	</dialog>
	
	<dialog id="faqEditDialog">
		<div>
			<form action="./faqEdit.do" method="post">
				<div style="padding-bottom: 10px;">
					<label>카테고리
						<select style="width: 100%;" name="fc_category" id="fc_category" required>
							<option value="">카테고리를 선택해주세요</option>
							<c:forEach var="category" items="${faqCategory }">
								<option value="${category.fc_category }">${category.fc_category }</option>
							</c:forEach>
						</select>
					</label>
				</div>
				<div style="padding-bottom: 10px;">
					<h2><label>제목</label></h2>
					<input style="width: 100%;" type="text" name="faq_question" id="faq_question" required>
				</div>
				<div style="padding-bottom: 10px;">
					<h4><label>내용</label></h4>
					<textarea id="summernote2" name="faq_answer" required></textarea>
				</div>
				<input type="hidden" name="faq_no" id="faq_no">
				<input type="hidden" name="u_nickname" value="${detail.u_nickname }">
				<div>
					<button type="submit">수정</button>
					<button type="button" onclick="hideFaqEditDialog()">닫기</button>
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

var faqEditDialog = document.getElementById('faqEditDialog');

function showFaqEditDialog(faq_no){
	$.ajax({
		url : './faqDetailAjax.do',
		type : "GET",
		dataType: "json",
		data:{ faq_no : faq_no},
		success : function(detail) {
			$('#faq_question').val(detail.faq_question);
			$("#fc_category").val(detail.fc_category).prop("selected",true);
			$("#faq_no").attr('value',detail.faq_no);
			$('#summernote2').summernote('code', detail.faq_answer);
			faqEditDialog.showModal();
		},
		error:function(){
			console.log("error");
		}
	})
}
function hideFaqEditDialog(){
	faqEditDialog.close();
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
	  $('#summernote2').summernote({
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

function faqDelete(faq_no){
	if(confirm("자주묻는질문을 삭제하겠습니까?")){
		location.href="./faqDelete.do?faq_no=" + faq_no;
	}
}

</script>
</sec:authorize>

</body>
</html>
