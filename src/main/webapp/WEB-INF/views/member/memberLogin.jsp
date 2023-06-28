<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>memberLogin.jsp</title>
	<link rel="stylesheet" href="${ctp}/css/mydak.css">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<p><br/></p>
<div class="container">
  <input type="button" value="&lt; 뒤로가기" onclick="location.href='${ctp}/';" class="btn login_back"/>
  <div class="modal-dialog">
	  <div class="modal-content p-4">
	  	  <a href="${ctp}/" class="text-center mb-4"><img src="${ctp}/images/top_logo.png"/></a>
		  <h2>로그인</h2>
		  <div class="mt-2 mb-4"><font size="3">아이디와 비밀번호 입력하기 귀찮으시죠?<br/>카카오로 1초 만에 로그인 하세요.</font></div>
		  <a href="#"><img src="${ctp}/images/kakao_login.jpg" width="100%"/></a>
		  <div class="hr-sect mb-2">또는</div>
		  <div class="login_type text-center mb-4 mt-3">
			  <input type="button" value="기존 회원이세요?" class="btn login_member active mr-0"/>
			  <input type="button" value="비회원 배송조회" class="btn login_memberNo"/>
		  </div>
		  <form name="myform" method="post" action="${ctp}/member/memberLogin">
		    <div class="form-group input_login_info">
		      <input type="text" name="mid" id="mid" value="${mid}" placeholder="아이디" required autofocus />
		      <input type="password" name="pwd" id="pwd" placeholder="비밀번호" required />
		    </div>
		    <div>
			    <input type="checkbox" name="idSave" id="remember_me" class="checkbox" checked />
			    <label for="remember_me"> 아이디 저장</label>
		    </div>
		    <div class="form-group text-center">
		    	<button type="submit" class="btn btn-dark form-control" style="height:45px;"><b>기존 회원 로그인</b></button>
		    </div>
		    <div class="row aTag">
		      <span class="col" style="font-size:14px">
		        <a href="${ctp}/MemberIdSearch.mem"><span>아이디 찾기</span></a> |
		        <a href="${ctp}/MemberPwdSearch.mem"><span>비밀번호 찾기</span></a>
		      </span>
		      <a href="${ctp}/member/memberJoinType" class="text-right pr-3">가입하기</a>
		    </div>
		  </form>
	  </div>
  </div>
</div>
<p><br/></p>
</body>
</html>