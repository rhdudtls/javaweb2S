<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<link rel="stylesheet" href="${ctp}/css/mydak.css">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr/>
<div class="container">
	<div class="text-center">
		<h2>회원 가입</h2>
		<div>지금 회원가입하면 바로 쓸 수 있는<font color="red"> 적립금 2,000원 지급!</font></div>
	</div>
	<hr style="border: solid 1px black;">
	<form name="myform" method="post">
		<div class="row">
			<div class="col content_title">기본정보</div>
			<div class="col text-right content_memo"><span style="color:red">*</span>필수입력사항</div>
		</div>
		<hr/>
	</form>
</div>
<p><br/></p>
</body>
</html>