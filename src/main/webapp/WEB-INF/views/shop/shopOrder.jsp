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
	<title>shopOrder.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="stylesheet" href="${ctp}/css/shop.css">
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  	<script src="${ctp}/js/woo.js"></script>
	<style>
		.tableProduct, .tablePay th {
			background-color: #fbfbfb;
		}
		.btn-green {
			background-color: #E1ECC8 !important;
		}
		.bottomInfo {
			background-color: #ECECEC;
		}
		.memberInput {
			padding: 0 15px;
		    width: 40%;
		    height: 35px;
		    border: 1px solid #e1e1e1;
			border-bottom: 1px solid #e1e1e1;
			box-sizing: border-box;
			outline:none;
		}
		.memberSelect {
			width: 20%;
		    height: 35px;
		    border: 1px solid #e1e1e1;
			border-bottom: 1px solid #e1e1e1;
			box-sizing: border-box;
			outline:none;
		}
		.tablePost th {
			background-color: #fff;
			width: 130px;
		}
		
		.tablePost tr {
			border-bottom: 1px solid #EAEAEA;
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
		.tableDiscount th{
			background-color : #fbfbfb;
			width: 100px;
			font-weight: normal;
		}
		.tableDiscount tr{
			border-bottom: 1px solid #D6E4E5;
		}
		#payType {
			width: 800px;
			height: 250px;
			border: 1px solid black;
		}
		#payResult{
			background-color:#eee;
			height: 250px;
			border: 1px solid black;
			border-left: none;
		}
		#payment:active, #payment:focus {
			outline:none !important;
			box-shadow:none !important;
		}
	</style>
	<script>
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<div class="container">
	<div class="mt-4 text-center">
		<span style="font-size:25px;"><b>주문서작성</b></span>
	</div>
	<hr style="border:1px solid black; margin-bottom:0px;"/>
	<table class="table tableProduct">
		<tr class="text-center">
			<th>상품정보</th>
			<th style="width:120px;">판매가</th>
			<th style="width:100px;">수량</th>
			<th style="width:100px;">배송</th>
			<th style="width:120px;">배송비</th>
			<th style="width:130px;">합계</th>
		</tr>
		<c:forEach var="vo" items="${vosCart}" varStatus="st">
			<c:set var="price" value="${vo.productPrice + vo.optionPrice}"/>
			<tr class="text-center" style="line-height: 50px;">
				<td class="text-left" style="width:420px;">
					<img src="${ctp}/data/shop/product/${vo.thumbImg}" width="60px;" style="float:left"/>
					<div class="m-2" style="line-height: 20px;">
						<div>&nbsp;&nbsp;${vo.productName}</div>
						<div>&nbsp;&nbsp;<font color="gray">[옵션: ${vo.optionName}<c:if test="${vo.optionPrice != 0}">(+<fmt:formatNumber value="${vo.optionPrice}"/>)</c:if>]</font></div>
					</div>
				</td>
				<td><b><fmt:formatNumber value="${price}"/>원</b></td>
				<td>${vo.optionNum}</td>
				<td>기본배송</td>
				<td>3,000원 [조건]</td>
				<td><b><fmt:formatNumber value="${vo.totalPrice}"/>원</b></td>
			</tr>
		</c:forEach>
		<tr class="bottomInfo" style="border-bottom:1px solid #9DB2BF;">
			<td colspan="4">[기본배송]</td>
			<td colspan="3" style="text-align: right">30,000원 이상 구매시 배송비 무료!</td>
		</tr>
		<tr>
			<td class="p-0 m-0" colspan="8"><font size="2" color="red">상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</font></td>
		</tr>
	</table>
	<p><br/></p><p><br/></p>
	<div class="row ml-1">
		<span><font size="4"><b>배송 정보</b></font></span>
		<span style="padding: 8px 0 0 950px; font-size: 13px;"><font color="red">*</font>필수입력사항</span>
	</div>
	<hr style="border:1px solid gray; margin-top:0px;" />
	<table class="table table-borderless tablePost">
		<tr>
			<th>배송지 선택</th>
			<td>
				<input type="radio">주문자 정보와 동일 &nbsp;&nbsp;
				<input type="radio">새로운 배송지 &nbsp;&nbsp;
				<input type="button" value="주소록보기 >" class="btn btn-green btn-sm">
			</td>
		</tr>
		<tr>
			<th><font color="red">*</font>받으시는 분</th>
			<td><input type="text" name="name" id="name" value="${mvo.name}" class="memberInput"/></td>
		</tr>
		<tr>
			<th style="line-height: 100px;"><font color="red">*</font>주소</th>
			<td class="ml-1">
				<div class="input-group mb-1">
			        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="memberInput">
			        <div class="input-group-append">
			        	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-green btn-sm">
			        </div>
		      	</div>
		      	<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
		      	<div class="input-group mb-1">
			        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
			        <div class="input-group-append">
			        	<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
			        </div>
      			</div>
			</td>
		</tr>
		<tr>
			<th><font color="red">*</font>휴대전화</th>
			<td>
				<input type="text" name="tel1" size=3 maxlength=4 class="memberInput ml-1 mr-2" style="width:10%" onkeyup="telCheck()"/>-
				<input type="text" name="tel2" size=4 maxlength=4 class="memberInput ml-1 mr-2" style="width:10%" onkeyup="telCheck()"/>-
	        	<input type="text" name="tel3" size=4 maxlength=4 class="memberInput ml-1" style="width:10%" onkeyup="telCheck()"/>
			</td>
		</tr>
		<tr>
			<th><font color="red">*</font>이메일</th>
			<td>
				<input type="text" placeholder="이메일을 입력하세요." id="email1" name="email1" required class="memberInput"/> @
				<input type="text" placeholder="이메일주소를 선택하세요." id="email2" name="email2" required class="memberInput"/>
			</td>
		</tr>
		<tr>
			<th>배송메시지</th>
			<td>
				<textarea rows="1" cols="40"></textarea>
			</td>
		</tr>
	</table>
	<p><br/></p>
	<div class="row ml-1">
		<span><font size="4"><b>결제 예정 금액</b></font></span>
	</div>
	<hr style="border:1px solid gray; margin:0;" />
	<table class="table tablePay">
		<tr class="text-center">
			<th>총 주문 금액</th>
			<th></th>
			<th>총 할인(적립금 + 쿠폰)</th>
			<th></th>
			<th>총 결제예정 금액</th>
		</tr>
		<tr style="border-bottom:1px solid black;">
			<td style="width:400px; height: 70px"><div id="totProductPrice">0원</div></td>
			<td style="width:10px; height: 70px"><font size="5"><b>+</b></font></td>
			<td style="width:400px; height: 70px"><div id="postPrice">0원</div></td>
			<td style="width:10px; height: 70px"><font size="5"><b>=</b></font></td>
			<td style="width:400px; height: 70px"><div id="payPrice">0원</div></td>
		</tr>
	</table>
	<p><br/></p>
	<hr style="border:1px solid #D6E4E5; margin:0"/>
	<table class="table table-borderless tableDiscount">
		<tr>
			<th><b>총 할인금액</b></th>
			<td><b>0원</b></td>
		</tr>
		<tr>
			<th><font size="2">쿠폰할인</font></th>
			<td style="background-color: fff !important;"><input type="button" value="쿠폰적용" class="btn btn-dark btn-sm"/></td>
		</tr>
		<tr>
			<th><font size="2">적립금</font></th>
			<td style="background-color: fff !important;">
				<input type="text" class="memberInput"/>원 (총 사용가능 적립금 : <font color="orange">2,000원</font>)
			</td>
		</tr>
	</table>
	<p><br/></p>
	<div class="row ml-1 mb-2">
		<span><font size="4"><b>결제 수단</b></font></span>
	</div>
	<div class="row">
		<div id="payType" class="col pt-4 pl-4">
			<span><input type="radio" name="pay" checked/>카드 결제 &nbsp;&nbsp;</span>
			<span><input type="radio" name="pay"/>가상계좌</span>
			<hr style="width:795px; margin-left:-20px"/>
			❗최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.<br/>
			❗소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.<br/>
		</div>
		<div id="payResult" class="col pt-4">
			<div class="text-right"><b>카드 결제</b> 최종결제 금액</div>
			<div class="text-right"><font size="5" color="red"><b>29,700원</b></font></div>
			<hr style="width:300px; border-top:1px solid gray"/>
			<div class="text-center">
				<span style="padding-right:100px;">총 적립예정금액</span>
				<span><font color="#CE5959">267원</font></span>
			</div>
			<div class="text-center mt-2">
				<button type="button" id="payment" class="btn"><img src="//img.echosting.cafe24.com/skin/base_ko_KR/order/btn_place_order.gif"/></button>
			</div>
		</div>
	</div>
</div>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>