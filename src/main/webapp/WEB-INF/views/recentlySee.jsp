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
</head>
<body>
	aside 기능으로 하기
	<div>
		<aside>
			<table id="recentlySee">
				<tr>
					<th><h3>최근 본 상품</h3></th>
				</tr>
			</table>
		</aside>
	</div>
</body>
</html>