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

<style>
table{
	margin: 0 auto;
	height:500px;
	width: 100%;
	table-layout: fixed;
}
th{
	text-align: center;
	font-size: xx-large;
}
tr:nth-child(1){
	height: 10%;
	border-bottom: 1px double gray;
}
tr:nth-child(3) {
	height: 10%;
}
tr:nth-child(2) {
	height: 80%;
}
td:nth-child(1), th:nth-child(1){
	width: 40%;
}
td:nth-child(2), th:nth-child(2){
	width: 60%;
}
#message{
	height: 100%;
	overflow: auto;
}
#message div{
	border: 1px solid gray;
	border-radius: 10px;
	padding: 5px;
}
#userList{
	height: 100%;
	overflow: auto;
}
h3{
	white-space: pre-wrap;
	word-break:break-word;
}
#userInfo{
	border: 1px solid gray;
	border-radius: 10px;
	margin-bottom: 30px;
	padding: 0px 50px;
	height: 50px;
	line-height: 50px;
}
input{
	width: 90%;
}
button{
	width: 10%;
	float: right;
}
</style>
<script type="text/javascript">
</script>
</head>
<body>
	<!-- HEADER -->
	<header>
		<c:import url="/header.do"></c:import>
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
				<sec:authorize access="authenticated">
					<table class="table table-bordered">
						<tr>
							<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_BUSINESS')">
								<th>사용자 리스트</th>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_USER')">
								<th>관리자 리스트</th>
							</sec:authorize>
							<th id="messageHeader"></th>
						</tr>
						<tr>
							<td><div id="userList"></div></td>
							<td><div id="message"></div></td>
						</tr>
						<tr>
							<td>
								<input type="text" id="search">
								<button type="button" onclick="search()">
									<i class="fa fa-search" aria-hidden="true"></i>
								</button>
							</td>
							<td>
								<input type="text" id="chat">
								<button type="button" onclick="send()">
									<i class="fa fa-paper-plane-o" aria-hidden="true"></i>
								</button>
							</td>
						</tr>
					</table>
				</sec:authorize>
				
				
				<sec:authorize access="not authenticated">
					<button type="button" onclick="location.href='./login.do'">로그인</button>
				</sec:authorize>
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
	
<sec:authorize access="authenticated">
	<script>
		$(function(){
			if(${not empty sessionScope.user}){
				connect();
				proc = setInterval(onOpen, 1000);
			}	
		})
		
		let webSocket;
		
		function ajaxForHTML(url, data, contentType){
			let htmlData;
			$.ajax({
			    url : url,
			    data: data,
			    contentType: contentType,
			    type:"POST",
			    dataType: "html",
			    async: false,
			    success:function(data){
			    	htmlData = data;
			    },
			    error:function(jqxhr, textStatus, errorThrown){
			       alert("ajax 처리 실패");
			    }
			});
			
			return htmlData;
		}
		
		function connect(){
			var URI = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chat";
			webSocket = new WebSocket(URI);
			webSocket.onopen = onOpen;
			webSocket.onmessage = onMessage;
			webSocket.onerror = onError;
			webSocket.onclose = onClose;
		}
		
		function onOpen(search){
			let list = '';
			if(search != undefined && search!=event && search!=''){
				console.log(search);
				let data={
						"search":search
				};
				list = JSON.parse(ajaxForHTML('./userList.do', JSON.stringify(data), "application/json"));
			} else{
				list = JSON.parse(ajaxForHTML('./userList.do'));
			}
			let temp = '';
			if('${sessionScope.user.authorities}' == '[ROLE_ADMIN]' || '${sessionScope.user.authorities}' == '[ROLE_BUSINESS]'){
				for(let i=0;i<list.length;i++){
					temp += "<div id='userInfo' onclick='changeRoom(" + list[i].user_no + ",\"" + list[i].user_nickname + "\")'>";
					temp += "<strong>" + list[i].user_nickname + "</strong>";
					if(list[i].room_count>0)
						temp += "<small style='color:red; float:right;'>" + list[i].room_count + "</small>";
					temp += "</div>";
				}
			} else{
				for(let i=0;i<list.length;i++){
					temp += "<div id='userInfo' onclick='changeRoom(" + list[i].admin_no + ",\"" + list[i].admin_nickname + "\")'>"; 
					temp += "<strong>" + list[i].admin_nickname + "</strong>";
					if(list[i].room_count<0)
						temp += "<small style='color:red; float:right;'>" + (list[i].room_count * -1) + "</small>";
					temp += "</div>";
				}
			}
			$('#userList').html(temp);	
		}
		
		function search(){
			let search=$('#search').val();
			clearInterval(proc);
			proc = setInterval(onOpen, 1000, search);
		}
		
		// 엔터로 검색
		$(document).on('keydown', '#search', function(e){
	        if(e.keyCode == 13 && !e.shiftKey) {
	        	search();
	        }
	   	});
		
		function send(){
			let message = $('#chat').val().replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
			data = {
					"message" : message,
					"from" : $('#messageHeader').text()
			}
			var today = new Date();
		    today.setHours(today.getHours() + 9);
			if($('#messageHeader').text() != '' && message != ''){
				let temp = '';
				temp += '<div style="clear:both; float: right; margin-bottom: 10px; width: 50%;">'
				temp += '<h3>' + message + '</h3>'
				temp += '<small>' + today.toISOString().replace('T', ' ').substring(0, 19) + '</small>'
				temp += '</div>'
				$('#message').append(temp);
				$('#message').scrollTop($('#message')[0].scrollHeight);
			}
			let jsonData = JSON.stringify(data);
			webSocket.send(jsonData);
			$('#chat').val("");
		}
		
		function changeRoom(no, nickname){
			let data = {
					"from" : no, 
					"to" : ${sessionScope.user.no}
			}
			let list = JSON.parse(ajaxForHTML('./changeRoom.do', JSON.stringify(data), "application/json"));
			
			let temp = '';
			for(let i=0;i<list.length;i++){
				if(list[i].u_no == ${sessionScope.user.no}){ //내가 쓴 메시지
					temp += '<div style="clear:both; float: right; margin-bottom: 10px; width: 50%;">'
					temp += '<h3>' + list[i].chat_msg + '</h3>'
					temp += '<small>' + list[i].chat_date + '</small>'
					temp += '</div>'
				} else{ //상대방이 쓴 메시지
					temp += '<div style="clear:both; margin-bottom: 10px; width: 50%;">'
					temp += '<h3>' + list[i].chat_msg + '</h3>'
					temp += '<small>' + list[i].chat_date + '</small>'
					temp += '</div>'
				}
			}
			$('#message').html(temp);
			$('#message').scrollTop($('#message')[0].scrollHeight);
			$('#messageHeader').html(nickname);
		}
		
		// 엔터로 채팅 전송
		$(document).on('keydown', '#chat', function(e){
	        if(e.keyCode == 13 && !e.shiftKey) {
	        	send('message',true);
	        }
	   	});
	
		<!-- webSocket 메세지 수신 시 -->
		function onMessage(event){	
			let arr = event.data.split(',');
			if(arr[0] == $('#messageHeader').text()){
				let temp = '';
				temp += '<div style="clear:both; margin-bottom: 10px; width: 50%;">'
				temp += '<h3>' + arr[1] + '</h3>'
				temp += '<small>' + arr[2] + '</small>'
				temp += '</div>'
				$('#message').append(temp);
				$('#message').scrollTop($('#message')[0].scrollHeight);
				
				let data = {
						"from" : arr[0], 
						"to" : ${sessionScope.user.no}
				}
				ajaxForHTML('./resetRoomCount.do', JSON.stringify(data), "application/json");
				
			}
		}
	    
		function onError(error){
			console.log("에러 발생");
			clearInterval(proc);	
		}
		
		function onClose(){
			clearInterval(proc);
		}
	</script>
</sec:authorize>
</body>
</html>
