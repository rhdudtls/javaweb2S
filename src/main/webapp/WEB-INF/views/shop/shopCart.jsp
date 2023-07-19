<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<title>shopBasket.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="stylesheet" href="${ctp}/css/shop.css">
	<style>
		.col-3 {
			height: 55px;
			margin-top:0px !important;
		}

		#admin > font{
			display: none;
		}
		.btn-red-border {
			border-color: #fc2020 !important;
		    color: #fc2020 !important;
		    border-radius: 0px !important;
		    width:120px !important;
		    height:32px !important;
		    
		}
		.btn-gray-border {
			border-color: #9DB2BF !important;
		    color: black !important;
		    border-radius: 0px !important;
		    width:120px !important;
		    height:32px !important;
		    
		}
		.btn-red {
			border-color: #fc2020 !important;
			font-weight:bold !important;
		    color: #fff !important;
		    background: #fc2020 !important;
		    border-radius: 0px !important;
		    width:260px !important;
		    height:45px !important;
		}
		th {
			background-color: #eee;
		}
		
		.bottomInfo {
			background-color: #eee;
		}
		.btn-red-border-2 {
			width:190px !important;
		    height:45px !important;
		    font-weight:bold !important;
		    border-color: #fc2020 !important;
		    color: #fc2020 !important;
		    border-radius: 0px !important;
		}
		#totProductPrice, #postPrice {
			font-size: 23px;
			font-weight: bold;
			text-align: center;
		}
		
		#payPrice {
			font-size: 23px;
			font-weight: bold;
			text-align: center;
			color:red;
		}
		table {
			word-break:break-all;
			height: auto;
		}
	</style>
	<script>
		'use strict';
		
		$(function(){
			onTotal();
		}); 
		
		function ckBox() {
			var checked = $('#allCheck').is(':checked');
			
			if(checked) {
				$('input:checkbox').prop('checked',true);
			}
			else $('input:checkbox').prop('checked',false);
			
			onTotal();
		};
		
		function onTotal() {
			let total = 0;
			$('input:checkbox[name=product]').each(function (index) {
				if($(this).is(":checked")==true){
					let valArr = $(this).val().split("/");
					total = total + parseInt(valArr[1]);
			    }
			});
			$("#totProductPrice").text(total.toLocaleString() + "원");
			if(total < 30000 && total != 0) {
				$("#postPrice").text("3,000원");
				$("#payPrice").text((total+3000).toLocaleString() + "원");
			}
			else {
				$("#postPrice").text("0원");
				$("#payPrice").text(total.toLocaleString() + "원");
			}
		}
		
		function cartDeleteOne(idx) {
			let ans = confirm("선택하신 상품을 삭제하시겠습니까?");
			if(!ans) return false;
			let idxArr = [];
			idxArr.push(idx);
			$.ajax({
				type:"post",
				url :"${ctp}/shop/cartDelete",
				traditional: true,
				data : {idxArr : idxArr},
				success : function() {
					alert("상품이 삭제되었습니다.");
					location.reload();
				},
				error : function() {
					alert("전송 오류~");
				}
			});
		}
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<div class="container">
	<div class="mt-4 text-center">
		<span style="font-size:25px;"><b>장바구니</b></span>
	</div>
	<div class="mb-4 text-right">
		<span>사용가능 적립금 : |</span>
		<span>쿠폰 :</span>
	</div>
	<hr style="border:1px solid black; margin-bottom:0px;"/>
	<table class="table">
		<tr class="text-center">
			<th><input type="checkbox" name="allCheck" id="allCheck" onchange="ckBox()"/></th>
			<th>상품정보</th>
			<th style="width:120px;">판매가</th>
			<th style="width:70px;">수량</th>
			<th style="width:100px;">배송</th>
			<th style="width:120px;">배송비</th>
			<th style="width:130px;">합계</th>
			<th>비고</th>
		</tr>
		<c:set var="cnt" value="1"/>
		<c:forEach var="vo" items="${vosCart}" varStatus="st">
			<c:set var="price" value="${vo.productPrice + vo.optionPrice}"/>
			<tr class="text-center" style="line-height: 80px;">
				<td><input type="checkbox" name="product" id="check${cnt}" value="${vo.idx}/${vo.totalPrice}" onchange="onTotal()" checked/></td>
				<td class="text-left" style="width:420px;">
					<img src="${ctp}/data/shop/product/${vo.thumbImg}" width="100px;" style="float:left"/>
					<div class="mt-4" style="line-height: 25px;">
						<div>&nbsp;&nbsp;${vo.productName}</div>
						<div>&nbsp;&nbsp;<font color="gray">[옵션: ${vo.optionName}<c:if test="${vo.optionPrice != 0}">(+<fmt:formatNumber value="${vo.optionPrice}"/>)</c:if>]</font></div>
					</div>
				</td>
				<td><b><fmt:formatNumber value="${price}"/>원</b></td>
				<td>${vo.optionNum}</td>
				<td>기본배송</td>
				<td>3,000원 조건</td>
				<td><b><fmt:formatNumber value="${vo.totalPrice}"/>원</b></td>
				<td class="pt-4" style="line-height: 0px;">
					<div><input type="button" value="주문하기" class="btn btn-red-border mb-1"/></div>
					<div><input type="button" value="삭제" onclick="cartDeleteOne(${vo.idx})" class="btn btn-gray-border"/></div>
				</td>
			</tr>
			<c:set var="cnt" value="${cnt + 1}"/>
		</c:forEach>
		<tr class="bottomInfo" style="border-bottom:1px solid #9DB2BF;">
			<td colspan="5">[기본배송]</td>
			<td colspan="3" style="text-align: right">30,000원 이상 구매시 배송비 무료!</td>
		</tr>
	</table>
	<input type="button" value="선택상품 삭제" class="btn btn-gray-border"/>
	<input type="button" value="장바구니비우기" class="btn btn-gray-border"/>
	<hr class="mt-5" style="border:1px solid gray; margin-bottom:0px;"/>
	<table class="table">
		<tr class="text-center">
			<th>총 상품금액</th>
			<th></th>
			<th>총 배송비</th>
			<th></th>
			<th>결제예정금액</th>
		</tr>
		<tr style="border-bottom:1px solid black;">
			<td style="width:400px; height: 70px"><div id="totProductPrice">0원</div></td>
			<td style="width:10px; height: 70px"><font size="5"><b>+</b></font></td>
			<td style="width:400px; height: 70px"><div id="postPrice">0원</div></td>
			<td style="width:10px; height: 70px"><font size="5"><b>=</b></font></td>
			<td style="width:400px; height: 70px"><div id="payPrice">0원</div></td>
		</tr>
	</table>
	<div class="text-center">
		<input type="button" value="선택상품 주문하기" class="btn btn-red-border-2"/>
		<input type="button" value="전체상품 주문하기" class="btn btn-red"/>
	</div>
				
</div>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>