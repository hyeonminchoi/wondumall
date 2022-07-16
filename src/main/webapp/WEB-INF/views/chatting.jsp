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
					<div class="row rounded-lg overflow-hidden shadow">
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
						<div class="col-7 px-0">
							<div class="px-4 pt-5 chat-box bg-white" id="message">
							<%-- 메세지 동적 생성 --%>
							</div>
								<!-- 메세지 입력 창 -->
					        	<div class="input-group">
						          	<input type="text" id="chat" placeholder="메세지를 입력하세요." class="form-control rounded-0 border-0 py-4 bg-light">
						          	<div class="input-group-append">
						            	<button type="button" class="btn btn-link bg-white" id="sendBtn" onclick="send('message');">
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
	
	if(webSocket === undefined && "${sessionScope.user}" !== ""){
		connect();
       	$("#userList").html(ajaxForHTML("./userList.do"));
	}
	
	function connect(){
		if(webSocket === undefined){
			var URI = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chat";
			webSocket = new WebSocket(URI);
			webSocket.onopen = onOpen;
			webSocket.onmessage = onMessage;
			webSocket.onerror = onError;
			webSocket.onclose = onClose;
		} else{
			document.getElementById("message").innerHTML+="<br/>" + "<b>이미 연결되어 있습니다!!</b>";
		}
	}
	
	function onOpen(){
		send('onLineList');
	}
	
	function send(handle, secret){
		let data = null;
		let chatMessage = document.getElementById("chat");
		if(handle === "message"){
			if(!chatMessage.value){
				return;
			}
			data = {
				"handle" : "message",
				"content" : chatMessage.value
			}
			// 1:1 채팅방의 경우 no 추가
			if(secret === true){
				data.no = no;
			}
			// 채팅 메세지 초기화
			chatMessage.value = "";
		} else if(handle === "onLineList"){
			data = {
				"handle" : "onLineList"
			}
		}
		let jsonData = JSON.stringify(data);
		webSocket.send(jsonData);
	}
	
	// 엔터로 채팅 전송
	$(document).on('keydown', '#chat', function(e){
        if(e.keyCode == 13 && !e.shiftKey) {
        	send('message',true);
        }
   	});

	<!-- webSocket 메세지 수신 시 -->
	function onMessage(evt){			
		// 수신한 메세지 (,)로 자르기
    	let receive = evt.data.split(",");
    	let data = {};
    	let count = 0;
 		
    	if(receive[0] === "message"){
            data = {
            	 "handle" : receive[0],
               	 "sender" : receive[1],
               	 "content" : receive[2],
               	 "no" : receive[3]
            }
    	} else if(receive[0] === "onLineList"){
    		data.handle = receive[0];
    		for(let i = 1; i < receive.length; i++){
    			data[count++] = receive[i];
    		}
    	}
    	
        writeResponse(data);
	}
	
	<!-- webSocket 메세지 화면에 표시해주기 -->
    function writeResponse(data){
    	if(data.handle === "message"){
        	// HTML 데이터 받기
        	let messageData = ajaxForHTML("./message.do", JSON.stringify(data), "application/json");
        	// 채팅방에 메세지 추가
        	document.getElementById("message").innerHTML += messageData;
        	
        	// 채팅방 목록에 알림 효과
        	$("#" + data.no).addClass('temp');
        	
        	// 스크롤 하단 고정
        	$('#message').scrollTop($('#message').prop('scrollHeight'));
        	
    	} else if(data.handle === "onLineList"){
    		// [유저 목록 → 나] 로그인 표시
    		for(let i = 0; i < Object.keys(data).length - 1; i++){
    			document.getElementById(data[i]).innerHTML = "로그인";
    		}
    	}
    }
    
    // 채팅창 공백
    function chatClear(){
    	document.getElementById("message").innerHTML=" ";
    }
    
    // 채팅방 입장
    function roomEnter(room){ 
    	let bb = document.getElementsByClassName('active')[0];
    	
    	// 1. 채팅방 목록 리스트 CSS 변경
    	// 활성화 되어 있는 방 클릭 시 [효과 X]
    	if($(room).hasClass("active")){
    		return;
    	}
    	if(bb !== undefined){
        	bb.classList.add('list-group-item-light');
        	bb.classList.remove('active', 'text-white');
    	}
    	
    	room.classList.add('active', 'text-white');
    	room.classList.remove('list-group-item-light');
    	
    	// 2. 현재 열려있는 채팅방 초기화
    
		// 3. secret true값으로 메세지 보내기
		// send('message', true);
    	
    	// 3. 상대방 UUID로 session 찾기 (1. 입장과 동시에 채팅방 집어넣기 or 첫 메세지 보낼 때 연결하기)
    	no = room.dataset.no;
    	
    	// 4. 메세지 보내기 onClick 이벤트 변경
    	$("#sendBtn").attr("onClick", "send('message', true)");
    }
    
	function onError(error){
		
	}
	
	function onClose(){
		
	}
</script>
</body>
</html>
