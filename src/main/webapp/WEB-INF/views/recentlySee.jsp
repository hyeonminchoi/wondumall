<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

			<title>recentlySee</title>

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
<script type="text/javascript">
$(function(){
	function getCookie(name) { //--가져올 쿠키의 이름을 파라미터 값으로 받고
		var nameOfCookie = name + "="; //--쿠키는 "쿠키=값" 형태로 가지고 있어서 뒤에 있는 값을 가져오기 위해 = 포함
		var x = 0; 
		while (x <= document.cookie.length) {  //--현재 세션에 가지고 있는 쿠키의 총 길이를 가지고 반복
			var y = (x + nameOfCookie.length); //--substring으로 찾아낼 쿠키의 이름 길이 저장
			if (document.cookie.substring(x, y) == nameOfCookie) { //--잘라낸 쿠키와 쿠키의 이름이 같다면
			if ((endOfCookie = document.cookie.indexOf(";", y)) == -1) //--y의 위치로부터 ;값까지 값이 있으면 
				endOfCookie = document.cookie.length; //--쿠키의 길이로 적용하고
				return unescape(document.cookie.substring(y, endOfCookie)); //--쿠키의 시작점과 끝점을 찾아서 값을 반환
				} 
				x = document.cookie.indexOf(" ", x) + 1; //--다음 쿠키를 찾기 위해 시작점을 반환
				if (x == 0) //--쿠키 마지막이면 
				break; //--반복문 빠져나오기
			} 
		return ""; //--빈값 반환
	}
	
	var cookie = getCookie('recentlySee');
	let temp = cookie.split("_"); 
	let arr = [];
	for(let i=0;i<temp.length;i++){
		arr[i] = temp[i].substring(1, temp[i].length-1);
	}
	
	$.ajax({
		url: './recentlySee.do',
		type: 'post',
		dataType:'json',
		data:{'arr': arr},
		success: function(result){
			let tr = '';
			for(i in result){
				tr += "<tr>";
				tr += "<td>";
				tr += result[i].p_name;
				tr += "<img src='./productUpload/" + result[i].p_img + "'>"
				tr += "</td>";
				tr += "</tr>";
			}
			$('#recentlySee').append(tr);
		},
		error: function(){
			console.log("error");
		}
	});
})
</script>
<style type="text/css">
#rightSide {
	position: absolute;
	top: 547px;
	left: 50%;
	margin: 0 0 0 510px;
}

#rightSide #right_zzim {
	position: fixed;
	top: 126px;
	left: 50%;
	margin-left: 510px;
	border: 1px solid #B0B5BD;
	width: 114px;
	height: 543px;
}

#rightSide #right_zzim  div {
	text-align: center;
}

#rightSide #right_zzim  div.recTit {
	line-height: 1.5em;
	padding: 5px;
	color: white;
	background-color: #505A69;
}

#right_zzim #recentCnt {
	color: yellow;
}

#rightSide #right_zzim ul {
	min-height: 495px;
}

#rightSide #right_zzim  li {
	text-align: center;
	padding: 5px;
	position: relative;
}

#rightSide #right_zzim ul li img {
	border: 1px solid #ccc
}

#right_zzim .detail {
	display: none;
	position: absolute;
	top: 3px;
	right: 20px;
	xheight: 40px;
	xpadding: 15px 11px 0;
	xbackground: #404a59;
	color: #fff;
	xtext-align: left;
	white-space: nowrap;
}

#right_zzim li:hover .detail {
	display: block
}

#right_zzim li .btn_delete {
	position: absolute;
	top: 3px;
	right: -1px;
	width: 11px;
	height: 11px;
	background: url(/img/sp.png) no-repeat -193px -111px;
	text-indent: -9000px;
}

#right_zzim  #currentPage {
	color: #505A69;
	font-weight: bold
}

#right_zzim  #totalPageCount {
	color: #CBC8D2;
	font-weight: bold
}

.noData {
	color: #ccc;
	text-align: center;
	margin-top: 223px;
}

#paging {
	display:;
	position: relative;
	line-height: 1em;
}

#paging .btn_prev {
	position: absolute;
	top: 526px;
	left: 4px;
	width: 13px;
	height: 11px;
	background: url(/images/ico_arrow.png)  no-repeat;
	text-indent: -9000px;
	border: 1px solid #CCC;
	display: inline-block;
}

#paging .btn_next {
	position: absolute;
	top: 526px;
	right: 4px;
	width: 13px;
	height: 11px;
	background: url(/images/ico_arrow.png) -11px 0px;
	text-indent: -9000px;
	border: 1px solid #CCC;
	display: inline-block;
}
</style>
</head>
<body>
	<div id="rightSide">
		<div id="right_zzim">
			<aside>
				<table id="recentlySee">
					<tr>
						<th class="recTit"><h4>최근 본 상품</h4></th>
					</tr>
				</table>
			</aside>
		</div>
	</div>
</body>
</html>