<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/mydak.css">
	<title>memberAttend</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.gear {
			height: 55px;
			margin-top:0px !important;
		}
		#admin > font{
			display: none;
		}
		.dateGO a:hover {
			text-decoration: none;
			color: gray;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<div class="container">
	<img src="${ctp}/images/pc_stamp_banner.jpg"/>
	<div class="text-center mt-4 dateGO">
		<a href="${ctp}/member/memberAttend?yy=${yy}&mm=${mm-1}" title="이전월"><font size="6" color="gray">&lt;</font></a>
		<font size="6" color="#fc2020">&nbsp;&nbsp; ${yy}.${mm+1} &nbsp;&nbsp;</font>
		<a href="${ctp}/member/memberAttend?yy=${yy}&mm=${mm+1}" title="다음월"><font size="6" color="gray">&gt;</font></a>
  	</div>
  	<div class="text-center">
	    <table class="table table-bordered" style="height:450px">
	      <tr class="table-dark text-dark">
	        <th style="width:14%; vertical-align:middle; color:red">일</th>
	        <th style="width:14%; vertical-align:middle;">월</th>
	        <th style="width:14%; vertical-align:middle;">화</th>
	        <th style="width:14%; vertical-align:middle;">수</th>
	        <th style="width:14%; vertical-align:middle;">목</th>
	        <th style="width:14%; vertical-align:middle;">금</th>
	        <th style="width:14%; vertical-align:middle; color:blue">토</th>
	      </tr>
	      <tr>
	      	<!-- 시작일 이전을 공백처리한다. -->
	      	<c:set var="gap" value="1"/>
	      	<c:forEach begin="1" end="${startWeek - 1}">
	      	  <td>&nbsp;</td>
	      	  <c:set var="gap" value="${gap + 1}"/>
	      	</c:forEach>
	      	<!-- 해당월에 대한 첫째주 날짜부터 출력하되, gap이 7이되면 줄바꿈한다. -->
	      	<c:forEach begin="1" end="${lastDay}" varStatus="st">
	      	  <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}" />
	      	  <td id="td${gap}" ${todaySw==1 ? 'class=today' : ''}>${st.count}</td>
	      	  <c:if test="${gap % 7 == 0}"></tr><tr></c:if>
	      	  <c:set var="gap" value="${gap + 1}"/>
	      	</c:forEach>
	      </tr>
	    </table>
	</div>
</div>
<p><br/></p>
<hr style="border-top:1px solid lightgray; margin-top:0px;"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>