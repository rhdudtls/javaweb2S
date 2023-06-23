<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${ctp}/css/headerTop.css">
<script>
	'use strict';
	
	function clickCheck() {
		
	}
</script>
<div class="container dropdown text-right">
	<div>
		<a href="${ctp}/">회원가입</a> &nbsp;&nbsp;|&nbsp;
		<a href="${ctp}/">로그인</a> &nbsp;|&nbsp;
		<a href="${ctp}/">고객센터</a>
		<a href="javascript:clickCheck()" data-toggle="dropdown">▼</a>
	    <div class="dropdown-menu dropdown-menu-right">
	    	<div class="menu-list">
			    <a href="#">공지사항</a><br/>
			    <a href="#">이용안내</a><br/>
			    <a href="#">자주묻는 FAQ</a><br/>
			    <a href="#">1:1 문의하기</a>
			</div>
	    </div>
    </div>
    
    <div class="row text-left">
    	<img src="${ctp}/resources/images/logo.jpg" class="logo"/>
    	<div class="search">
		  <input type="text" placeholder="검색어 입력" id="searchInput">
		  <i class="fa fa-fw fa-search fa-2x mt-3"></i>
		</div>
    </div>
</div>