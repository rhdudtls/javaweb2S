<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<title>couponList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.c-list th {
			text-align: center;
			background-color: #CCD5AE;
		}
		.c-input th {
			width: 10%;
			background-color: #D4E2D4;
		}
		.c-input td {
			width: 30%;
		}
		.cpinput {
			padding: 0 15px;
		    width: 60%;
		    height: 35px;
		    border: 1px solid #e1e1e1;
			border-bottom: 1px solid #e1e1e1;
			box-sizing: border-box;
			outline:none;
		}
		.cpselect {
			width: 60%;
		    height: 35px;
		    padding-left:10px;
		    border: 1px solid #e1e1e1;
			border-bottom: 1px solid #e1e1e1;
			box-sizing: border-box;
			outline:none;
		}
		input::-webkit-inner-spin-button {
		    appearance: none;
		    -moz-appearance: none;
		    -webkit-appearance: none;
		}
		.btn-input {
			margin-left: 450px;
		}
		.page-item.active .page-link {
		    color: #fff !important;
		    background-color: #007bff !important;
		    border-color: #007bff !important;
		}
	</style>
	<script>
		'use strict';
		if(${pageVO.pag} > ${pageVO.totPage}) location.href="${ctp}/admin/couponList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}";
		   
		function numMake() {
			let random = '';
			for (let i = 0; i < 12; i++) {
				random += Math.floor(Math.random() * 10);
			}
			myform.number.value = random;
		}
		
		function fCheck() {
			let submitOk = 0; 
			let number = myform.number.value;
			let name = myform.name.value;
			let type = myform.type.value;
			let price = myform.price.value;
			let ratio = myform.ratio.value;
			let max_value = myform.max_value.value;
			let use_min_price = myform.use_min_price.value;
			let content = myform.content.value;
			
			let numberReg = /^[0-9]{10,12}$/;
			
			if(number.trim() == "") {
				alert("쿠폰번호를 입력하세요");
				return false;
			}
			else if(!numberReg.test(number)) {
				alert("쿠폰번호는 10~12자리 숫자로 입력하세요");
				return false;
			}
			else if(name.trim() == "") {
				alert("쿠폰명을 입력하세요");
				return false;
			}
			else if(type == "금액권" && price.trim() == "") {
				alert("할인금액을 입력하세요");
				return false;
			}
			else if(type == "비율할인권" && ratio.trim() == "") {
				alert("할인비율을 입력하세요");
				return false;
			}
			else if(max_value.trim() == "") {
				alert("최대할인금액을 입력하세요");
				return false;
			}
			else if(use_min_price.trim() == "") {
				alert("최소주문금액을 입력하세요");
				return false;
			}
			else if(content.trim() == "") {
				alert("쿠폰혜택을 입력하세요");
				return false;
			}
			else {
				if(type == "금액권") ratio = 0;
				else price = 0;
				submitOk = 1
			}
			
			if(submitOk == 1) {
				$.ajax({
					type :"post",
					url : "${ctp}/admin/couponInput",
					data : { 
						number : number,
						name : name,
						type : type,
						price : price,
						ratio : ratio,
						max_value : max_value,
						use_min_price : use_min_price,
						content : content
					},
					success : function(res) {
						if(res == "1") {
							alert("쿠폰이 등록되었습니다.");
							location.reload();
						}
						else if(res == "2") alert("같은 이름의 쿠폰이름이나 쿠폰번호가 존재합니다.")
						else alert("쿠폰 등록 실패");
					},
					error : function() {
						alert("전송 오류");
					}
				});
			}
		}
		
		function couponDel(number){
			let ans = confirm("해당 쿠폰을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/couponDelete",
				data : {number : number},
				success : function(res) {
					if(res == "1"){
						alert("쿠폰이 삭제되었습니다.");
						location.reload();
					}
					else alert("쿠폰 삭제 실패");
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
<div class="container">
	<div class="col">
		<div class="row">
			<div class="col"><font size="5"><b>쿠폰목록</b></font></div>
			<div class="col text-right">
				<c:if test="${pageVO.pag > 1}"><a href="${ctp}/admin/couponList?pageSize=5&pag=1">◁◁</a></c:if>
				<c:if test="${pageVO.pag > 1}"><a href="${ctp}/admin/couponList?pageSize=5&pag=${pageVO.pag - 1}">◀</a></c:if>
				${pageVO.pag} / ${pageVO.totPage}
				<c:if test="${pageVO.pag < pageVO.totPage}"><a href="${ctp}/admin/couponList?pageSize=5&pag=${pageVO.pag + 1}">▶</a></c:if>
				<c:if test="${pageVO.pag < pageVO.totPage}"><a href="${ctp}/admin/couponList?pageSize=5&pag=${pageVO.totPage}">▷▷</a></c:if>
			</div>
		</div>
		<table class="table table-bordered mb-5 c-list">
			<tr class="text-center">
				<th>번호</th>
				<th>쿠폰번호</th>
				<th>쿠폰명</th>
				<th>쿠폰종류</th>
				<th>할인금액</th>
				<th>할인비율</th>
				<th>최대할인금액</th>
				<th>최소주문금액</th>
				<th>쿠폰혜택</th>
				<th></th>
			</tr>
			<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr class="text-center">
					<td>${curScrStartNo}</td>
					<td>${vo.number}</td>
					<td>${vo.name}</td>
					<td>${vo.type}</td>
					<td><fmt:formatNumber value="${vo.price}"/>원</td>
					<td>${vo.ratio}%</td>
					<td><fmt:formatNumber value="${vo.max_value}"/>원</td>
					<td><fmt:formatNumber value="${vo.use_min_price}"/>원</td>
					<td>${vo.content}</td>
					<td><input type="button" value="삭제" onclick="couponDel('${vo.number}')" class="btn btn-danger btn-sm"/></td>
				</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
			</c:forEach>
		</table>
		<div><font size="5"><b>쿠폰등록</b></font></div>
		<hr style="border-top:1px solid black; margin-top:10px;"/>
		<form name="myform">
			<table class="table table-borderless c-input">
				<tr>
					<th>쿠폰번호</th>
					<td>
						<input type="text" name="number" class="cpinput"/>
						<input type="button" value="랜덤생성" onclick="numMake()" class="btn btn-success btn-sm"/>
					</td>
					<th>쿠폰명</th>
					<td><input type="text" name="name" class="cpinput"/></td>
				</tr>
				<tr>
					<th>쿠폰종류</th>
					<td>
						<select name="type" class="cpselect">
							<option value="금액권">금액권</option>
							<option value="비율할인권">비율할인권</option>
						</select>
					</td>
					<th>할인금액</th>
					<td><input type="number" name="price" class="cpinput"/></td>
				</tr>
				<tr>
					<th>할인비율</th>
					<td><input type="number" name="ratio" class="cpinput"/></td>
					<th>최대할인금액</th>
					<td><input type="number" name="max_value" class="cpinput"/></td>
				</tr>
				<tr>
					<th>최소주문금액</th>
					<td><input type="number" name="use_min_price" class="cpinput"/></td>
					<th>쿠폰혜택</th>
					<td><input type="text" name="content" class="cpinput"/></td>
				</tr>
				<tr>
					<td colspan="4"><font color="red">금액권일 경우 할인비율이 0으로, 비율할인권일 경우 할인금액이 0으로 고정됩니다.</font></td>
				</tr>
			</table>
			<input type="button" value="쿠폰 등록" onclick="fCheck()" class="btn btn-primary btn-input"/>
		</form>
	</div>
</div>
<p><br/></p>
</body>
</html>