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
	<title>d1Management.jsp</title>
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
		.btn-orange {
			background-color: #FFD6A5 !important;
		}
	</style>
	<script>
		'use strict';
		
		function categoryMainDelete(code) {
			let ans = confirm("대분류 " + code + "를 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/categoryDelete",
				data : {flag : "categoryMainCode", code : code},
				success : function(res) {
					if(res == "1") alert("대분류 삭제 완료!");
					else alert("대분류 삭제 실패!");
					location.reload();
				},
				error : function() {
					alert("전송 오류!");
				}
			});
		}
		
		function categoryMainUpdateInput(code,name) {
			$("#codeUd").val(code);
			$("#nameUd").val(name);
		}
		
		function categoryMainUpdate() {
			let code = $("#codeUd").val();
			let name = $("#nameUd").val();
			
			if(code.trim() == "") {
				alert("수정할 대분류를 선택하세요!");
				return false;
			}
			
			else if(name.trim() == "") {
				alert("대분류명을 입력하세요!");
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/categoryMainUpdate",
				data : {code : code, name : name},
				success : function(res) {
					alert(res);
					location.reload();
				},
				error : function() {
					alert("전송 오류!");
				}
			});
		}
		
		let count = 1;
		function categoryMainInputAdd() {
			let str = "";
			
			if(count >= 3) {
				alert("대분류 추가는 한 번에 3개까지만 가능합니다.");
				return false;
			}
			
			count++;
			str+="<div id='inputAdd"+count+"'>";
			str+="<font size='4' color='#4A55A2'>대분류 코드</font>";
			str+="<font size='4' color='#4A55A2' style='padding:0 80px 0 53px;'>대분류명</font> - - - - - &nbsp;&nbsp;&nbsp;&nbsp;";
			str+="<input type='button' value='삭제' onclick='categoryMainInputDel("+count+")' class='btn btn-danger'/>";
			str+="<div style='margin-top:-15px'><input type='text' name='codeIn' id='codeIn"+count+"' class='codeIn mr-5'/>";
			str+="<input type='text' name='nameIn' id='nameIn"+count+"' class='nameIn ml-1'/></div>";
			str+="</div>";
			
			$("#demoInput").append(str);
		}
		
		function categoryMainInputDel(idx) {
			let divId = "inputAdd" + idx;
			$("#"+divId).remove();
			count--;
		}
		
		function categoryMainInput() {
			let codeArr = [];
			let nameArr = [];
			
			let codeReg = /^[a-zA-Z]$/;
			
			for(let i = 1; i <= count; i++) {
				let code = $("#codeIn"+i).val().toUpperCase();
				let name = $("#nameIn"+i).val();
				
				if(code.trim() == "") {
					alert("대분류 코드를 입력하세요!");
					return false;
				}
				else if(!codeReg.test(code)) {
					alert("대분류 코드는 영문 1자로 입력해주세요. 대소문자는 구별하지 않습니다.");
					return false;
				}
				else if(name.trim() == "") {
					alert("대분류명을 입력하세요!");
					return false;
				}
				else if(codeArr.indexOf(code) != -1 || nameArr.indexOf(name) != -1) {
					alert("입력된 대분류 코드 또는 대분류명이 중복되었습니다. 다시 확인하세요.");
					return false;
				}
				codeArr.push(code);
				nameArr.push(name);
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/categoryMainInput",
				traditional: true,
				data : {codeArr : codeArr, nameArr : nameArr},
				success : function(res) {
					alert(res);
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
		<div class="mb-3" style="font-size:25px;"><b>대분류 목록</b></div>
		<div class="mb-3" style="font-size:25px; padding-left:510px;">
			<b>대분류 수정</b>
			<div style="font-size:15px;">대분류 목록에서 수정할 내역을 선택하세요! 대분류 코드는 수정이 불가합니다.</div>
		</div>
	</div>
	<div class="row">
		<div id="categoryMain" class="col">
			<font color="#4A55A2">[대분류 코드 / 대분류명]</font>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<div>
					<span>[${vo.categoryMainCode} /</span>
					<span>${vo.categoryMainName}]</span>
					<span>- - - - - -</span>
					<span><a href="javascript:categoryMainUpdateInput('${vo.categoryMainCode}','${vo.categoryMainName}')"><i class="fa-regular fa-pen-to-square"></i></a></span>
					<span><a href="javascript:categoryMainDelete('${vo.categoryMainCode}')"><i class="fa-solid fa-xmark"></i></a></span>
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