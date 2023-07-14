<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<title>productInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		
		let cnt = 1;
	    
	    // 옵션항목 추가
	    function addOption() {
	    	let strOption = "";
	    	let test = "t" + cnt; 
	    	
	    	cnt++;
	    	
	    	strOption += '<div id="'+test+'"><hr size="5px"/>';
	    	strOption += '<font size="4"><b>상품옵션등록</b></font>&nbsp;&nbsp;';
	    	strOption += '<input type="button" value="옵션삭제" class="btn btn-outline-danger btn-sm" onclick="removeOption('+test+')"/><br/>'
	    	strOption += '상품옵션이름';
	    	strOption += '<input type="text" name="optionName" id="optionName'+cnt+'" class="form-control"/>';
	    	strOption += '<div class="form-group">';
	    	strOption += '상품옵션가격';
	    	strOption += '<input type="number" name="optionPrice" id="optionPrice'+cnt+'" class="form-control"/>';
	    	strOption += '</div>';
	    	strOption += '</div>';
	    	$("#optionType").append(strOption);
	    	
	    }
	    
	 	// 옵션항목 삭제
	    function removeOption(test) {
	    	/* $("#"+test).remove(); */
	    	$("#"+test.id).remove();
	    }
	 	
	    // 옵션 입력후 등록전송
	    function fCheck() {
	    	let priceArr = [];
			let nameArr = [];
		
	    	for(let i=1; i<=cnt; i++) {
	    		let name = $("#optionName"+i).val();
	    		let price = $("#optionPrice"+i).val();
	    		if(name == "") {
	    			alert("빈칸 없이 상품 옵션명을 모두 등록하셔야 합니다");
	    			return false;
	    		}
	    		else if(price == "") {
	    			alert("빈칸 없이 상품 옵션가격을 모두 등록하셔야 합니다");
	    			return false;
	    		}
	    		else if(nameArr.indexOf(name) != -1) {
					alert("같은 옵션명을 입력하셨습니다. 다시 확인하세요.");
					return false;
				}
	    		nameArr.push(name);
	    		priceArr.push(price);
	    	}
	    	
	    	myform.flag.value = "option2";
	    	myform.submit();
	    	
	    }
	    
	</script>
</head>
<body style="background-color:#EEF1FF">
<div class="top" style="z-index: 1">
	<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"/>
</div>
<div class="left">
	<jsp:include page="/WEB-INF/views/admin/adminMenu.jsp"/>
</div>
<div class="container">
  <div class="mb-3 mt-5 text-center" style="font-size:30px;"><b>상품 옵션 관리</b></div>
  <hr style="border:1px solid gray;"/>
  <form name="myform" method="post" action="${ctp}/admin/productOption">
    <div class="row product1">
      <div class="col">
	      <div style="color:#9DB2BF">${vo.categoryMainName} > ${vo.categorySubName}</div>
	      <div style="font-size:23px"><b>${vo.productName}</b></div>
	      <p><img src="${ctp}/data/shop/product/${vo.FSName}" width="50%"/></p>
	      <p><a href="${ctp}/admin/productContent?idx=${vo.idx}" class="btn btn-success">돌아가기</a></p>
      </div>
      <div class="col">
        <div class="mt-4"style="font-size:20px"><b>옵션</b></div>
        <c:forEach var="i" begin="1" end="${fn:length(optionVOS)}">
          <div><font size="4">${optionVOS[i-1].optionName}&nbsp; (+${optionVOS[i-1].optionPrice})</font></div>
        </c:forEach>
        <c:if test="${fn:length(optionVOS) == 0}">등록된 옵션이 없습니다.</c:if>
      </div>
    </div>
    <div class="product3">
	    <hr/>
	    <font size="4"><b>상품옵션등록</b></font>&nbsp;&nbsp;
	    <input type="button" value="옵션박스추가하기" onclick="addOption()" class="btn btn-secondary btn-sm"/><br/>
	    <div class="form-group">
	      <label for="optionName">상품옵션이름</label>
	      <input type="text" name="optionName" id="optionName1" class="form-control"/>
	    </div>
	    <div class="form-group">
	      <label for="optionPrice">상품옵션가격</label>
	      <input type="text" name="optionPrice" id="ozxcptionPrice1" class="form-control"/>
	    </div>
	    <div id="optionType"></div>
	    <hr/>
	    <div class='text-right'><input type="button" value="옵션등록" onclick="fCheck()" class="btn btn-primary"/></div>
    </div>
    <input type="hidden" name="productIdx" value="${vo.idx}">
    <input type="hidden" name="productName" value="${vo.productName}">
    <input type="hidden" name="flag" value="option2">
  </form>
</div>
<p><br/></p>
</body>
</html>