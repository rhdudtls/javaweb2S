<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/mydak.css">
	<title>title</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.gear {
			height: 55px;
			margin-top:0px !important;
		}
		#admin > font{
			display: none;
		}
		.adminImg {
			margin-top: -10px;
		}
		.levelImg {
			padding-top: 15px;
		}
		.level {
			width: 55%;
		}
		
		.point, .coupon, .cart {
			width: 15%;
		}
		.point i, .coupon i, .cart i {
			margin-top: 25px;
		}
		
		.mypageMenu:hover {
			text-decoration: none;
			color: #333;
		}
		.myOrder {
			margin-left: -20px;
		}
		.orderList {
			margin-left: -5px;
			width: 50%;
			height: 51px;
			border: 2px solid black;
			border-bottom: none !important;
			text-align: center;
			line-height: 50px;
			font-size: 16px;
		}
		.orderListOff {
			width: 50%;
			height: 51px;
			border : 1px solid lightgray;
			border-bottom: 2px solid black !important;
			text-align: center;
			line-height: 50px;
			font-size: 16px;
			color: lightgray;
		}
		.category {
			margin-left: -20px;
			margin-right: -100px;
			height: 51px;
			border: 1px solid lightgray;
			background-color: #eee;
			width: 855px;
		}
		.stselect {
			width: 15%;
		    height: 35px;
		    padding-left:10px;
		    border: 1px solid #e1e1e1;
			border-bottom: 1px solid #e1e1e1;
			box-sizing: border-box;
			outline:none;
		}
		.day {
			display: inline-block;
			width: 50px;
			height: 35px;
			border : 1px solid lightgray;
			text-align: center;
			line-height: 35px;
			background-color: #DDDDDD;
		}
		.day:hover {
			text-decoration: none;
			color: black;
		}
		.stinput {
			padding: 0 15px;
			font-size:13px;
		    width: 16%;
		    height: 35px;
		    border: 1px solid #e1e1e1;
			border-bottom: 1px solid #e1e1e1;
			box-sizing: border-box;
			outline:none;
		}
		.btn-black {
			margin-top: -3px !important;
			width:80px !important;
			height: 39px !important;
			border-color: #333 !important;
		    color: #fff !important;
		    font-weight: bold !important;
		    background: #333 !important;
		    border-radius: 0px !important;
		}
		.notice {
			margin: 5px 0 0 -35px;
			color:gray;
			font-size: 13px;
		}
		th {
			background-color: #eee;
			border-bottom: 1px solid lightgray !important;
		}
		table {
			margin-left:-20px;
			width: 853px !important;
		}
		td {
			border-bottom: 1px solid lightgray !important;
		}
	</style>
	<script>
		'use strict';
		
		function delivery() {
			let part = myform.part.value;
			let startDate = myform.startDate.value;
			let lastDate = myform.lastDate.value;
			
			myform.submit();
		}
		
		function changeDay(day) {
			let today = new Date;
			let sDate;
			if(day == 1) {
				sDate = today;
			}
			else if(day == 7) {
				sDate = new Date(today.setDate(today.getDate() - 7));
			}
			else if(day == 30) {
				sDate = new Date(today.setDate(today.getDate() - 30));
			}
			else if(day == 90) {
				sDate = new Date(today.setDate(today.getDate() - 90));
			}
			else {
				sDate = new Date(today.setDate(today.getDate() - 180));
			}
			myform.startDate.value = sDate.toISOString().substring(0,10);
			today = new Date;
			myform.lastDate.value = today.toISOString().substring(0,10);
			
			delivery();
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
			<a href="${ctp}/member/memberMyOrder" class="mypageMenu myMenu myMenuOn">주문내역조회</a>
			<a href="${ctp}/member/memberMyLike" class="mypageMenu myMenu">관심상품</a>
			<div class="myMenu">적립금</div>
			<a href="${ctp}/member/memberMyCoupon" class="mypageMenu myMenu">쿠폰</a>
			<div class="myMenu">1:1문의</div>
			<div class="myMenu">나의 게시물</div>
			<div class="myMenu">멤버십 혜택</div>
			<div class="myMenu">개인정보수정</div>
		</div>
		<div class="col-9">
			<table class="table table-bordered topInfo">
				<tr>
					<td class="level">
						<c:if test="${sLevel == 0}"><img src="${ctp}/images/admin.png" width="37%" class="adminImg"/></c:if>
						<c:if test="${sLevel == 1}"><img src="${ctp}/images/bronze.png" class="ml-2 mt-4 mr-1"/></c:if>
						<c:if test="${sLevel == 2}"><img src="${ctp}/images/sliver.png" class="ml-2 mt-4 mr-1"/></c:if>
						<c:if test="${sLevel == 3}"><img src="${ctp}/images/gold.png" class="ml-2 mt-4"/></c:if>
						<span><font size="4"><b>${memVO.name}</b></font><font size="3">님의 등급은 <c:if test="${sLevel == 0}">${strLevel}</c:if><c:if test="${sLevel != 0}"><font color="${strLevel}">${strLevel}</font></c:if>입니다.</font></span>
					</td>
					<td class="point text-center">
						<i class="fa-solid fa-coins fa-3x" style="color: #c6cad2;"></i>
						<div><font color="gray" size="3">적립금</font></div>
						<div><b><font size="4" color="red"><fmt:formatNumber value="${memVO.point}"/></font>원</b></div>
					</td>
					<td class="coupon text-center">
						<i class="fa-solid fa-ticket fa-3x" style="color: #c6cad2;"></i>
						<div><font color="gray" size="3">쿠폰</font></div>
						<div><b><font size="4" color="red">${fn:length(couponVOS)}</font>장</b></div>
					
					</td>
					<td class="cart text-center">
						<i class="fa-solid fa-basket-shopping fa-3x" style="color: #c6cad2;"></i>
						<div><font color="gray" size="3">장바구니</font></div>
						<div><b><font size="4" color="red">${fn:length(cartVOS)}</font>건</b></div>
					</td>
				</tr>
			</table>
			<div class="myOrder mt-5"><font size="5"><b>주문조회</b></font></div>
			<div class="row mt-2">
				<div class="orderList">주문내역조회</div>
				<div class="orderListOff">취소/반품/교환 내역</div>
			</div>
			<form name="myform">
				<div class="category mt-4">
					<span style="margin:0 10px 0 20px; line-height: 50px;">
						<select name="part" class="stselect" onchange="delivery(0)">
							<option value="all" <c:if test='${part == "all"}'>selected</c:if>>전체</option>
							<option value="결제완료" <c:if test='${part == "결제완료"}'>selected</c:if>>결제완료</option>
							<option value="배송준비중" <c:if test='${part == "배송준비중"}'>selected</c:if>>배송준비중</option>
							<option value="배송중" <c:if test='${part == "배송중"}'>selected</c:if>>배송중</option>
							<option value="배송완료" <c:if test='${part == "배송완료"}'>selected</c:if>>배송완료</option>
							<option value="구매확정" <c:if test='${part == "구매확정"}'>selected</c:if>>구매확정</option>
						</select>
					</span> |
					<span style="margin:0 10px 0 10px;">
						<a href="javascript:changeDay(1)" class="day">오늘</a>
						<a href="javascript:changeDay(7)" class="day">1주일</a>
						<a href="javascript:changeDay(30)" class="day">1개월</a>
						<a href="javascript:changeDay(90)" class="day">3개월</a>
						<a href="javascript:changeDay(180)" class="day">6개월</a>
					</span>
					<span>
						<c:set var="sDate" value="<%=new Date(new Date().getTime() - 60 * 60 * 24 * 1000 * 90L)%>"/>
						<fmt:formatDate value="${sDate}" pattern="yyyy-MM-dd" var="sDateFmt"/>
						<c:if test="${lastDate == ''}">
							<input type="date" name="startDate" value="${sDateFmt}" class="stinput"/> ~ 
							<input type="date" name="lastDate" value="<%=java.time.LocalDate.now() %>" class="stinput"/>
						</c:if>
						<c:if test="${lastDate != ''}">
							<input type="date" name="startDate" value="${startDate}" class="stinput"/> ~ 
							<input type="date" name="lastDate" value="${lastDate}" class="stinput"/>
						</c:if>
					</span>
					<span style="margin-left:5px;">
						<input type="button" value="조회" onclick="delivery()" class="btn btn-black"/>
					</span>
				</div>
			</form>
			<ul class="notice">
				<li>기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.</li>
				<li>주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.</li>
			</ul>
			<hr style="border:1px solid black; margin:50px 0 0 -20px; width:850px;"/>
			<table class="table table-borderless">
				<tr class="text-center">
					<th><div>주문일자</div><div>[주문번호]</div></th>
					<th>이미지</th>
					<th>상품정보</th>
					<th>수량</th>
					<th>상품구매금액</th>
					<th>주문처리상태</th>
				</tr>
				<c:if test="${fn:length(orderVOS) != 0}">
					<c:forEach var="orderVO" items="${orderVOS}" varStatus="st">
						<tr class="text-center">
							<c:if test="${orderVO.orderIdx != orderIdxCnt}">
								<td rowspan="${orderVO.cnt}" style="vertical-align:middle;">
									<div>${fn:substring(orderVO.orderDate,0,10)}</div>
									<div>[${orderVO.orderIdx}]</div>	
								</td>
							</c:if>
							<td style="vertical-align:middle;"><img src="${ctp}/data/shop/product/${orderVO.thumbImg}" width="80px"/></td>
							<td style="vertical-align:middle;">
								<div>&nbsp;&nbsp;${orderVO.productName}</div>
								<div>&nbsp;&nbsp;<font color="gray">[옵션: ${orderVO.optionName}<c:if test="${orderVO.optionPrice != 0}">(+<fmt:formatNumber value="${orderVO.optionPrice}"/>)</c:if>]</font></div>
							</td>
							<td style="vertical-align:middle;">${orderVO.optionNum}</td>
							<td style="vertical-align:middle;"><b><fmt:formatNumber value="${orderVO.totalPrice}"/>원</b></td>
							<td style="vertical-align:middle;"><font color="orange">${orderVO.orderStatus}</font></td>
						</tr>
						<c:set var="orderIdxCnt" value="${orderVO.orderIdx}"/>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(orderVOS) == 0}">
					<tr style="height: 150px;">
						<td colspan="6" class="text-center" style="vertical-align: middle;"><b>주문 내역이 없습니다.</b></td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>