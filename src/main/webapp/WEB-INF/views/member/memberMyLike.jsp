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
	<link rel="stylesheet" href="${ctp}/css/mydak.css">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<title>memberMyLike</title>
	<style>
		.gear {
			height: 55px;
			margin-top:0px !important;
		}
		#admin > font{
			display: none;
		}
		.mypageMenu:hover {
			text-decoration: none;
			color: #333;
		}
		.pageTitle {
			font-size: 25px;
			font-weight: bold;
			margin-top: -40px;
		}
		th {
			background-color: #eee;
		}
		th, td{
			border-bottom: 1px solid lightgray !important;
		}
		.btn-red-border {
			border-color: #fc2020 !important;
		    color: #fc2020 !important;
		    border-radius: 0px !important;
		    width:121px !important;
		    height:33px !important;
		    
		}
		.btn-gray-border {
			border-color: #9DB2BF !important;
		    color: #9DB2BF !important;
		    border-radius: 0px !important;
		    width:121px !important;
		    height:33px !important;
		}
		.btn-red {
			border-color: #fc2020 !important;
		    color: #fff !important;
		    background: #fc2020 !important;
		    border-radius: 0px !important;
		    width:121px !important;
		    height:33px !important;
		}
		td {
			vertical-align: middle !important;
		}
		.redbackgournd {
			border-color: #fc2020 !important;
			background-color: #fc2020 !important;
		}
		
		.detailGO a:hover {
			color: black;
		}
	</style>
	<script>
		'use strict';
		
		 if(${pageVO.pag} > ${pageVO.totPage}) location.href="${ctp}/member/memberMyLike?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}";
		
		 function myLikeDel(idx) {
			 let ans = confirm("해당 상품을 관심상품리스트에서 삭제하시겠습니까?");
			 if(!ans) return false;
			 
			 $.ajax({
				 type:"post",
				 url : "${ctp}/member/myLikeDelete",
				 data : {idx : idx},
				 success : function(res) {
					 if(res == "1") {
						 alert("상품이 관심상품리스트에서 삭제되었습니다.");
						 location.reload();
					 }
					 else alert("상품 삭제 실패");
				 },
				 error : function() {
					 alet("전송오류~");
				 }
			 });
		 }
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<div class="container">
	<div class="mt-5 myPage">마이페이지</div>
	<div class="row">
		<div class="col-3 mt-2">
			<a href="${ctp}/member/memberMyOrder" class="mypageMenu myMenu">주문내역조회</a>
			<a href="${ctp}/member/memberMyLike" class="mypageMenu myMenu myMenuOn">관심상품</a>
			<div class="myMenu">적립금</div>
			<a href="${ctp}/member/memberMyCoupon" class="mypageMenu myMenu">쿠폰</a>
			<div class="myMenu">1:1문의</div>
			<div class="myMenu">나의 게시물</div>
			<div class="myMenu">멤버십 혜택</div>
			<div class="myMenu">개인정보수정</div>
		</div>
		<div class="col-9">
			<div class="pageTitle">관심상품</div>
			<hr style="border:1px solid black; margin:10px 0 0 0;"/>
			<table class="table table-borderless">
				<tr class="text-center">
					<th>이미지</th>
					<th>상품정보</th>
					<th>판매가</th>
					<th></th>
				</tr>
				<c:forEach var="likeVO" items="${likeVOS}" varStatus="st">
					<tr class="text-center">
						<td><img src="${ctp}/data/shop/product/${likeVO.FSName}" width="80px"/></td>
						<td class="detailGO"><a href="${ctp}/shop/shopDetail?idx=${likeVO.idx}">${likeVO.productName}</a></td>
						<td><b><fmt:formatNumber value="${likeVO.productPrice}"/>원</b></td>
						<td>
							<div><input type="button" value="상품상세" onclick="location.href='${ctp}/shop/shopDetail?idx=${likeVO.idx}';" class="btn btn-red mb-1"/></div>
							<div><input type="button" value="삭제" onclick="myLikeDel(${likeVO.idx})" class="btn btn-gray-border"/></div>
						</td>
					</tr>
				</c:forEach>
			</table>
			<!-- 블록 페이징 처리 -->
			<div class="text-center m-4">
				<ul class="pagination justify-content-center">
					<c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberMyLike?pageSize=${pageVO.pageSize}&pag=1">&lt;&lt;</a></li></c:if>
					<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberMyLike?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">&lt;</a></li></c:if>
					<c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
						<c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item"><a class="page-link text-white redbackgournd" href="${ctp}/member/memberMyLike?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
						<c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberMyLike?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
					</c:forEach>
					<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberMyLike?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">&gt;</a></li></c:if>
					<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberMyLike?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}">&gt;&gt;</a></li></c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>