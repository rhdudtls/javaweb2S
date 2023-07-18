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
	<title>shopList.jsp</title>
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
		.subCateg {
			margin-right:30px;
			font-size:16px;
			color:gray;
		}
		.subCateg:hover {
			color:black;
			text-decoration: none;
		}
		.nowPart {
			color : #fe1f20;
			font-weight: bold;
			border-bottom: 5px solid #fe1f20;
			padding-bottom:14px;
		}
		.nowPart:hover{
			color : #fe1f20;
			font-weight: bold;
		}
		
		.detail:hover {
			color:black;
			text-decoration: none;
		}
	</style>
	<script>
		'use strict';
		
		$(function(){
			const url = document.location.href;
			const link = document.location.search;
			
			if(url.indexOf(link) != -1) {
				$("span a[href*='"+link+"']").addClass('nowPart')
			}
		});
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<div class="container">
	<div class="mb-4 mt-5 ml-2" style="font-size:25px;">
		<span><b>${mainVO.categoryMainName}</b></span>
	</div>
	<c:if test="${mainVO.cnt != 0}">
		<span><a href="${ctp}/shop/shopList?category=${category}&part=all" class="subCateg ml-2">전체보기</a></span>
		<c:forEach var="subName" items="${CateSubVos}" varStatus="st">
			<span><a href="${ctp}/shop/shopList?category=${category}&part=${subName.categorySubCode}" class="subCateg">${subName.categorySubName}</a></span>
		</c:forEach>
	</c:if>
	<hr id="hr" style="border-top:1px solid #bbb; margin:15px 0 0 7px;"/>
	<c:set var="cnt" value="0"/>
  	<div class="row mt-5">
  		<c:if test="${fn:length(vosProduct) != 0}">
		    <c:forEach var="pvo" items="${vosProduct}">
		    	<div class="col-md-3">
		    		<a href="${ctp}/shop/shopDetail?idx=${pvo.idx}" class="detail">
				    	<div class="card col" style="width:265px; border:none;">
						    <img class="card-img-top" src="${ctp}/data/shop/product/${pvo.FSName}" style="width:255px;">
						    <div class="card-body p-0 mt-2">
						    	<div class="card-title" style="font-size:17px; width:255px;">${pvo.productName}</div>
								<p class="card-text">
									<span style="font-size:19px;"><b><fmt:formatNumber value="${pvo.productPrice}"/>원</b></span>&nbsp;
								</p>
					    	</div>
					    </div>
				    </a>
				</div>
		      <c:set var="cnt" value="${cnt+1}"/>
		      <c:if test="${cnt%4 == 0}">
				</div>
				<div class="row mt-5">
		      </c:if>
		    </c:forEach>
	    </c:if>
	    <c:if test="${fn:length(vosProduct) == 0}">
	    	<div class="mb-4 mt-5 ml-4" style="font-size:30px;">상품 준비중입니다.</div>
	    </c:if>
</div>
</div>
<c:if test="${fn:length(vosProduct) == 0}">
	<p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p>
</c:if>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>