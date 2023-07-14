<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<title>productList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.mainCateg {
			margin-right:30px;
			font-size:16px;
			color:gray;
		}
		.mainCateg:hover {
			color:black;
			text-decoration: none;
		}
		.nowPart {
			color : #fe1f20;
			font-weight: bold;
			border-bottom: 5px solid #fe1f20;
			padding-bottom:18px;
		}
		.nowPart:hover{
			color : #fe1f20;
			font-weight: bold;
		}
		.goPdInput {
			margin-left:830px;
			border-radius: 25px !important;
			border: 1px solid #e6e6e6 !important;
			height:30px !important;
			background-color: white !important;
			line-height: 5px !important;
		}
		
		.productContent:hover {
			color:black;
		}
	</style>
	<script>
		'use strict';
		
		$(function(){
			const url = document.location.href;
			const link = document.location.search;
			
			if(link == ""){
				$("a[href*='all']").addClass('nowPart')
			}
			else if(url.indexOf(link) != -1) {
				$("a[href*='"+link+"']").addClass('nowPart')
			}
		});
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
	<div class="mb-4 mt-5 ml-2" style="font-size:30px;">
		<span><b>상품목록</b></span>
		<span><input type="button" value="상품등록 &gt;" onclick="location.href='${ctp}/admin/productInput';" class="btn goPdInput"/></span>
	</div>
	<span><a href="${ctp}/admin/productList?part=all" class="mainCateg ml-2">전체보기</a></span>
	<c:forEach var="mainName" items="${mainNameVos}" varStatus="st">
		<span><a href="${ctp}/admin/productList?part=${mainName.categoryMainCode}" class="mainCateg">${mainName.categoryMainName}</a></span>
	</c:forEach>
	<hr id="hr" style="border-top:1px solid #bbb; margin-left:7px;"/>
    <c:set var="cnt" value="0"/>
  	<div class="row mt-5">
	    <c:forEach var="vo" items="${productVos}">
			<div class="col-md-3">
				<div style="text-align:center">
					<a href="${ctp}/admin/productContent?idx=${vo.idx}" class="productContent">
						<img src="${ctp}/data/shop/product/${vo.FSName}" width="230px" height="200px"/>
						<div><font size="3">${vo.productName}</font></div>
						<div><font size="3" color="orange"><fmt:formatNumber value="${vo.productPrice}" pattern="#,###"/>원</font></div>
					</a>
				</div>
			</div>
	      <c:set var="cnt" value="${cnt+1}"/>
	      <c:if test="${cnt%4 == 0}">
			</div>
			<div class="row mt-5">
	      </c:if>
	    </c:forEach>
    <div class="container">
		<c:if test="${fn:length(productVos) == 0}">
			<div class="mb-4 mt-5 text-center" style="font-size:30px;">해당 카테고리에 상품이 존재하지 않습니다.</div>
		</c:if>
    </div>
    </div>
</div>
<p><br/></p>
</body>
</html>