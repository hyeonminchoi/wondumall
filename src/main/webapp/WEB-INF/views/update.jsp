<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>회원 정보</title>

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

<link type="text/css" rel="stylesheet" href="./css/join.css" />


</head>
<body>
	<header>
		<c:import url="/header.do"></c:import>
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<nav id="navigation">
		<c:import url="/nav.do"></c:import>
	</nav>
	<section>
		<div id="section">
			<div id="container">
				<form action="./update.do" method="post" id="join" class="joinForm">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	
					<h2>회원정보수정</h2>
					<div class="textForm">
					<p class="mypagename" >아이디</p>
						<input autocomplete="off" name="u_email" id="email" minlength="6" type="email" required="required" class="email" value="<sec:authentication property='principal.username' />" disabled="disabled"/>
					</div>
					
					<div class="textForm">
						<p class="mypagename" >이름</p>
						<input autocomplete="off" name="u_name" minlength="2" type="text" class="name" required="required" placeholder="이름" pattern="^[가-힣]{2,20}|[a-zA-Z]{2,20}\s[a-zA-Z]{2,20}$" value="<sec:authentication property='principal.name' />">
					</div>
					<div class="textForm">
					<p class="mypagename" >핸드폰번호</p>
						<input autocomplete="off" name="u_tel" type="text" minlength="10" class="name" required="required" placeholder="핸드폰번호 ( - 없이 입력)" value="<sec:authentication property='principal.tel' />">
					</div>
					
					<div class="textForm">
						<select name="u_grade" required="required" class="nickname" id="grade" onchange="gradeText()" disabled="disabled">
							<option <sec:authentication property='principal.grade' /> eq 0 ? 'checked':''>일반</option>
							<option <sec:authentication property='principal.grade' /> eq 1 ? 'checked':''>사업자</option>
						</select>
					</div>
							
					<div class="textForm">
					<p class="mypagename" >닉네임</p>
						<input autocomplete="off" name="u_nickname" type="text" id="nickname" minlength="1" required="required" class="nickname" placeholder="닉네임" oninput = "checknickname()" pattern="^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$"  value="<sec:authentication property='principal.nickname' />">
					</div>
					<!-- nickname ajax 중복체크 -->
					<span class="nickname_ok" >사용 가능한 닉네임 입니다.</span>
					<span class="nickname_already">사용중인 닉네임 입니다.</span>
					
					
					<div>
					
					<div class="textForm">
					<p class="mypagename" >주소</p>
						<input autocomplete="off" type="text" id="sample6_postcode" required="required" class="postcode"  name="u_postcode" placeholder="우편번호" type="button" onclick="sample6_execDaumPostcode()" class="postbtn" value="<sec:authentication property='principal.postcode' />">
						<!-- <input type="button" onclick="sample6_execDaumPostcode()" class="postbtn" value="우편번호 찾기"> -->
					</div> 
	
	
					<div class="textForm">
						<input autocomplete="off" type="text" id="sample6_address" required="required" class="roadAddress" name="u_roadAddress" placeholder="주소" value="<sec:authentication property='principal.roadAddress' />"><br>
					</div>
					<div class="textForm">
						<input autocomplete="off" type="text" id="sample6_detailAddress" required="required" class="detailAddress" name="u_detailAddress" placeholder="상세주소" value="<sec:authentication property='principal.detailAddress' />">
					</div>
					<div class="textForm">
						<input autocomplete="off" type="text" id="sample6_extraAddress" class="roadAddress"  name="u_extraAddress" placeholder="참고항목" value="<sec:authentication property='principal.extraAddress' />">
					</div>
	
						<script
							src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
						<script>
							function sample6_execDaumPostcode() {
								new daum.Postcode(
										{
											oncomplete : function(data) {
												// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
												// 각 주소의 노출 규칙에 따라 주소를 조합한다.
												// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
												var addr = ''; // 주소 변수
												var extraAddr = ''; // 참고항목 변수
	
												//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
												if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
													addr = data.roadAddress;
												} else { // 사용자가 지번 주소를 선택했을 경우(J)
													addr = data.jibunAddress;
												}
	
												// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
												if (data.userSelectedType === 'R') {
													// 법정동명이 있을 경우 추가한다. (법정리는 제외)
													// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
													if (data.bname !== ''
															&& /[동|로|가]$/g
																	.test(data.bname)) {
														extraAddr += data.bname;
													}
													// 건물명이 있고, 공동주택일 경우 추가한다.
													if (data.buildingName !== ''
															&& data.apartment === 'Y') {
														extraAddr += (extraAddr !== '' ? ', '
																+ data.buildingName
																: data.buildingName);
													}
													// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
													if (extraAddr !== '') {
														extraAddr = ' ('
																+ extraAddr + ')';
													}
													// 조합된 참고항목을 해당 필드에 넣는다.
													document
															.getElementById("sample6_extraAddress").value = extraAddr;
	
												} else {
													document
															.getElementById("sample6_extraAddress").value = '';
												}
	
												// 우편번호와 주소 정보를 해당 필드에 넣는다.
												document
														.getElementById('sample6_postcode').value = data.zonecode;
												document
														.getElementById("sample6_address").value = addr;
												// 커서를 상세주소 필드로 이동한다.
												document.getElementById(
														"sample6_detailAddress")
														.focus();
											}
										}).open();
							}
						</script>
	
					</div>
	
					<input type="submit"  id="joinbtn" class="btn" value="수정하기" />
				</form>
			</div>
		</div>
	
	<script type="text/javascript">
		/* 자바 스크립트 함수 선언(비밀번호 확인) */
	
		function passConfirm() {
		/* 비밀번호, 비밀번호 확인 입력창에 입력된 값을 비교해서 같다면 비밀번호 일치, 그렇지 않으면 불일치 라는 텍스트 출력.*/
		/* document : 현재 문서를 의미함. 작성되고 있는 문서를 뜻함. */
		/* getElementByID('아이디') : 아이디에 적힌 값을 가진 id의 value를 get을 해서 password 변수 넣기 */
			var password = document.getElementById('pw1');					//비밀번호 
			var passwordConfirm = document.getElementById('pw2');	//비밀번호 확인 값
			var confrimMsg = document.getElementById('confirmMsg');				//확인 메세지
			var correctColor = "#228B22";	//맞았을 때 출력되는 색깔.
			var wrongColor = "#FF00FF";	//틀렸을 때 출력되는 색깔
						
			if(password.value == passwordConfirm.value){//password 변수의 값과 passwordConfirm 변수의 값과 동일하다.
				confirmMsg.style.color = correctColor;/* span 태그의 ID(confirmMsg) 사용  */
				confirmMsg.innerHTML ="비밀번호 일치";/* innerHTML : HTML 내부에 추가적인 내용을 넣을 때 사용하는 것. */
				$('#joinbtn').attr('disabled', false);
			}else{
				confirmMsg.style.color = wrongColor;
				confirmMsg.innerHTML ="비밀번호 불일치";
				$('#joinbtn').attr('disabled', true);
			}
		}
		
		/*  function passlength() {
			
		 	var pattern1 = /[0-9]/; //숫자
			var pattern2 = /[a-zA-Z]/; //문자
			var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; //특수문자                   
			var armColor = "#191970"
			
			if(!pattern1.test() || !pattern2.test() || !pattern3.test() || str.lenghth < 8) {
				
				return false;
			}else{
				confirmMsg2.style.color = armColor;
				confirmMsg2.innerHTML ="비밀번호는 8자리 이상 문자,숫자,특수문자로 구성하여야 합니다.";
				return true;
		}
		} */
		
		 function checkemail(){
			
		     var id = $('#email').val(); //id값이 "id"인 입력란의 값을 저장
		        $.ajax({
		            url:'./emailCheck', //Controller에서 요청 받을 주소
		            type:'post', //POST 방식으로 전달
		            data:{email:id},
		            success:function(result){ //컨트롤러에서 넘어온 cnt값을 받는다 
		                if(result == 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
		                    $('.email_ok').css("display","inline-block"); 
		                    $('.email_already').css("display", "none");
		                    $('#joinbtn').attr('disabled', false);
		                } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
		                    $('.email_already').css("display","inline-block");
		                    $('.email_ok').css("display", "none");
		                    $('#emailchk').val('');
		                    $('#joinbtn').attr('disabled', true);
		                }
		            },
		            error:function(){
		                alert("에러입니다");
		            }
		        });
		        }; 
		        
		        function checknickname(){
			        var id = $('#nickname').val(); //id값이 "id"인 입력란의 값을 저장
			        $.ajax({
			            url:'./nicknameCheck', //Controller에서 요청 받을 주소
			            type:'post', //POST 방식으로 전달
			            data:{nickname:id},
			            success:function(result){ //컨트롤러에서 넘어온 cnt값을 받는다 
			                if(result == 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
			                    $('.nickname_ok').css("display","inline-block"); 
			                    $('.nickname_already').css("display", "none");
			                    $('#joinbtn').attr('disabled', false);
			                } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
			                    $('.nickname_already').css("display","inline-block");
			                    $('.nickname_ok').css("display", "none");
			                    $('#nicknamechk').val('');
			                    $('#joinbtn').attr('disabled', true);
			                }
			            },
			            error:function(){
			                alert("에러입니다");
			            }
			        });
			        };
			        
			        function gradeText(){
				        var grade = $('#grade').val(); //id값이 "id"인 입력란의 값을 저장
				        if(grade==0){
				        	$('.company').css("display", "none");
				        	$('.normal').css("display", "inline-block");
				        } else if(grade==1){
				        	$('.company').css("display", "inline-block");
				        	$('.normal').css("display", "none");
				        }
				        };
	</script>
	
	
	
	
	
	
	
	
	

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