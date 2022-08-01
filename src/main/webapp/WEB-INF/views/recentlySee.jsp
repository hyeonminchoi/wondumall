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
				tr += "<tr onclick=\"location.href='./productDetail.do?p_no=" + result[i].p_no + "'\">";
				tr += "<td>";
				tr += "<img src='./productUpload/" + result[i].p_img + "'>"
				tr += "<br>";
				tr += result[i].p_name;
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
#cont {
	position: fixed;
	left: 50%;
	height: 0px;
}

#float_layer {
	margin-top: 70px;
	margin-left: 650px;
	text-align: center;
}

.xans-layout-productrecent {
	border: 1px solid #d5d5d5;
	/* border-top:0; */
	text-align: center;
	background: #fff;
}
.xans-layout-productrecent h2 a {
	display: block;
	height: 30px;
	line-height: 30px;
	font-size: 12px;
	font-weight: normal;
	color: #2e2e2e;
}
.xans-layout-productrecent tr {
	width: 76px;
	margin: 0 auto 10px;
}
.xans-layout-productrecent td a {
	color: #2e2e2e;
	font-size: 11px;
}
.xans-layout-productrecent td img {
	max-width: 76px;
}
.xans-layout-productrecent td span {
	display: block;
	padding: 2px 0;
	line-height: 16px;
}
.xans-layout-productrecent .player {
	overflow: hidden;
	*zoom: 1;
}
.xans-layout-productrecent .player img {
	float: left;
}
tr{
	border: 1px solid #ddd;
}
table {
	width: 150px;
}
.type_list{
	width: 1000px;
    margin: auto;
}
img {
	cursor: pointer;
}
</style>
</head>
<body>
	<div id="cont">
		<div id="float_layer">
			<div class="xans-layout-productrecent">
				<table id="recentlySee">
					<tr>
						<th class="recTit"><h4 style="text-align: center; margin-top: 14px;">최근 본 상품</h4></th>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>