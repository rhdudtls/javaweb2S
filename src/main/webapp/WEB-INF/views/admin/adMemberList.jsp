<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
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
		.btn-pink {
			background-color: #FCAEAE !important;
		}
		.adminselect {
			width: 100px !important;
		    height: 35px !important;
		    border: 1px solid #e1e1e1 !important;
			border-bottom: 1px solid #e1e1e1 !important;
			box-sizing: border-box !important;
			outline:none !important;
		}
		.admininput {
			padding: 0 15px;
		    width: 40%;
		    height: 35px;
		    border: 1px solid #e1e1e1;
			border-bottom: 1px solid #e1e1e1;
			box-sizing: border-box;
			outline:none;
		}
	</style>
	<script>
		'use strict';
		let allCheckSw = 0;
		let allSCheckSw = 0;
		let temp = "";
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
				$("input[name=memCheckbox]").prop("checked", true);
				document.getElementById('allCk').value = "전체해제";
			}
			else {
				$("input[name=memCheckbox]").prop("checked", false);
				document.getElementById('allCk').value = "전체선택";
			}
		}
		
		function allSCheck() {
			allSCheckSw++;
			if(allSCheckSw % 2 == 1) {
				$("input[name=searchCheckbox]").prop("checked", true);
				document.getElementById('allSCk').value = "전체해제";
			}
			else {
				$("input[name=searchCheckbox]").prop("checked", false);
				document.getElementById('allSCk').value = "전체선택";
			}
		}
		
		function allReverse() {
			$('[name=memCheckbox]').prop('checked', function(i, val){ return !val });
		}
		
		function allSReverse() {
			$('[name=searchCheckbox]').prop('checked', function(i, val){ return !val });
		}
		
		function ChoiceDel(flag) {
			let chk_Val = [];
			
			if(flag == 1){
				$('input:checkbox[name=memCheckbox]').each(function (index) {
					if($(this).is(":checked")==true){
						chk_Val.push($(this).val());
				    }
				});
			}
			else {
				$('input:checkbox[name=searchCheckbox]').each(function (index) {
					if($(this).is(":checked")==true){
						chk_Val.push($(this).val());
				    }
				});
			}
			
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
			location.reload();
		}
		
		function applyDel() {
			let ans = confirm("30일이 지나면 자동으로 탈퇴됩니다. 지금 탈퇴시키겠습니까?");
			if(!ans) return false;
			
			memberDelete(0);
			alert("회원 탈퇴 완료!");
			location.reload();
		}
		
		function memberSearch() {
			let searchType = $("#searchType").val();
			let searchString = $("#searchString").val();
			let str = "";
			let count = 1;
			let searchTypeKo = "";
			if(searchType == 'mid') searchTypeKo = '아이디';
			else if(searchType == 'name') searchTypeKo = '성명';
			else if(searchType == 'nickName') searchTypeKo = '닉네임';
			
			if(searchString == "") {
				alert("검색어를 입력하세요.");
				return false;
			}
			
			$.ajax({
				type:"post",
				url : "${ctp}/admin/adMemberList",
				dataType : "json",
				data : {searchType : searchType, searchString : searchString},
				success : function(vosSearch) {
					str += '<div class="text-center"><b><font color="blue">'+ searchString +'</font>을(를)<font color="blue" >'+ ' ' + searchTypeKo + '</font>에서 검색하신 결과 총<font color="red">'+ ' ' + vosSearch.length + '</font>건을 찾았습니다.</b></div>';
					str += '<div class="text-right mb-2">';
					str += '<span><input type="button" id="allSCk" value="전체선택" onclick="allSCheck()" class="btn btn-orange btn-sm mr-2"/></span>';
					str += '<span><input type="button" value="전체반전" onclick="allSReverse()" class="btn btn-pink btn-sm mr-2"/></span>';
					str += '<button type="button" class="btn btn-info btn-sm mr-2 dropdown-toggle" data-toggle="dropdown">등급변경</button>';
					str += '<div class="dropdown-menu"><a class="dropdown-item" href="javascript:adLevelUpdate(0,3)">BRONZE로 변경</a><a class="dropdown-item" href="javascript:adLevelUpdate(0,2)">SILVER로 변경</a>';
					str += '<a class="dropdown-item" href="javascript:adLevelUpdate(0,1)">GOLD로 변경</a><a class="dropdown-item" href="javascript:adLevelUpdate(0,0)">관리자로 변경</a></div>';
					str += '<span><input type="button" onclick="dbPointUpdate()" value="포인트 변경" class="btn btn-success btn-sm mr-2"/></span>';
					str += '<button type="button" class="btn btn-danger btn-sm" onclick="ChoiceDel(0)">선택회원삭제</button>';
					str += '</div>';
					str += '<table class="table table-bordered"><tr><th>번호</th><th>아이디</th><th>성명</th><th>닉네임</th><th>성별</th><th>등급</th><th>포인트</th><th>탈퇴신청</th><th>최근방문일자</th><th>비고</th></tr>';
					$(vosSearch).each(function(){
						str += '<tr class="text-center">';
						str += '<td>'+count+'</td>';
						str += '<td>'+this.mid+'</td>';
						str += '<td>'+this.name+'</td>';
						str += '<td>'+this.nickName+'</td>';
						str += '<td>'+this.gender+'</td>';
						if(this.level == 3) str += '<td>BRONZE</td>';
						else if(this.level == 2) str += '<td>SILVER</td>';
						else if(this.level == 1) str += '<td>GOLD</td>';
						else str += '<td>관리자</td>';
						str += '<td ondblclick="pointUpdate('+this.idx+','+this.point+', 0)" id="point__'+this.idx+'">'+this.point+'</td>';
						str += '<td>'+this.memberDel+'</td>';
						str += '<td>'+this.lastVisitDate.substring(0,16)+'</td>';
						str += '<td><input type="checkbox" name="searchCheckbox" value="'+this.idx+'"/></td>';
						str += '</tr>';
						count++;
					});
					str += '</table>'
					document.getElementById('sModalBtn').click();
					$("#searchModal").css("display", "block");
					$("#searchContent").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
		
		function adLevelUpdate(flag, level) {
			let chk_Val = [];
			
			if(flag == 1){
				$('input:checkbox[name=memCheckbox]').each(function (index) {
					if($(this).is(":checked")==true){
						chk_Val.push($(this).val());
				    }
				});
			}
			else {
				$('input:checkbox[name=searchCheckbox]').each(function (index) {
					if($(this).is(":checked")==true){
						chk_Val.push($(this).val());
				    }
				});
			}
			
			if(chk_Val.length == 0) {
				alert("회원을 선택하세요.")
				return false;
			}
			
			for(let idx of chk_Val) {
				$.ajax({
					type : "post",
					url : "${ctp}/admin/adLevelUpdate",
					data : {idx : idx, level : level},
					success : function(res) {
						if(res != "1") alert("중간오류!");
					},
					error : function() {
						alert("전송오류!");
					}
				});
			}
			
			alert("회원 등급 수정 완료!");
			location.reload();
			
		}
		function pointUpdate(idx, point, flag) {
			let pointId;
			if(flag == 1) pointId = "point_" + idx;
			else pointId = "point__" + idx;
			
			$("#" + pointId).html("<input class='form-control' type='number' name='" + pointId +"' id='" + idx + "' value='" + point + "' autofocus style='width:100px'/>");
			temp += pointId + "/";
		}
		
		function dbPointUpdate() {
			let pointArray = temp.split("/");
			if(pointArray == "") {
				alert("변경사항이 없습니다.");
				return false;
			}
			
			console.log(pointArray);
			
			for(let i=0; i < pointArray.length-1; i++){
				let idx = pointArray[i].substring(pointArray[i].length-1, pointArray[i].length);
				let pointVal = $("input[name="+pointArray[i]+"]").val();
				
				$.ajax({
					type : "post",
					url : "${ctp}/admin/adPointUpdate",
					data : {idx : idx, point : pointVal},
					success : function(res) {
						if(res != "1") alert("중간오류!");
					},
					error : function() {
						alert("전송오류!");
					}
				});
				
			}
			
			alert("포인트 수정 완료!");
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
				<form name="searchForm" method="post" action="javascript:memberSearch()">
				  <select name="searchType" id="searchType" class="adminselect">
				    <option value="mid" selected>아이디</option>
				    <option value="name">성명</option>
				    <option value="nickName">닉네임</option>
				  </select>
				  <input type="text" name="searchString" id="searchString" class="admininput" />
				  <button type="button" onclick="memberSearch()" class="btn btn-orange" style="margin-bottom:5px;"><i class="fa-solid fa-magnifying-glass"></i></button>
				</form>
			</div>
			<div class="col text-right mt-2">
				<div class="row">
					<input type="button" id="allCk" value="전체선택" onclick="allCheck()" class="btn btn-orange btn-sm mr-2"/>
					<input type="button" value="전체반전" onclick="allReverse()" class="btn btn-pink btn-sm mr-2"/>
					<div class="dropdown mr-2">
						<button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown">등급변경</button>
						<div class="dropdown-menu">
						  <a class="dropdown-item" href="javascript:adLevelUpdate(1,3)">BRONZE로 변경</a>
						  <a class="dropdown-item" href="javascript:adLevelUpdate(1,2)">SILVER로 변경</a>
						  <a class="dropdown-item" href="javascript:adLevelUpdate(1,1)">GOLD로 변경</a>
						  <a class="dropdown-item" href="javascript:adLevelUpdate(1,0)">관리자로 변경</a>
						</div>
					</div>
					<input type="button" onclick="dbPointUpdate()" value="포인트 변경" class="btn btn-success btn-sm mr-2"/>
					<div class="dropdown">
						<button type="button" class="btn btn-danger btn-sm dropdown-toggle" data-toggle="dropdown">회원탈퇴</button>
						<div class="dropdown-menu">
						  <a class="dropdown-item" href="javascript:ChoiceDel(1)">선택회원삭제</a>
						  <a class="dropdown-item" href="javascript:applyDel()">탈퇴신청회원삭제</a>
						</div>
					</div>
				</div>
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
				<th>비고</th>
				<th></th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr class="text-center">
					<td>${st.count}</td>
					<td>${vo.mid}</td>
					<td>${vo.name}</td>
					<td>${vo.nickName}</td>
					<td>${vo.gender}</td>
					<td>
						<c:if test="${vo.level == 3}">BRONZE</c:if>
						<c:if test="${vo.level == 2}">SILVER</c:if>
						<c:if test="${vo.level == 1}">GOLD</c:if>
						<c:if test="${vo.level == 0}">관리자</c:if>
					</td>
					<td>
						<c:if test="${vo.memberDel == 'NO'}">${vo.memberDel}</c:if>
						<c:if test="${vo.memberDel == 'YES'}">
							<input type="button" value="${vo.memberDel}" onclick="oneMemDel(${vo.idx})" class="btn btn-danger btn-sm"/>
						</c:if>
					</td>
					<td ondblclick="pointUpdate(${vo.idx},${vo.point},1)" id="point_${vo.idx}">${vo.point}</td>
					<td>${vo.snsCheck}</td>
					<td>${fn:substring(vo.lastVisitDate,0,16)}</td>
					<td><input type="button" value="정보수정" class="btn btn-warning btn-sm"/></td>
					<td><input type="checkbox" name="memCheckbox" value="${vo.idx}"/></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<input type="button" id="sModalBtn" data-toggle="modal" data-target="#searchModal" style="display:none"/>
	<!-- 회원검색 모달창 -->
	<div class="modal fade" id="searchModal">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">검색목록</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	      	<div class="text-center mb-3">
	      	</div>
	        <div id="searchContent"></div>
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