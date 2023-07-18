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
	<title>shopDetail.jsp</title>
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
		.optionSelect{
			width: 100%;
		    height: 44px;
		    font-size: 15px;
		    color: #333;
		    border: 1px solid #d5d5d5;
		    padding-left: 10px;
		    outline: none;
		}
		.btn-red-border {
			border-color: #fc2020 !important;
		    color: #fc2020 !important;
		    font-weight: bold !important;
		    border-radius: 0px !important;
		    width:170px !important;
		    height:60px !important;
		    
		}
		.btn-gray-border {
			border-color: #9DB2BF !important;
		    color: #9DB2BF !important;
		    font-weight: bold !important;
		    border-radius: 0px !important;
		    width:100px !important;
		    height:60px !important;
		    
		}
		.btn-red {
			border-color: #fc2020 !important;
		    color: #fff !important;
		    font-weight: bold !important;
		    background: #fc2020 !important;
		    border-radius: 0px !important;
		    width:270px !important;
		    height:60px !important;
		}
		.slideon {
			width:273px;
			height:70px;
			line-height: 60px;
			border: 1px solid #000;
			border-bottom-color: #fff;
			font-size: 16px;
		}
		.slide {
			width:273px;
			height:70px;
			line-height: 60px;
			border-bottom: 1px solid #000;
			font-size: 16px;
			color:#B2B1B9;
		}
		
		.slideon a:hover {
			text-decoration: none;
			color:black;
		}
		
		.slide a:hover {
			text-decoration: none;
			color:#B2B1B9;
		}
		.btn-pm {
			display: inline-block;
		    width: 33px;
		    height: 36px;
		    position: relative;
		    border: 1px solid #dbdbdb;
		    box-sizing: border-box;
		    background: #fff;
		    font-weight: bold;
		    font-size: 15px;
		}
		
		.input-pm {
			width: 42px;
		    height: 36px;
		    line-height: 36px;
		    border: 1px solid #dbdbdb;
		    border-right:none;
		    border-left:none;
		    box-sizing: border-box;
		    text-align: center !important;
		    margin-left: -3px;
		    outline: none;
		    margin-top:2px;
		}
		.input-price {
			outline: none;
			border : none;
			background-color: #F5F5F5;
			text-align: right;
		}
		#totPrice {
			color:red;
			font-size: 22px;
			font-weight: bold;
		}
		.btn:active, .btn:focus {
			outline:none !important;
			box-shadow:none !important;
		}
	</style>
	<script>
		'use strict';
		let opPriceArr = [];
		let idxArr = [];
		$(function(){
			$("select option[value*='no']").prop('disabled',true);
		});
		
		let cnt = 0;
		function addOptionOrder() {
			let infoString = $("#optionList").val();
			let info = [];
			info = infoString.split("/");
			
			let str = "";
			let minus = 0, plus = 1;
			let opTotPrice = parseInt(info[3])+parseInt(info[2]); 
			cnt++;
			opPriceArr[cnt-1] = opTotPrice;
			idxArr[cnt-1] = cnt;
			str += '<div id="demo'+cnt+'" class="pt-3 pb-3" style="background: #F5F5F5; border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD">';
			if(info[2] == 0) {
				str+= '<div class="row"><div class="col pl-4" style="margin-left:10px;"><font size="3"><b>'+info[1]+'</b></font></div>';
			}
			else {
				str+= '<div class="row"><div class="col pl-4" style="margin-left:10px;"><font size="3"><b>'+info[1]+'(+'+parseInt(info[2]).toLocaleString()+'원)</b></font></div>';
			}
	  		str += '<div class="col text-right" style="padding-right:30px;"><button type="button" onclick="removeOption('+cnt+')" class="btn" ><i class="fa-solid fa-xmark fa-lg" style="color:gray"></i></button></div></div>';
	  		str += '<div class="row mt-3"><div class="col">';
	  		str += '<button type="button" id="minBtn'+cnt+'" onclick="count('+minus+', '+cnt+', '+opTotPrice+')" class="btn-pm" style="margin-left:15px !important;">-</button>';
	  		str += '<input type="text" id="result'+cnt+'" value="1" class="input-pm" />';
	  		str += '<button type="button" id="plsBtn'+cnt+'" onclick="count('+plus+', '+cnt+', '+opTotPrice+')" class="btn-pm" style="margin-left:-4px !important;">+</button></div>';
			str += '<div class="col text-right"><span style="padding-right:15px;"><font size="5"><input type="text" value="'+opTotPrice.toLocaleString()+'원" id="opPrice'+cnt+'" class="input-price" readonly/></font></span></div></div></div>';
			
			$("#optionOrder").append(str);
			
			totCalc();
		}
		
		function totCalc() {
			let totPrice = 0, totCount = 0;
			for(let i = 1; i <= idxArr; i++) {
				totPrice = totPrice + parseInt(($("#opPrice"+i).val()).replace(/,/g , ''));
				totCount = totCount + parseInt($("#result"+i).val());
			}
			$("#totPrice").text(totPrice + "원");
			$("#totCount").text(totCount + "개");
		}
		
		function count(type, cnt)  {
			let resultId = "result" + cnt;
			let opPriceId = "opPrice" + cnt;
			// 결과를 표시할 element
			let result = document.getElementById(resultId).value;
			// 더하기/빼기
			if(type == 1) {
			  if(parseInt(result) >= 999) {
				  alert("최대 수량은 999개입니다.");
				  document.getElementById(resultId).value = 999;
				  return false;
			  }
			  else result = parseInt(result) + 1;
			}
			else if(type == 0) {
			  if(parseInt(result) <= 1) {
				  alert("최소 수량은 1개입니다.");
				  document.getElementById(resultId).value = 1;
				  return false;
			  }
			  else result = parseInt(result) - 1;
			}
			 
			document.getElementById(resultId).value = result;
			let optionTotal = (opPriceArr[cnt-1] * result).toLocaleString();
			document.getElementById(opPriceId).value = optionTotal + "원";
			
			totCalc();
		}
		
		// 옵션항목 삭제
	    function removeOption(idx) {
			console.log(cnt);
			console.log(idx);
			console.log(opPriceArr);
			console.log(idxArr);
			console.log(idxArr.indexOf(idx));
			idxArr.splice(idxArr.indexOf(idx), 1);
			console.log(idxArr);
	    	opPriceArr.splice(idx-1, 1);
			console.log(opPriceArr);
	    	$("#demo"+idx).remove();
	    	cnt--;
	    	totCalc();
	    	
	    }
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<div class="container">
	<div class="row mt-4" style="margin-left:-50px;">
    	<div class="col p-3 text-center">
		  <!-- 상품메인 이미지 -->
		  <div>
		    <img src="${ctp}/data/shop/product/${productVO.FSName}" width="80%"/>
		  </div>
		</div>
		<div class="col p-3">
		  <!-- 상품 기본정보 -->
		  <div id="iteminfor">
		  	<div><font color="#9DB2BF">${productVO.categoryMainName} > ${productVO.categorySubName}</font></div>
		    <div style="font-size:28px"><b>${productVO.productName}</b></div>
		    <hr style="border:1px solid gray; margin-top:10px;"/>
		    <div>
			    <font size="3"><b>소비자가</b></font>
			    <font size="5">&nbsp;&nbsp;<b><fmt:formatNumber value="${productVO.productPrice}"/>원</b></font>
		    </div>
		    <div>
			    <font size="3"><b>배송비</b></font>
			    <font size="3">&nbsp;&nbsp;3,000원(30,000원 이상 구매 시 무료)</font>
		    </div>
		  </div>
		  <!-- 상품주문을 위한 옵션정보 출력 -->
		  <div class="form-group mt-3">
			<select id="optionList" class="optionSelect" onchange="addOptionOrder()">
			  <option value="">-[필수] 옵션을 선택해 주세요-</option>
			  <option value="no">- - - - - - - - - - - - - - - - - -</option>
			  <c:forEach var="vo" items="${optionVOS}">
			    <option value="${vo.idx}/${vo.optionName}/${vo.optionPrice}/${productVO.productPrice}">${vo.optionName} <c:if test="${vo.optionPrice != 0}">&nbsp;(+<fmt:formatNumber value="${vo.optionPrice}"/>원)</c:if></option>
			  </c:forEach>
			</select>
		  </div>
		  <div id="optionOrder"></div>
		  <br/>
		  <div class="text-right">
		  	<span><b>총 상품금액</b>(수량) : &nbsp;<span id="totPrice">0원</span>(<span id="totCount">0개</span>)</span>
		  </div>
		  <div class="mt-4">
		    <input type="button" value="♡찜" class="btn btn-gray-border mr-1"/>
		    <input type="button" value="장바구니"  class="btn btn-red-border mr-1"/>
		    <input type="button" value="바로구매" class="btn btn-red"/>
		  </div>
		</div>
  </div>
  <br/><br/>
  <section id="detail">
	  <div class="row mt-5 ml-3">
	  	<div class="slideon text-center"><a href="#detail">상품정보</a></div>
	  	<div class="slide text-center"><a href="#review">상품후기</a></div>
	  	<div class="slide text-center"><a href="#QnA">상품문의</a></div>
	  	<div class="slide text-center"><a href="#change/return">교환/반품</a></div>
	  </div>
	  <div id="content" class="mt-4 text-center">${productVO.content}</div>
  </section>
  <section id="review">
	  <div class="row mt-5 ml-3">
	  	<div class="slide text-center"><a href="#detail">상품정보</a></div>
	  	<div class="slideon text-center"><a href="#review">상품후기</a></div>
	  	<div class="slide text-center"><a href="#QnA">상품문의</a></div>
	  	<div class="slide text-center"><a href="#change/return">교환/반품</a></div>
	  </div>
  </section>
  <section id="QnA">
  	  <div class="row mt-5 ml-3">
	  	<div class="slide text-center"><a href="#detail">상품정보</a></div>
	  	<div class="slide text-center"><a href="#review">상품후기</a></div>
	  	<div class="slideon text-center"><a href="#QnA">상품문의</a></div>
	  	<div class="slide text-center"><a href="#change/return">교환/반품</a></div>
	  </div>
  </section>
  <section id="change/return">
  	  <div class="row mt-5 ml-3">
	  	<div class="slide text-center"><a href="#detail">상품정보</a></div>
	  	<div class="slide text-center"><a href="#review">상품후기</a></div>
	  	<div class="slideon text-center"><a href="#QnA">상품문의</a></div>
	  	<div class="slide text-center"><a href="#change/return">교환/반품</a></div>
	  </div>
  </section>
</div>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>