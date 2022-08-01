<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title>카테고리</title>

 		<!-- Google font -->
 		<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

 		<!-- Bootstrap -->
 		<link type="text/css" rel="stylesheet" href="./css/bootstrap.min.css"/>

 		<!-- Slick -->
 		<link type="text/css" rel="stylesheet" href="./css/slick.css"/>
 		<link type="text/css" rel="stylesheet" href="./css/slick-theme.css"/>

 		<!-- nouislider -->
 		<link type="text/css" rel="stylesheet" href="./css/nouislider.min.css"/>

 		<!-- Font Awesome Icon -->
 		<link rel="stylesheet" href="./css/font-awesome.min.css">

 		<!-- Custom stlylesheet -->
 		<link type="text/css" rel="stylesheet" href="./css/style.css"/>
<script type="text/javascript">
function linkPage(catePageNo){
	location.href = "./category.do?cate_no=${param.cate_no}&catePageNo=" + catePageNo;
}
</script>
<style type="text/css">
tr{
max-width: 996px;
margin-left: auto;
margin-right: auto;
margin-bottom: 20px;
}
/* 별점 */
.starRev{
	width: 170px;
	margin: 0 auto;
	height: 30px;
	display: inline-block;
}
.starR1 {
	background:
		url('http://miuu227.godohosting.com/images/icon/ico_review.png')
		no-repeat -52px 0;
	background-size: auto 100%;
	width: 15px;
	height: 30px;
	float: left;
	text-indent: -9999px;
	cursor: pointer;
}
.starR2 {
	background:
		url('http://miuu227.godohosting.com/images/icon/ico_review.png')
		no-repeat right 0;
	background-size: auto 100%;
	width: 15px;
	height: 30px;
	float: left;
	text-indent: -9999px;
	cursor: pointer;
}
.starR1.on {
	background-position: 0 0;
}
.starR2.on {
	background-position: -15px 0;
}

/* 상품 표 */
	.list_search_result{
		width: 90%;
	    margin: auto;	
	}
	.type_list{
	    width: 100%;
	    border-bottom: 1px solid #e7e7e7;
	    border-collapse: collapse;	
	}
	.type_list tr{
		height:200px;
		border-bottom: 1px solid #e7e7e7;
	}
	.detail div{
		margin-bottom: 5px;
	}
	.category{
		font-size: 12px;
    	font-weight: 600;
	}
	.title{
	    font-size: 20px;
	    color: #3a60df;
	    font-weight: 700;
	}
	.author{
		font-size: 14px;
	}
	.info{
		text-align: center;
	}
	.price{
		text-align: center;
	}
	.org_price del{
		font-size: 13px;
	}
	.sell_price strong{
		color: #da6262;
    	font-size: 18px;
	}
#wonduImg{
	width: 830px;
    height: 466px;
	margin-left: 175px;
}
.rating{
	font-size: 18px;
    font-weight: 600;
    margin-top: 6px;
}
</style>
</head>
<body>
	<!-- HEADER -->
	<header>
		<c:import url="/header.do"></c:import>
	</header>
	<!-- /HEADER -->
	<!-- NAVIGATION -->
		<nav id="navigation">
			<c:import url="/nav.do"></c:import>
		</nav>
	<!-- /NAVIGATION -->
	<!-- HEADER -->
		<main>
			<div id="cont">
				<div id="float_layer">
					<c:import url="./recentlySee.jsp"></c:import>
				</div>
			</div>
		</main>
	<!-- /HEADER -->
	<section>
		<div id="breadcrumb" class="section">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<div class="col-md-12">
							<h3 class="breadcrumb-header">카테고리</h3>
							<ul class="breadcrumb-tree">
								<li><a href="./">Home</a></li>
								<li><a href="./category.do">All Categories</a></li>
							</ul>
						</div>
					</div>
					<!-- /row -->
				</div>
				<!-- /container -->
			</div>
			<!-- /BREADCRUMB -->
		<div class="section">
			<div class="container">
				<div class="row">
					<div class="img">
						<c:if test="${productList[0].cate_no == 2}">
							<img id="wonduImg" alt="" src="./img/wonduBackground.png">
						</c:if>
						<c:if test="${productList[0].cate_no == 3}">
							<img id="wonduImg" alt="" src="./img/machineBackground.png">
						</c:if>
						<c:if test="${productList[0].cate_no == 4}">
							<img id="wonduImg" alt="" src="./img/accessoryBackground.png">
						</c:if>
					</div>
					<hr>
							<table class="type_list">
							<tbody id="searchList>">
								<c:forEach items="${productList}" var="p">
									<tr>
										<td class="image" style="width: 230px;">
											<img src="./productUpload/${p.p_img}" style="width: 100px; height: 100px; margin-left: 50px;" alt="로딩 실패">
										</td>
										<td class="detail">
											<div class="category">
												[${p.category}]
											</div>
											<div class="title">
												<a class="title" href="./productDetail.do?p_no=${p.p_no}">${p.p_name}</a>
											</div>
											<div class="author">
												${p.p_description}
											</div>
										</td>
										<td class="info">
											<div>
												<div class="starRev">
													<span class="starR1 ${p.rating>=0.5?'on':'' }">0.5</span>
													<span class="starR2 ${p.rating>=1?'on':'' }">1</span>
													<span class="starR1 ${p.rating>=1.5?'on':'' }">1.5</span>
													<span class="starR2 ${p.rating>=2?'on':'' }">2</span>
													<span class="starR1 ${p.rating>=2.5?'on':'' }">2.5</span>
													<span class="starR2 ${p.rating>=3?'on':'' }">3</span>
													<span class="starR1 ${p.rating>=3.5?'on':'' }">3.5</span>
													<span class="starR2 ${p.rating>=4?'on':'' }">4</span>
													<span class="starR1 ${p.rating>=4.5?'on':'' }">4.5</span>
													<span class="starR2 ${p.rating>=5?'on':'' }">5</span>
												</div>
											</div>
											<div class="rating">
												${p.rating }
											</div>
										</td>
										<td class="price">
											<div class="sell_price">
												<strong>
													<fmt:formatNumber pattern="###,###,###" value="${p.p_price }" />원
												</strong>
											</div>
										</td>
										<td class="option">
											<div class="add-to-cart">
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					<div style="text-align: center; margin-top: 30px;">
						<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage"/>
					</div>
				</div>
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
</body>
</html>