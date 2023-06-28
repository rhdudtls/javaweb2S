<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		#blackline {
		    content: "";
		    display: inline-block;
		    width: 22px;
		    position: absolute;
		    height: 1px;
		    background: black;
		    margin-top : -2px;
		}
		#line {
			border-top: 1px solid #eee;	
		}
		#verticalline {
			margin-top:30px;
			border-left : 1px solid #eee;
  			height : 130px;
		}
		.info {
			font-size:14px;
		}
		.info span {
			color:gray;
		}
	</style>
</head>
<body>
<div class="container p-0">
	<div class="mb-2">
		<span>회사소개</span><font size="2" color="#BDCDD6">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
		<span>이용약관</span><font size="2" color="#BDCDD6">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
		<span>쇼핑몰 이용안내</span><font size="2" color="#BDCDD6">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
		<span><b>개개인정보취급방침</b></span><font size="2" color="#BDCDD6">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
		<span>공지사항</span>
	</div>
	<div id="line"></div>
	<div class="mt-3">
		<div class="row">
			<div class="col-3">
				<div class="mb-3">CALL CENTER</div>
				<div id="blackline"></div>
				<div class="mt-4 mb-3"><font size="5"><b>1600-9268</b></font></div>
				<div class="info"><span>평일</span> 오전 09:00 ~ 오후 05:00</div>
				<div class="info"><span>점심</span> 오후 12:00 ~ 오후 01:00</div>
				<div class="info"><span >휴무</span> 토/일/공휴일은 휴무</div>
			</div>
			<div class="col-1">
				<div id="verticalline"></div>
			</div>
			<div class="col-8">
				<div class="mb-3">COMPANY INFO</div>
				<div id="blackline"></div>
				<div class="info mt-4 pt-2">
					<span>회사명</span> 미트리(주) &nbsp;&nbsp;
					<span>대표</span> 이옥진 &nbsp;&nbsp;
					<span>대표전화</span> 1600-9268
				</div>
				<div class="info">
					<span>주소</span> 46985 부산광역시 사상구 학감대로 252 (감전동) 7층, 미트리
				</div>
				<div class="info">
					<span>사업자 등록번호</span> 606-86-57741 &nbsp;&nbsp;
					<span>통신판매업 신고</span> 제2014-부산사상구-0187호 [사업자정보확인]
				</div>
				<div class="info">
					<span>개인정보관리책임자</span> 김민석 ( metree2020@nate.com )
				</div>
				<div class="info">
					<span>COPYRIGHT ⓒ</span> 마이닭 <span>ALL RIGHTS RESERVED.</span>
				</div>
				<div class="info">
					<span>made by</span> Ko yeong sin
				</div>
			</div>
		</div>
	</div>
</div>
<p><br/></p>
</body>
</html>