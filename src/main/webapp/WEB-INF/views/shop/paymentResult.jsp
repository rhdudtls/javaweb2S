<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>paymentResult.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
    <link rel="stylesheet" href="${ctp}/css/shop.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<style>
		.col-3 {
			height: 55px;
			margin-top:0px !important;
		}

		#admin > font{
			display: none;
		}
		.mainText {
			font-size: 25px;
			font-weight: bold;
		}
		.topInfo {
			width: 100%;
			height: 200px;
			text-align: center;
			background-color: #eee;
			border-bottom: 1px solid lightgray;
		}
		th {
			color:gray !important;
			width: 15%;
			background-color: #eee;
		}
		.bottomInfo {
			background-color: #eee;
		}
		.btn-red-border {
			border-color: #fc2020 !important;
		    color: #fc2020 !important;
		    border-radius: 0px !important;
		    width:180px !important;
		    height:50px !important;
		    
		}
		.btn-gray-border {
			border-color: #9DB2BF !important;
		    color: black !important;
		    border-radius: 0px !important;
		    width:180px !important;
		    height:50px !important;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<div class="container">
	<div class="mt-4 text-center">
		<span style="font-size:25px;"><b>주문완료</b></span>
	</div>
	<hr style="border:1px solid black; margin-bottom:0px;"/>
	<c:set var="now" value="<%=new java.util.Date()%>" />
	<div class="topInfo">
		<div class="pt-4 mainText">고객님의 주문이 완료 되었습니다.</div>
		<div>주문내역 및 배송에 관한 안내는 <a href="#"><font color="red"><u>주문조회</u></font></a>를 통하여 확인 가능합니다.</div>
		<c:forEach var="vo" items="${orderVOS}" begin="0" end="0">
			<div class="pt-3"><font size="4">주문번호 : ${vo.orderIdx}</font></div>
		</c:forEach>
		<div><font size="4">주문일자 : <fmt:formatDate value="${now}" pattern="yyyy-MM-dd hh:mm:ss" /></font></div>
	</div>
	<div class="mt-5"><b>결제정보</b></div>
	<hr style="border:1px solid lightgray; margin-top:0px; margin-bottom:0px"/>
	<table class="table table-bordered">
		<tr>
			<th>최종결제금액</th>
			<td><font color="red"><b>${sPayMentVO.amount}</b>원</font></td>
		</tr>
		<tr>
			<th>결제수단</th>
			<td><b>${sPayMentVO.payment}</b></td>
		</tr>
		<tr>
			<th>결제 고유ID</th>
			<td><b>${sPayMentVO.imp_uid}</b></td>
		</tr>
		<tr>
			<th>결제 상점 거래 ID</th>
			<td><b>${sPayMentVO.merchant_uid}</b></td>
		</tr>
		<tr>
			<th>카드 승인번호</th>
			<td><b>${sPayMentVO.apply_num}</b></td>
		</tr>
	</table>
	<div class="mt-5"><b>주문 상품 정보</b></div>
	<hr style="border:1px solid lightgray; margin-top:0px; margin-bottom:0px"/>
	<table class="table table-bordered">
		<tr class="text-center">
			<th style="width:15%;">이미지</th>
			<th style="width:40%;">상품정보</th>
			<th style="width:15%;">판매가</th>
			<th style="width:15%;">수량</th>
			<th style="width:15%;">합계</th>
		</tr>
		<c:forEach var="vo" items="${orderVOS}" varStatus="st">
			<tr class="text-center">
				<td class="pl-3">
					<img src="${ctp}/data/shop/product/${vo.thumbImg}" width="100px;" style="float:left"/>
				</td>
				<td>
					<div>${vo.productName}</div>
					<div><font color="gray">[옵션: ${vo.optionName}<c:if test="${vo.optionPrice != 0}">(+<fmt:formatNumber value="${vo.optionPrice}"/>)</c:if>]</font></div>
				</td>
				<td><b><fmt:formatNumber value="${vo.price}"/>원</b></td>
				<td>${vo.optionNum}</td>
				<td><b><fmt:formatNumber value="${vo.totalPrice}"/>원</b></td>
			</tr>
		</c:forEach>
		<tr class="bottomInfo" style="border-bottom:1px solid #9DB2BF;">
			<td colspan="5">[기본배송]</td>
		</tr>
	</table>
	<div class="mt-5"><b>배송지정보</b></div>
	<hr style="border:1px solid lightgray; margin-top:0px; margin-bottom:0px"/>
	<table class="table table-bordered">
		<tr>
			<th>받으시는분</th>
			<td><b>${sPayMentVO.buyer_name}</b></td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td><b>${sPayMentVO.buyer_postcode}</b></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><b>${sPayMentVO.buyer_addr}</b></td>
		</tr>
		<tr>
			<th>휴대전화</th>
			<td><b>${sPayMentVO.buyer_tel}</b></td>
		</tr>
		<tr>
			<th>배송메시지</th>
			<td><b>${sPayMentVO.message}</b></td>
		</tr>
	</table>
	<div class="mt-5 text-center">
		<input type="button" value="쇼핑계속하기" class="btn btn-gray-border"/>
		<input type="button" value="주문확인" class="btn btn-red-border"/>
	</div>
</div>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>