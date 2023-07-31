<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>paymentOk.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<script>
		function test() {
			var temp = "";
			temp += '?name=${paymentVO.name}';
			temp += '&amount=${paymentVO.amount}';
			temp += '&buyer_email=${paymentVO.buyer_email}';
			temp += '&buyer_name=${paymentVO.buyer_name}';
			temp += '&buyer_tel=${paymentVO.buyer_tel}';
			temp += '&buyer_addr=${paymentVO.buyer_addr}';
			temp += '&buyer_postcode=${paymentVO.buyer_postcode}';
			//temp += '&orderIdx=${orderVO.orderIdx}';
			
			location.href='${ctp}/shop/paymentResult'+temp;
		}

	</script>
</head>
<body>
<p><br></p>
<div class="container">
  <h2>결제처리</h2>
  <hr/>
  <h3>현재 결제가 진행중입니다.</h3>
  <p><img src="${ctp}/images/payment.gif" width="200px"/></p>
  <input type="button" value="ㅎㅎ" onclick="test()"/>
  <hr/>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>