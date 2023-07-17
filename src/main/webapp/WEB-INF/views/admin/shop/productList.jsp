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
			border-radius: 25px !important;
			border: 1px solid #e6e6e6 !important;
			height:30px !important;
			background-color: white !important;
			line-height: 5px !important;
		}
		
		.productContent:hover {
			color:black;
		}
		.btn-orange {
			background-color: #FFD6A5 !important;
			margin-left:750px;
		}
		.btn-red {
			background-color: #EA5455 !important;
		}
	</style>
	<script>
		'use strict';
		let allCheckSw = 0;
		
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
		
		function allCheck() {
			allCheckSw++;
			if(allCheckSw % 2 == 1) {
				$("input[name=product]").prop("checked", true);
				document.getElementById('allCk').value = "전체해제";
			}
			else {
				$("input[name=product]").prop("checked", false);
				document.getElementById('allCk').value = "전체선택";
			}
		}
		
		function productDelete() {
			let chk_Val = [];
			
			$('input:checkbox[name=product]').each(function (index) {
				if($(this).is(":checked")==true){
					chk_Val.push($(this).val());
			    }
			});
			
			if(chk_Val.length == 0) {
				alert("삭제할 상품을 선택하세요!")
				return false;
			}
			
			let ans = confirm("선택한 상품들을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type:"post",
				url : "${ctp}/admin/productDelete",
				traditional: true,
				data : {productArr : chk_Val},
				success : function(res) {
					if(res == 1) {
						alert("상품이 삭제되었습니다!");
						location.reload();
					}
					else alert("상품 삭제 실패~");
				},
				error : function() {
					alert("전송오류!");
				}
			});
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
	<div class="mb-4 mt-5 ml-2" style="font-size:30px;">
		<span><b>상품목록</b></span>
		<span><input type="button" id="allCk" value="전체선택" onclick="allCheck()" class="btn btn-orange btn-sm"/></span>
		<span><input type="button" value="상품삭제" onclick="productDelete()" class="btn btn-red btn-sm text-light"/></span>
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
					<div><input type="checkbox" name="product" value="${vo.idx}"/></div>
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