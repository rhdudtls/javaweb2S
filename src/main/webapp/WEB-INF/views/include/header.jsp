<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	int level = session.getAttribute("sLevel")==null? 99 : (int)session.getAttribute("sLevel");
	pageContext.setAttribute("level", level);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="stylesheet" href="${ctp}/css/header.css">
	<style>
		.top_icon {
			padding-right:12px;
			color:black;
		}
		#search_input {
			width: 100%;
			height:50px;
			border: 0px #fff;
			border-radius: 25px;
			padding: 10px 12px;
			font-size: 14px;
			background-color: #F8F6F4;
			outline:none;
		}
		.category_right a, .category_right a:hover {
			text-decoration: none !important;
			color:gray !important;
		}
		.whole_category_main {
			padding-left:30px;
			height:53px;
			color: #000000;
		}
		
		.whole_category_main:hover {
			background-color: #2C3333;
			color : white;
		}
		
		.whole_category_main:hover .idvline{
			color : #2C3333 !important;
		}
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
	<div class="row">
		<div class="col-3">
			<a href="${ctp}/"><img src="${ctp}/images/top_logo.png"/></a>
		</div>
		<div class="col-6 search">
			<input type="text" id="search_input" placeholder="닭가슴살은 역시 마이닭!">
			<img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
		</div>
		<div class="col-3 mt-2" style="font-size:2.5em;">
			<div class="row">
				<c:if test="${1 <= level && level <= 3}">
					<div class="col-3 mt-3 pl-3 pr-0">
						<span style="font-size:16px;">
							${sNickName}님
						</span>
					</div>
				</c:if>
				<c:if test="${level == 0}">
					<div class="col-3 mt-2 pl-5">
						<a href="${ctp}/admin/adminMain"><i class="fa-solid fa-gear top_icon text-center"><font size="1">관리자</font></i></a>
					</div>
				</c:if>
				<div class="col-9 text-right">
					<i class="fa-regular fa-user top_icon"></i>
					<i class="fa-solid fa-cart-shopping top_icon" style="padding-right:15px;"></i>
					<i class="fa-regular fa-calendar-check top_icon"></i>
				</div>
			</div>
		</div>
	</div>
	<div class="row mt-4" style="line-height:50px">
		<div class="col-8">
			<div class="row">
				<div class="whole_category_main pb-0 mb-0">
					<span><i class="fa-solid fa-bars fa-2x" style="padding-top:10px;">&nbsp;</i></span>
					<span class="whole_category" style="margin-right:25px;">전체 카테고리</span>
					<span class="category_left idvline" style="font-size:18px; color:gray; margin-right:0px">|</span>
				</div>
				<span class="category_left" style="margin-left:28px;">신제품</span>
				<span class="category_left">베스트</span>
				<span class="category_left">할인특가</span>
				<span class="category_left">1팩담기</span>
				<span class="category_left">식사대용</span>
			</div>
		</div>
		<div class="col-4 text-right category_right">
			<c:if test="${level < 0 || level > 3}">
				<a href="${ctp}/member/memberLogin">로그인</a>&nbsp;&nbsp;|
				<a href="${ctp}/member/memberJoinType">회원가입</a>&nbsp;&nbsp;|
			</c:if>
			<c:if test="${0 <= level && level <= 3}">
				<a href="${ctp}/member/memberLogout">로그아웃</a>&nbsp;&nbsp;|
				<a href="${ctp}/member/memberJoinType">적립금</a>&nbsp;&nbsp;|
			</c:if>
			<span>주문조회</span>&nbsp;&nbsp;|
			<span>공지사항</span>&nbsp;&nbsp;|
			<span>이벤트</span>
		</div>
	</div>
</div>
</body>
</html>