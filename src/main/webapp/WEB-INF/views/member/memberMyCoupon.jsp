<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/mydak.css">
	<title>myPageCoupon</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.gear {
			height: 55px;
			margin-top:0px !important;
		}
		#admin > font{
			display: none;
		}
		.btn:active, .btn:focus {
			outline:none !important;
			box-shadow:none !important;
		}
		.detail:hover {
			text-decoration: none;
			color:black;
		}
		.pageTitle {
			font-size: 25px;
			font-weight: bold;
		}
		
		.searchDemo {
			width:100%;
			height:100px;
			border-top: 1px solid lightgray;
			border-bottom: 1px solid lightgray;
			background-color: #eee;
		}
		
		.searchDemo select {
			width:110px;
		    height: 39px;
		    border: 1px solid #d5d5d5;
		    outline: none;
		}
		
		.searchDemo input {
			width:250px;
		    height: 39px;
		    border: 1px solid #d5d5d5;
		    outline: none;
		}
		
		.btn-black {
			margin-top: -3px !important;
			width:120px !important;
			height: 39px !important;
			border-color: #333 !important;
		    color: #fff !important;
		    font-weight: bold !important;
		    background: #333 !important;
		    border-radius: 0px !important;
		}
		th {
			background-color: #eee;
		}
		
		th, td {
			border-bottom: 1px solid lightgray !important;
		}
		
		.mypageMenu:hover {
			text-decoration: none;
			color: #333;
		}
	</style>
	<script>
		'use strict';
		
		function getCoupon() {
			let number = couponForm.number.value;
			let numberReg = /^[0-9]{10,12}$/;
			
			if(number.trim() == "") {
				alert("쿠폰 번호를 입력하세요!");
				return false;
			}
			else if(!numberReg.test(number)){
				alert("10~12자리의 '숫자'로 입력하세요.");
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/member/CouponGet",
				data : {number : number},
				success : function(res) {
					if(res == "1"){
						alert("쿠폰이 지급되었습니다.");
						location.reload();
					}
					else if(res == "2") alert("이미 발급받은 쿠폰입니다.");
					else alert("쿠폰 번호를 다시 확인하세요.");
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<div class="container">
	<div class="mt-5 myPage">마이페이지</div>
	<div class="row">
		<div class="col-3 mt-2">
			<a href="${ctp}/member/memberMyOrder" class="mypageMenu myMenu">주문내역조회</a>
			<a href="${ctp}/member/memberMyLike" class="mypageMenu myMenu">관심상품</a>
			<div class="myMenu">적립금</div>
			<a href="${ctp}/member/memberMyCoupon" class="mypageMenu myMenu myMenuOn">쿠폰</a>
			<div class="myMenu">1:1문의</div>
			<div class="myMenu">나의 게시물</div>
			<div class="myMenu">멤버십 혜택</div>
			<div class="myMenu">개인정보수정</div>
		</div>
		<div class="col-9">
			<form name="couponForm">
				<div class="pageTitle">쿠폰</div>
				<div class="pt-4 searchDemo text-center">
					<span><input type="text" name="number" id="number" /></span>
					<span><input type="button" onclick="getCoupon()" value="쿠폰 등록" class="btn btn-black"/></span>
					<div><font size="2">반드시 쇼핑몰에서 발행한 쿠폰번호만 입력해주세요. (10~12자 일련번호 "-" 제외)</font></div>
				</div>
			</form>
			<hr style="border:1px solid black; margin:30px 0 0 0;"/>
			<table class="table table-borderless">
				<tr class="text-center">
					<th>번호</th>
					<th>쿠폰명</th>
					<th>최소주문금액</th>
					<th>쿠폰 혜택</th>
					<th>사용가능기간</th>
				</tr>
				<c:forEach var="vo" items="${couponVOS}" varStatus="st">
					<tr class="text-center">
						<td>${st.count}</td>
						<td>${vo.name}</td>
						<td><fmt:formatNumber value="${vo.use_min_price}"/>원</td>
						<td>${vo.content}</td>
						<td style="width: 30%">${fn:substring(vo.getTime,0,16)} ~ ${fn:substring(vo.deadline,0,16)}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>