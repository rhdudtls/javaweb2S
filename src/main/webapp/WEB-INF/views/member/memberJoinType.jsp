<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>memberJoinType.jsp</title>
	<link rel="stylesheet" href="${ctp}/css/mydak.css">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<p><br/></p>
<div class="container">
	<input type="button" value="&lt; 뒤로가기" onclick="location.href='${ctp}/member/memberLogin';" class="btn login_back"/>
	<div class="modal-dialog">
		<div class="modal-content p-4">
			<a href="${ctp}/" class="text-center mb-4"><img src="${ctp}/images/top_logo.png"/></a>
			<h2>회원가입</h2>
			<div class="mt-2 mb-4"><font size="3">아이디, 비밀번호, 이름, 휴대번호 입력하기 귀찮으시죠?<br/>카카오로 1초 만에 회원가입 하세요.</font></div>
			<a href="#" class="mb-4"><img src="${ctp}/images/kakao_join.jpg" width="100%"/></a>
			<img src="${ctp}/images/banner_join_type.png"/>
			<div class="hr-sect mb-2">또는</div>
			<div class="text-center aTag"><a href="${ctp}/member/memberJoin"><b>일반회원가입</b></a></div>
		</div>
	</div>
</div>
<p><br/></p>
</body>
</html>