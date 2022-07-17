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
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

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
.navbar-nav{
	flex-direction: inherit;
}
#chattingDiv{
	width: 80%;
	height: 500px;
}
#messageHeader{
	height: 10%;
	text-align: center;
	font-weight: bold;
	font-size: 2em;
	border-bottom: 1px solid black;
	line-height: 200%;
}
#message{
	height: 80%;
	overflow: auto;
}
#messageInput{
	height: 10%;
}
#chat{
	font-size: 1vw;
	height: 100%;
}
#userList{
	overflow: auto;
	height: 100%;
}
#userInfo{
	font-size: 1vw;
	margin: 10px 0px;
}
#chattingBox{
	height: 100%;
}
</style>
<script type="text/javascript">
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
	<section>
		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<sec:authorize access="authenticated">
					<!-- 채팅 컨테이너 -->
					<div class="row rounded-lg overflow-hidden shadow" id="chattingDiv">
						<!-- 채팅방 목록 -->
						<div class="col-5 px-0">
							<div class="bg-white">
							    <div class="bg-gray px-4 py-2 bg-light">
							      	<p class="h5 mb-0 py-1">User List</p>
							    </div>
								<div class="messages-box">
						      		<div class="list-group rounded-0" id="userList">
						      		<%-- 채팅방 동적 생성 --%>
					      			</div>
						    	</div>
					  		</div>
						</div>
						<!-- 채팅방 목록 -->
						
						<!-- 채팅창 -->
						<div class="col-7 px-0" id="chattingBox">
							<div id="messageHeader"></div>
							<div class="px-4 pt-5 chat-box bg-white" id="message">
							<%-- 메세지 동적 생성 --%>
							</div>
							<!-- 메세지 입력 창 -->
				        	<div class="input-group" id="messageInput">
					          	<input type="text" id="chat" placeholder="메세지를 입력하세요." class="form-control rounded-0 border-0 py-4 bg-light">
					          	<div class="input-group-append">
					            	<button type="button" class="btn btn-link bg-white" id="sendBtn" onclick="send();">
					            		<i class="fa fa-paper-plane"></i>
					            	</button>
					          	</div>
				        	</div>
							<!-- 메세지 입력 창 -->
				    	</div>
						<!-- 채팅창 -->
					</div>
					<!-- 채팅 컨테이너 -->
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
		
		function onOpen(){
			let list = JSON.parse(ajaxForHTML('./userList.do'));
			let temp = '';
			if('${sessionScope.user.authorities}' == '[ROLE_ADMIN]' || '${sessionScope.user.authorities}' == '[ROLE_BUSINESS]'){
				for(let i=0;i<list.length;i++){
					temp += "<div id='userInfo' onclick='changeRoom(" + list[i].user_no + ",\"" + list[i].user_nickname + "\")'>";
					temp += list[i].user_nickname
					if(list[i].room_count>0)
						temp += "<small style='color:red; float:right;'>" + list[i].room_count + "</small>";
					temp += "</div>";
				}
			} else{
				for(let i=0;i<list.length;i++){
					temp += "<div id='userInfo' onclick='changeRoom(" + list[i].admin_no + ",\"" + list[i].admin_nickname + "\")'>"; 
					temp += list[i].admin_nickname;
					if(list[i].room_count<0)
						temp += "<small style='color:red; float:right;'>" + (list[i].room_count * -1) + "</small>";
					temp += "</div>";
				}
			}
			$('#userList').html(temp);	
		}
		
		function send(){
			let message = $('#chat').val();
			data = {
					"message" : message,
					"from" : $('#messageHeader').text()
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
					temp += '<div style="clear:both; float: right; margin-bottom: 10px;">'
					temp += '<h3 style="display:inline-block;">' + list[i].chat_msg + '</h3>'
					temp += '<small>' + list[i].chat_date + '</small>'
					temp += '</div>'
				} else{ //상대방이 쓴 메시지
					temp += '<div style="clear:both; margin-bottom: 10px;">'
					temp += '<h3 style="display:inline-block;">' + list[i].chat_msg + '</h3>'
					temp += '<small>' + list[i].chat_date + '</small>'
					temp += '</div>'
				}
			}
			$('#message').html(temp);
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
				temp += '<div style="clear:both; margin-bottom: 10px;">'
				temp += '<h3 style="display:inline-block;">' + arr[1] + '</h3>'
				temp += '<small>' + arr[2] + '</small>'
				temp += '</div>'
				$('#message').append(temp);
			}
		}
	    
		function onError(error){
			
		}
		
		function onClose(){
			
		}
	</script>
</sec:authorize>
</body>
</html>
