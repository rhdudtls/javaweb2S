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
			width:600px;
			height:750px;
			border: 1px solid lightgray;
			font-size:20px;
			line-height: 50px;
		}
		#categoryMain a{
			color:black;
			text-decoration: none;
		}
		.mNameSelect {
			width: 40%;
		    height: 35px;
		    border: 1px solid #B5C99A;
			border-bottom: 1px solid #B5C99A;
			box-sizing: border-box;
			outline:none;
			font-size:17px;
		}
		.codeIn {
			width:100px;
			height:30px;
			border-top: none;
			border-left: none;
			border-right: none;
			border-bottom: 2px solid black;
			outline: none;
			background-color: #EEF1FF;
			margin-right:80px;
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
		.btn-orange {
			background-color: #FFD6A5 !important;
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
		let originSCode;
		let originSName;
		function categorySubUpdateInput(mName, sCode, sName) {
			originSCode = sCode;
			originSName = sName;
			$("#codeUd").val(sCode);
			$("#nameUd").val(sName);
			$("#mainNameSel").val(mName);
			$("#mainNameSel").attr('disabled', false);
			$("#mainNameSel option[value='']").remove();
		}
		
		function categorySubUpdate() {
			let sCode = $("#codeUd").val();
			let sName = $("#nameUd").val();
			let mName = $("#mainNameSel").val();
			
			let sCodeReg = /^[0-9]{3}$/;
			
			if(mName.trim() == "") {
				alert("수정할 소분류를 선택하세요!");
				return false;
			}
			else if(sCode == "") {
				alert("소분류 코드를 입력하세요!");
				return false;
			}
			else if(!sCodeReg.test(sCode)) {
				alert("소분류 코드는 숫자 세자리로 입력하세요!");
				return false;
			}
			else if(sName.trim() == "") {
				alert("소분류명을 입력하세요!");
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/categorySubUpdate",
				data : { mName : mName, sCode : sCode, sName : sName, originSCode : originSCode, originSName : originSName},
				success : function(res) {
					if(res == "2") {
						alert("소분류가 수정되었습니다.");
						location.reload();
					}
					else if(res == "1") alert("소분류 코드와 소분류명은 중복될 수 없습니다. 다시 입력하세요.");
					else if(res == "0") alert("소분류 수정 실패");
				},
				error : function() {
					alert("전송 오류!");
				}
			});
		}
		
		let count = 1;
		function categorySubInputAdd() {
			let str = "";
			
			if(count >= 3) {
				alert("소분류 추가는 한 번에 3개까지만 가능합니다.");
				return false;
			}
			
			count++;
			str+="<div id='inputAdd"+count+"'>";
			str+="<font size='4' color=''#4A55A2' style='padding-right:125px;'>대분류명</font>";
			str+="<font size='4' color=''#4A55A2' style='padding-right:20px;'>소분류 코드</font>";
			str+="<font size='4' color=''#4A55A2' style='padding:0 100px 0 50px;'>소분류명</font>";
			str+="<input type='button' value='삭제' onclick='categorySubInputDel("+count+")' class='btn btn-danger'/>";
			str+="<div class='mt-0'>";
			str+="<select name='mainNameInputSel' id='mainNameInputSel"+count+"' class='mNameSelect mr-5' style='width: 25%;'><c:forEach var='vom' items='${vosMain}' varStatus='stm'>";
			str+="<option value='${vom.categoryMainCode}'>${vom.categoryMainName}</option></c:forEach>";
			str+="<input type='text' name='codeIn' id='codeIn"+count+"' class='codeIn mr-5'/>";
			str+="<input type='text' name='nameIn' id='nameIn"+count+"' class='nameIn ml-1'/></div>";
			str+="</div>";
			
			$("#demoInput").append(str);
		}
		
		function categorySubInputDel(idx) {
			let divId = "inputAdd" + idx;
			$("#"+divId).remove();
			count--;
		}
		
		function categorySubInput() {
			let sCodeArr = [];
			let sNameArr = [];
			let mCodeArr = [];
			let sCodeReg = /^[0-9]{3}$/;
			
			for(let i = 1; i <= count; i++) {
				let sCode = $("#codeIn"+i).val();
				let sName = $("#nameIn"+i).val();
				let mCode = $("#mainNameInputSel"+i).val();
				
				if(sCode.trim() == "") {
					alert("소분류 코드를 입력하세요!");
					return false;
				}
				else if(!sCodeReg.test(sCode)) {
					alert("소분류 코드는 숫자 세자리로 입력하세요!");
					return false;
				}
				else if(sName.trim() == "") {
					alert("소분류명을 입력하세요!");
					return false;
				}
				else if(sCodeArr.indexOf(sCode) != -1 || sNameArr.indexOf(sName) != -1) {
					alert("입력된 소분류 코드 또는 소분류명이 중복되었습니다. 다시 확인하세요.");
					return false;
				}
				sCodeArr.push(sCode);
				sNameArr.push(sName);
				mCodeArr.push(mCode);
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/categorySubInput",
				traditional: true,
				data : {sCodeArr : sCodeArr, sNameArr : sNameArr, mCodeArr : mCodeArr},
				success : function(res) {
					if(res == "2") {
						alert("소분류가 추가되었습니다.");
						location.reload();
					}
					else if(res == "1") alert("입력된 소분류 코드 또는 소분류명이 중복되었습니다. 다시 확인하세요.");
					else alert("소분류 추가 실패!");
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
		<div class="mb-3" style="font-size:25px; padding-left:410px;">
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
									<a href="javascript:categorySubUpdateInput('${vom.categoryMainName}','${vos.categorySubCode}','${vos.categorySubName}')"><i class="fa-regular fa-pen-to-square"></i></a>&nbsp;
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
				<font color="#4A55A2" size="4">대분류명</font>
				<div class="mt-0">
					<select name="mainNameSel" id="mainNameSel" class="mNameSelect" disabled>
						<option value="">- - 수정 목록 선택 - -</option>
						<c:forEach var="vom" items="${vosMain}" varStatus="stm">
							<option value="${vom.categoryMainName}">${vom.categoryMainName}</option>
						</c:forEach>
					</select>
				</div>
				<div class="mt-3">
					<font color="#4A55A2" size="4" style="padding-right:100px;">소분류 코드</font>
					<font color="#4A55A2" size="4">소분류 명</font>
				</div>
				<div>
					<input type="text" name="codeUd" id="codeUd" class="codeIn"/>
					<input type="text" name="nameUd" id="nameUd" class="nameIn"/>
				</div>
				<div class="mt-1 mb-2 pr-3 text-right"><input type="button" value="수정" onclick="categorySubUpdate()" class="btn btn-warning"/></div>
			</div>
			<div class="mb-2 mt-5" style="font-size:25px; padding-left:100px;"><b>소분류 추가</b></div>
			<div id="categoryMain" style="margin-left:100px; height:360px; padding-top:5px;">
				<font color="#4A55A2" size="4" style="padding-right:125px;">대분류명</font>
				<font size="4" color="#4A55A2" style="padding-right:20px;">소분류 코드</font>
				<font size="4" color="#4A55A2" style="padding:0 70px 0 50px;">소분류명</font>
				<input type="button" value="입력추가" onclick="categorySubInputAdd()" class="btn btn-success btn-sm ml-3"/>
				<div class="mt-0">
					<select name="mainNameInputSel" id="mainNameInputSel1" class="mNameSelect mr-5" style="width: 25%;">
						<c:forEach var="vom" items="${vosMain}" varStatus="stm">
							<option value="${vom.categoryMainCode}">${vom.categoryMainName}</option>
						</c:forEach>
					</select>
					<input type="text" name="codeIn" id="codeIn1" class="codeIn mr-5"/>
					<input type="text" name="nameIn" id="nameIn1" class="nameIn"/>
				</div>
				<div id="demoInput"></div>
				<input type="button" value="소분류 추가" onclick="categorySubInput()" class="btn btn-orange" style="margin-left:200px;"/>
			</div>
		</div>
	</div>
</div>
</body>
</html>