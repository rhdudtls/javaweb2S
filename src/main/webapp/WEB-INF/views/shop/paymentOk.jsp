<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>paymentOk.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="stylesheet" href="${ctp}/css/shop.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<style>
		.col-3 {
			height: 55px;
			margin-top:0px !important;
		}

		#admin > font{
			display: none;
		}
	</style>
	<script>
	// IMP.init('imp21064327');
		var IMP = window.IMP; 
    	IMP.init("imp07744054");
		
		IMP.request_pay({
		    /* pg : 'inicis', */ /* version 1.1.0부터 지원. 변경된 방침에서는 pg : 'html5_inicis' 로 고쳐준다. */
		    pg : 'html5_inicis.INIBillTst',
		    pay_method : 'card',
		    merchant_uid : 'mydak_' + new Date().getTime(),
		    name : '${paymentVO.name}',
		    amount : ${paymentVO.amount}, //판매 가격
		    buyer_email : '${paymentVO.buyer_email}',
		    buyer_name : '${paymentVO.buyer_name}',
		    buyer_tel : '${paymentVO.buyer_tel}',
		    buyer_addr : '${paymentVO.buyer_addr}',
		    buyer_postcode : '${paymentVO.buyer_postcode}'
		}, function(rsp) {
			  var paySw = 'no';
		      if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '\n고유ID : ' + rsp.imp_uid;
		        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		        msg += '\n결제 금액 : ' + rsp.paid_amount;
		        msg += '\n카드 승인번호 : ' + rsp.apply_num;
		        paySw = 'ok';
		      } else {
		          var msg = '결제에 실패하였습니다.\n';
		          msg += rsp.error_msg;
		      }
		      alert(msg);
		      if(paySw == 'no') {
			      alert("다시 주문구매창으로 이동합니다.");
		    	  location.href='${ctp}/shop/shopOrder';
		      }
		      else {
				  var temp = "";
				  temp += '?name=${paymentVO.name}';
				  temp += '&amount=${paymentVO.amount}';
				  temp += '&buyer_email=${paymentVO.buyer_email}';
				  temp += '&buyer_name=${paymentVO.buyer_name}';
				  temp += '&buyer_tel=${paymentVO.buyer_tel}';
				  temp += '&buyer_addr=${paymentVO.buyer_addr}';
				  temp += '&buyer_postcode=${paymentVO.buyer_postcode}';
				  temp += '&imp_uid=' + rsp.imp_uid;
				  temp += '&merchant_uid=' + rsp.merchant_uid;
				  temp += '&paid_amount=' + rsp.paid_amount;
				  temp += '&apply_num=' + rsp.apply_num;
				
				  //temp += '&orderIdx=${orderVO.orderIdx}';
				
				  location.href='${ctp}/shop/paymentResult'+temp;
		      }
		    });
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<div class="container text-center">
	<div class="mt-4 text-center">
		<p style="font-size:25px;"><b>현재 결제가 진행중입니다.</b></p>
	</div>
    <p><img src="${ctp}/images/payment.gif" width="200px"/></p>
</div>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>