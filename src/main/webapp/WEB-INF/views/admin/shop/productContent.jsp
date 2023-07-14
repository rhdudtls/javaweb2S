<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<title>productContent.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		
		function optionDel() {
			let ans = confirm("해당 옵션을 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	
			let idx = $("#optionList").val();
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/optionDelete",
				data : {idx : idx},
				success : function() {
					alert("옵션이 삭제되었습니다.");
					location.reload();
				},
				error : function() {
					alert("전송 실패!");
				}
			});
		}
	</script>
</head>
<body>
<div class="top" style="z-index: 1">
	<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"/>
</div>
<div class="left">
	<jsp:include page="/WEB-INF/views/admin/adminMenu.jsp"/>
</div>
<div class="container">
  <div class="row" style="margin-left:-50px;">
    <div class="col p-3 text-center">
		  <!-- 상품메인 이미지 -->
		  <div>
		    <img src="${ctp}/data/shop/product/${productVO.FSName}" width="70%"/>
		  </div>
		</div>
		<div class="col p-3">
		  <!-- 상품 기본정보 -->
		  <div id="iteminfor">
		  	<div><font color="#9DB2BF">${productVO.categoryMainName} > ${productVO.categorySubName}</font></div>
		    <div style="font-size:23px"><b>${productVO.productName}</b></div>
		    <hr style="border-top:1px solid gray"/>
		    <font size="4"><b>상품가격 : &nbsp;&nbsp;<fmt:formatNumber value="${productVO.productPrice}"/>원</b></font>
		  </div>
		  <!-- 상품주문을 위한 옵션정보 출력 -->
		  <div class="form-group mt-3">
		    <form name="optionForm">  <!-- 옵션의 정보를 보여주기위한 form -->
				<select size="5" id="optionList" class="form-control">
				  <c:forEach var="vo" items="${optionVOS}">
				    <option value="${vo.idx}">${vo.optionName} &nbsp;(+${vo.optionPrice}원)</option>
				  </c:forEach>
				</select>
		    </form>
		  </div>
		  <br/>
		  <div class="p-2">
		    <input type="button" value="옵션등록" onclick="location.href='${ctp}/admin/productOption2?productName=${productVO.productName}';" class="btn btn-success"/>
		    <input type="button" value="선택옵션삭제" onclick="optionDel()" class="btn btn-danger"/>
		    <input type="button" value="상품수정" onclick="location.href='${ctp}/admin/productUpdate?idx=${productVO.idx}';" class="btn btn-warning"/>
		    <input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/productList';" class="btn btn-primary"/>
		  </div>
		</div>
  </div>
  <br/><br/>
  <!-- 상품 상세설명 보여주기 -->
  <div class="text-center" style="font-size:23px"><b>상세정보</b></div>
  <hr style="border-top:1px solid gray"/>
  <div id="content" class="text-center"><br/>
    ${productVO.content}
  </div>
</div>
<p><br/></p>
</body>
</html>