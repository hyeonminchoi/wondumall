<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title></title>

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

    </head>
	<body>
		<!-- HEADER -->
		<header>
			<c:import url="./header.jsp"></c:import>
		</header>
		<!-- /HEADER -->

		<!-- NAVIGATION -->
		<nav id="navigation">
			<c:import url="./nav.jsp"></c:import>
		</nav>
		<!-- /NAVIGATION -->

		<!-- BREADCRUMB -->
		<div id="breadcrumb" class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<div class="col-md-12">
						<h3 class="breadcrumb-header">결제주문</h3>
						<ul class="breadcrumb-tree">
							<li><a href="./">Home</a></li>
							<li class="active">Checkout</li>
						</ul>
					</div>
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /BREADCRUMB -->

		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">

					<div class="col-md-7">
						<!-- Billing Details -->
						<div class="billing-details">
							<div class="section-title">
								<h3 class="title">청구지</h3>
							</div>
							<div class="form-group">
								<input class="input" type="text" id="o_name" name="o_name" placeholder="이름">
								<input class="input" type="hidden" id="u_no" name="u_no" value="${user.u_no }">
							</div>
							<div class="form-group">
								<input class="input" type="text" id="o_email" name="o_email" placeholder="이메일">
							</div>
							<div class="form-group">
								<input class="input" type="text" id="o_postcode" name="o_postcode" placeholder="우편번호">
								<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="primary-btn">
							</div>
							<div class="form-group">
								<input class="input" type="text" id="o_roadAddress" name="o_roadAddress" placeholder="도로명주소">
							</div>
							<div class="form-group">
								<input class="input" type="text" id="o_extraAddress" name="o_extraAddress" placeholder="참고항목">
							</div>
							<div class="form-group">
								<input class="input" type="text" id="o_detailAddress" name="o_detailAddress" placeholder="상세주소">
							</div>
							<div class="form-group">
								<input class="input" type="tel" id="o_tel" name="o_tel" placeholder="전화번호">
							</div>
						</div>
						<!-- /Billing Details -->

						<!-- Order notes -->
						<div class="order-notes">
							<textarea class="input" id="o_request" name="o_request" placeholder="요구사항" style="resize: none;"></textarea>
						</div>
						<!-- /Order notes -->
					</div>

					<!-- Order Details -->
					<div class="col-md-5 order-details">
						<div class="section-title text-center">
							<h3 class="title">주문</h3>
						</div>
						<div class="order-summary">

							<div class="order-products">
								<div class="order-col">
									<table class="table" style="width:90%; margin: 0 auto;">
										<tr>
											<th>제품</th>
											<th>개수</th>
											<th>금액</th>
										</tr>
										<c:set var="total" value="0"/>
										<c:set var="cnttotal" value="0"/>
										<c:set var="p_name" value=""/>
										<c:forEach items="${cart }" var="ct">
										<c:set var="p_name" value="${ct.p_name }"/>
											<tr>
												<td>
												${ct.p_name }
												</td>
												<td>${ct.p_count }</td>
												<td>
													<c:set var="cnttotal" value="${ct.p_price * ct.p_count }"/>
													<c:out value="${cnttotal }"/>
												</td>
											</tr>
											<c:set var="total" value="${total + cnttotal }"/>
										</c:forEach>
										<tr>
											<th>총 금액</th>
											<td> : </td>
											<td>
											<label id="total"><c:out value="${total }"/></label>
											</td>
										</tr>
									</table>
								</div>
							</div>
							<div class="order-col">
								<div>배송</div>
								<div><strong>FREE</strong></div>
							</div>
							<div class="order-col">
								<div>쿠폰</div>
								<div>
								<select name="coupon" id="coupon">
									<option value="">전체</option>
									<c:forEach items="${couponList }" var="cl">
										<option value="${cl.coupon_per }">${cl.coupon_description } / ${cl.coupon_minorder }</option>
									</c:forEach>
								</select>
								</div>
							</div>
						</div>
						
						<div class="input-checkbox">
							<input type="checkbox" id="terms" onclick="checkBox()">
							<label for="terms">
								<span></span>
								결제를 하시겠습니까?
							</label>
						</div>
						<button onclick="iamport()" class="primary-btn order-submit" id="payment" disabled="disabled">결제</button>
					</div>
					<!-- /Order Details -->
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->
		<!-- FOOTER -->
		<footer id="footer">
			<c:import url="./footer.jsp"></c:import>
		</footer>
		<!-- /FOOTER -->

		<!-- jQuery Plugins -->
		<script src="./js/jquery.min.js"></script>
		<script src="./js/bootstrap.min.js"></script>
		<script src="./js/slick.min.js"></script>
		<script src="./js/nouislider.min.js"></script>
		<script src="./js/jquery.zoom.min.js"></script>
		<script src="./js/main.js"></script>
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
<script type="text/javascript">
$("#coupon").change(function(){
	if($("#coupon").val()== 0){
		 var originalPrice = ${total};
		 $("#total").text(Math.ceil(originalPrice));
	 } else {
		 var originalPrice = ${total};
		 var coupon_per = $("#coupon").val();
		 var discountPrice = ${total} * coupon_per;
		 var finalPrice = originalPrice-discountPrice;
		 $("#total").text(Math.ceil(finalPrice));
	 } 
});
function checkBox(){
	if($('#terms').is(':checked')){
		$('#payment').attr("disabled",false);
	} else{
		$('#payment').attr("disabled",true);
	}
}
function iamport(){
	var p_name = '${p_name}';
	var price = $("#total").text();
	var email = $("#o_email").val();
	var o_name = $("#o_name").val();
	var roadAddress = $("#o_roadAddress").val();
	var extraAddress = $("#o_extraAddress").val();
	var detailAddress = $("#o_detailAddress").val();
	var postcode = $("#o_postcode").val();
	var tel = $("#o_tel").val();
	var request = $("#o_request").val();
	var u_no = $("#u_no").val();
	
	//가맹점 식별코드
	IMP.init('imp56561187');
	IMP.request_pay({
	    pg : 'kg',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : p_name , //결제창에서 보여질 이름
	    amount : price, //실제 결제되는 가격
	    buyer_email : email,
	    buyer_name : o_name,
	    buyer_tel : tel,
	    buyer_addr : roadAddress,
	    buyer_postcode : postcode
	}, function(rsp) {
		console.log(rsp);
		// 결제검증
		$.ajax({
        	type : "POST",
        	url : "./verifyIamport/" + rsp.imp_uid,
        	data : {
        		"o_email" : email,
        		"o_name" : o_name,
        		"o_roadAddress" : roadAddress,
        		"o_postcode" : postcode,
        		"o_extraAddress" : extraAddress,
        		"o_detailAddress" : detailAddress,
        		"o_tel" : tel,
        		"o_request" : request,
        		"merchant_uid" : rsp.merchant_uid,
        		"u_no" : u_no,
        		"o_pname" : p_name,
        		"o_price" : price
        	}
        }).done(function(data) {
        	
        	console.log(data);
        	
        	// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
        	if(rsp.paid_amount == data.response.amount){
	        	alert("결제 및 결제검증완료");
	        	location.href = "./paysuccess.do";
        	} else {
        		alert("결제 실패");
        		location.href = "./payfailure.do";
        	}
        });
	});
}

function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('o_postcode').value = data.zonecode;
            document.getElementById("o_roadAddress").value = roadAddr;
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("o_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("o_extraAddress").value = '';
            }

        }
    }).open();
}
</script>
	</body>
</html>
