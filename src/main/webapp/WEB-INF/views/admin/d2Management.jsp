<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<title>d2Management.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		#categoryMain {
			padding : 30px 0 0 30px;
			width:500px;
			height:741px;
			border: 1px solid lightgray;
			font-size:20px;
			line-height: 50px;
		}
		#categoryMain a{
			color:black;
			text-decoration: none;
		}
		.inputUd {
			width:200px;
			height:40px;
			border-top: none;
			border-left: none;
			border-right: none;
			border-bottom: 2px solid black;
			outline: none;
			background-color: #EEF1FF;
		}
		.codeIn {
			width:80px;
			height:30px;
			border-top: none;
			border-left: none;
			border-right: none;
			border-bottom: 2px solid black;
			outline: none;
			background-color: #EEF1FF;
		}
		.nameIn {
			width:150px;
			height:30px;
			border-top: none;
			border-left: none;
			border-right: none;
			border-bottom: 2px solid black;
			outline: none;
			background-color: #EEF1FF;
		}
		.mainName-up:before {
			content : "▶";
			style:font-size:18px;
		}
		.mainName-down:before {
			content : "▼";
			style:font-size:18px;
		}
	</style>
	<script>
		'use strict';
		
		function showSub(code) {
			$("#categorySubList" + code).toggle();
			$("#mainName"+code).toggleClass('mainName-up'); 
			$("#mainName"+code).toggleClass('mainName-down');
		}
		
		function categorySubDelete(code) {
			let ans = confirm("해당 소분류를 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/categoryDelete",
				data : {flag : "categorySubCode", code : code},
				success : function(res) {
					if(res == "1") alert("소분류 삭제 완료!");
					else alert("소분류 삭제 실패!");
					location.reload();
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
	</script>
</head>
<body style="background-color:#EEF1FF">
<div class="top">
	<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"/>
</div>
<div class="left">
	<jsp:include page="/WEB-INF/views/admin/adminMenu.jsp"/>
</div>
<p><br/></p>
<div class="container">
	<div class="row">
		<div class="mb-3" style="font-size:25px;"><b>소분류 목록</b></div>
		<div class="mb-3" style="font-size:25px; padding-left:510px;">
			<b>소분류 수정</b>
			<div style="font-size:15px;">소분류 목록에서 수정할 내역을 선택하세요!</div>
		</div>
	</div>
	<div class="row">
		<div id="categoryMain" class="col pt-0 mt-0">
			<font color="#4A55A2">[대분류명 / 소분류 코드 / 소분류명]</font>
			<c:forEach var="vom" items="${vosMain}" varStatus="stm">
				<div>
					<c:if test="${vom.cnt != 0}">
						<a href="javascript:showSub('${vom.categoryMainCode}')" id="mainName${vom.categoryMainCode}" class="mainName-up">${vom.categoryMainName}</a>
					</c:if>
					<c:if test="${vom.cnt == 0}">
						${vom.categoryMainName}
					</c:if>
					<div id="categorySubList${vom.categoryMainCode}" style="display:none;">
						<c:forEach var="vos" items="${vosSub}" varStatus="sts">
							<div style="font-size:15px; line-height: 30px;">
								<c:if test="${vom.categoryMainCode == vos.categoryMainCode}">
									<span>└${vos.categorySubCode}</span>&nbsp;&nbsp;
									<span>${vos.categorySubName}</span>
									<span> - - - - - </span>
									<span><i class="fa-regular fa-pen-to-square"></i></span>&nbsp;
									<a href="javascript:categorySubDelete('${vos.categorySubCode}')"><i class="fa-solid fa-xmark"></i></a>
								</c:if>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="col">
			<div id="categoryMain" style="margin-left:100px; height:300px; padding-top:20px;">
				<font color="#4A55A2">대분류 코드</font><p><input type="text" name="codeUd" id="codeUd" class="inputUd" readonly/></p>
				<font color="#4A55A2">대분류명</font><p><input type="text" name="nameUd" id="nameUd" class="inputUd"/></p>
				<div class="mb-2 pr-3 text-right"><input type="button" value="수정" onclick="categoryMainUpdate()" class="btn btn-warning"/></div>
			</div>
			<div class="mb-2 mt-5" style="font-size:25px; padding-left:100px;"><b>대분류 추가</b></div>
			<div id="categoryMain" style="margin-left:100px; height:350px; padding-top:20px;">
				<font size="4" color="#4A55A2">대분류 코드</font>
				<font size="4" color="#4A55A2" style="padding:0 70px 0 50px;">대분류명</font> - - - - - 
				<input type="button" value="입력박스추가" onclick="categoryMainInputAdd()" class="btn btn-success"/>
				<div style="margin-top:-15px">
					<input type="text" name="codeIn" id="codeIn1" class="codeIn mr-5"/>
					<input type="text" name="nameIn" id="nameIn1" class="nameIn"/>
				</div>
				<div id="demoInput"></div>
				<input type="button" value="대분류 추가" onclick="categoryMainInput()" class="btn btn-orange" style="margin-left:170px;"/>
			</div>
		</div>
	</div>
</div>
</body>
</html>