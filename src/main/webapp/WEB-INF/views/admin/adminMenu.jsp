<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminMenu.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
		.btn-green {
			background-color: #E1ECC8 !important;
			border-radius:25px;
		}
	</style>
	<script>
        function collapse(element) {
            var before = document.getElementsByClassName("active")[0];              // 기존에 활성화된 버튼
            if (before && document.getElementsByClassName("active")[0] != element) {  // 자신 이외에 이미 활성화된 버튼이 있으면
                before.nextElementSibling.style.maxHeight = null;   // 기존에 펼쳐진 내용 접고
                before.classList.remove("active");                  // 버튼 비활성화
            }
            element.classList.toggle("active");         // 활성화 여부 toggle

            var content = element.nextElementSibling;
            if (content.style.maxHeight != 0) {         // 버튼 다음 요소가 펼쳐져 있으면
                content.style.maxHeight = null;         // 접기
            } else {
                content.style.maxHeight = content.scrollHeight + "px";  // 접혀있는 경우 펼치기
            }
        }
    </script>
</head>
<body>
<hr style="margin:0; background:gray;height:1px;border:0;"/>
	<h3 class="text-light text-center mt-4 mb-4 ml-0">MY DAK🍗</h3>
	<button type="button" class="collapsible" onclick="collapse(this);">회원</button>
    <div class="content">
       <p style="padding-left:8px;"><a href="${ctp}/admin/adMemberList">회원 관리</a><p>
    </div>
    <button type="button" class="collapsible" onclick="collapse(this);">상품</button>
    <div class="content">
         <p><a href="${ctp}/admin/d1Management">대분류 관리</a><p>
         <p><a href="${ctp}/admin/d2Management">소분류 관리</a><p>
         <p style="padding-left:5px;"><a href="${ctp}/admin/productInput">상품 등록</a><p>
         <p style="padding-left:5px;"><a href="${ctp}/admin/productList">상품 목록</a><p>
         <p style="margin-left:-7px;"><a href="${ctp}/admin/productOption">상품 옵션 관리</a><p>
    </div>
    <button type="button" class="collapsible" onclick="collapse(this);">주문</button>
    <div class="content">
        <p style="padding-left:8px;">주문내역</p>
    </div>
    <button type="button" class="collapsible" onclick="collapse(this);">쿠폰</button>
    <div class="content">
        <p style="padding-left:8px;"><a href="${ctp}/admin/couponList">쿠폰 관리</a></p>
        <p style="padding-left:8px;"><a href="${ctp}/admin/couponGive">쿠폰 지급</a></p>
    </div>
    <div class="mt-5 text-center">
    	<a href="${ctp}/" class="btn btn-green"><b>홈으로 돌아가기</b></a>
    </div>
<p><br/></p>
</body>
</html>