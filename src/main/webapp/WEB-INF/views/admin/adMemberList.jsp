<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<title>adMemberList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		th {
			text-align:center !important;
			background-color:#CCD5AE;
		}
		
		.btn-orange {
			background-color: #FFD6A5 !important;
		}
	</style>
	<script>
		'use strict';
		let allCheckSw = 0;
		function oneMemDel(idx) {
			let ans = confirm("30일이 지나면 자동으로 탈퇴됩니다. 지금 탈퇴시키겠습니까?");
			if(!ans) return false;
			
			memberDelete(idx);
			alert("회원 탈퇴 완료!");
			location.reload();
		}
		
		function memberDelete(idx) {
			$.ajax({
				type:"post",
				url:"${ctp}/admin/memberDelete",
				data : {idx : idx},
				success : function(res) {
					if(res == "0") alert("회원 탈퇴 실패");
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
		
		function allCheck() {
			allCheckSw++;
			if(allCheckSw % 2 == 1) {
				$("input[name=memDelList]").prop("checked", true);
				document.getElementById('allCk').value = "전체해제";
			}
			else {
				$("input[name=memDelList]").prop("checked", false);
				document.getElementById('allCk').value = "전체선택";
			}
		}
		
		function allReverse() {
			$('[name=memDelList]').prop('checked', function(i, val){ return !val });
		}
		
		function ChoiceDel() {
			let chk_Val = [];
			$('input:checkbox[name=memDelList]').each(function (index) {
				if($(this).is(":checked")==true){
					chk_Val.push($(this).val());
			    }
			});
			
			if(chk_Val.length == 0) {
				alert("회원을 선택하세요.")
				return false;
			}
			
			let ans = confirm("선택한 회원들을 탈퇴시키겠습니까?");
			if(!ans) return false;
			
			
			for(let idx of chk_Val) {
				memberDelete(idx);
			}
			
			alert("회원 탈퇴 완료!");
			$('#delModal').modal('hide');
			location.reload();
		}
		
		function applyDel() {
			let ans = confirm("30일이 지나면 자동으로 탈퇴됩니다. 지금 탈퇴시키겠습니까?");
			if(!ans) return false;
			
			memberDelete(0);
			alert("회원 탈퇴 완료!");
			$('#delModal').modal('hide');
			location.reload();
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
			<div class="col">
				<div class="mb-2" style="font-size:25px;"><b>회원 목록</b></div>
			</div>
			<!-- 검색기 처리 -->
			<div class="col">
				<form name="searchForm" method="post" action="${ctp}/ChangeSearch.ch">
				  <select name="search">
				    <option value="title" selected>아이디</option>
				    <option value="nickName">닉네임</option>
				    <option value="content">회원번호</option>
				  </select>
				  <input type="text" name="searchString" id="searchString"/>
				  <input type="button" value="검색" onclick="searchCheck()" class="btn btn-secondary btn-sm"/>
				</form>
			</div>
			<div class="col text-right mt-2">
				<span><input type="button" value="등급 변경" class="btn btn-info btn-sm"/></span>
				<span><input type="button" value="포인트 변경" class="btn btn-success btn-sm"/></span>
				<span><input type="button" value="회원 탈퇴" data-toggle="modal" data-target="#delModal" class="btn btn-danger btn-sm"/></span>
			</div>
		</div>
		<table class="table table-bordered">
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>성명</th>
				<th>닉네임</th>
				<th>성별</th>
				<th>등급</th>
				<th>탈퇴신청</th>
				<th>포인트</th>
				<th>sns 동의</th>
				<th>최근방문일자</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr class="text-center">
					<td>${st.count}</td>
					<td>${vo.mid}</td>
					<td>${vo.name}</td>
					<td>${vo.nickName}</td>
					<td>${vo.gender}</td>
					<td>${vo.level}</td>
					<td>
						<c:if test="${vo.memberDel == 'NO'}">${vo.memberDel}</c:if>
						<c:if test="${vo.memberDel == 'YES'}">
							<input type="button" value="${vo.memberDel}" onclick="oneMemDel(${vo.idx})" class="btn btn-danger btn-sm"/>
						</c:if>
					</td>
					<td onclick="callback()" class="editable">${vo.point}</td>
					<td>${vo.snsCheck}</td>
					<td>${fn:substring(vo.lastVisitDate,0,16)}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<!-- 회원탈퇴 모달창 -->
	<div class="modal fade" id="delModal">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">회원목록</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	      	<div class="text-center mb-3">
	      		<span><input type="button" id="allCk" value="전체선택" onclick="allCheck()" class="btn btn-orange btn-sm"/></span>
	      		<span><input type="button" value="전체반전" onclick="allReverse()" class="btn btn-orange btn-sm"/></span>
	      		<span><input type="button" value="선택회원삭제" onclick="ChoiceDel()" class="btn btn-orange btn-sm"/></span>
	      		<span><input type="button" value="탈퇴신청회원삭제" onclick="applyDel()" class="btn btn-orange btn-sm"/></span>
	      	</div>
	        <table class="table table-bordered">
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>성명</th>
					<th>닉네임</th>
					<th>성별</th>
					<th>등급</th>
					<th>탈퇴신청</th>
					<th>최근방문일자</th>
					<th>비고</th>
				</tr>
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<tr class="text-center">
						<td>${st.count}</td>
						<td>${vo.mid}</td>
						<td>${vo.name}</td>
						<td>${vo.nickName}</td>
						<td>${vo.gender}</td>
						<td>${vo.level}</td>
						<td>
							<c:if test="${vo.memberDel == 'NO'}">${vo.memberDel}</c:if>
							<c:if test="${vo.memberDel == 'YES'}">
								<input type="button" value="${vo.memberDel}" onclick="memberDelete(${vo.idx})" class="btn btn-danger btn-sm"/>
							</c:if>
						</td>
						<td>${fn:substring(vo.lastVisitDate,0,16)}</td>
						<td><input type="checkbox" name="memDelList" value="${vo.idx}"/></td>
					</tr>
				</c:forEach>
			</table>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>
</body>
</html>