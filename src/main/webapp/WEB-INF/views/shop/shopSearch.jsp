<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/shop.css">
	<title>shopSearch.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.col-3 {
			height: 55px;
			margin-top:0px !important;
		}

		#admin > font{
			display: none;
		}
		.btn:active, .btn:focus {
			outline:none !important;
			box-shadow:none !important;
		}
		.detail:hover {
			text-decoration: none;
			color:black;
		}
	</style>
	<script>
		'use strict';
		
		function fCheck2() {
			let keyword2 = $("#keyword2").val();
			
			if(keyword2.trim() == "") {
				alert("검색어를 입력하세요!");
				return false;
			}
			else searchForm.submit();
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<div class="container">
	<form name="searchForm2" onsubmit="return fCheck2()">
		<input type="hidden" name="flag" value="shop"/>
		<div class="mt-4 mb-4 pageTitle">상품검색</div>
		<div class="pt-4 searchDemo text-center">
			<span><select name="searchCategory">
				<option <c:if test="${part == 'productName'}">selected</c:if> value="productName">상품명</option>
				<option <c:if test="${part != 'productName'}">selected</c:if> value="productCode">상품코드</option>
			</select></span>
			<span><input type="text" name="keyword2" id="keyword2" value="${keyword}" /></span>
			<span><input type="button" onclick="fCheck2()" value="검색하기" class="btn btn-black"/></span>
		</div>
	</form>
	<hr style="border-top:1px solid #bbb; margin-top:70px;"/>
	<c:set var="cnt" value="0"/>
  	<div class="row mt-5">
  		<c:if test="${fn:length(vos) != 0}">
		    <c:forEach var="vo" items="${vos}">
		    	<div class="col-md-3">
		    		<a href="${ctp}/shop/shopDetail?idx=${vo.idx}" class="detail">
				    	<div class="card col" style="width:265px; border:none;">
						    <img class="card-img-top" src="${ctp}/data/shop/product/${vo.FSName}" style="width:255px;">
						    <div class="card-body p-0 mt-2">
						    	<div class="card-title" style="font-size:17px; width:255px;">${vo.productName}</div>
								<p class="card-text">
									<span style="font-size:19px;"><b><fmt:formatNumber value="${vo.productPrice}"/>원</b></span>&nbsp;
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
	    <c:if test="${fn:length(vos) == 0}">
	    	<div class="mb-4 mt-5 searchNone">
	    		<div><font color="blue"><b>검색 결과가 없습니다.</b></font></div>
		    	<div><b>정확한 검색어 인지 확인하시고 다시 검색해 주세요.</b></div><br/>
		    	<div>검색어/제외검색어의 입력이 정확한지 확인해 보세요.</div>
		    	<div>두 단어 이상의 검색어인 경우, 띄어쓰기를 확인해 보세요.</div>
		    	<div>검색 옵션을 다시 확인해 보세요.</div>
	    	</div>
	    </c:if>
</div>
</div>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>