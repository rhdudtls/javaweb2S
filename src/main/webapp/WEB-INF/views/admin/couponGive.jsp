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
	<title>couponGive.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		table {
			width: 500px !important;
		}
		table th {
			background-color: #eee;
		}
	</style>
	<script>
		'use strict';
		
		function fCheck() {
			let midArr = [];
			let coupon = couponForm.couponList.value;
			let date = couponForm.date.value;
			
			$('input:checkbox[name=coupon]').each(function (index) {
				if($(this).is(":checked")==true){
					midArr.push($(this).val());
			    }
			});
			
			if(midArr.length == 0) {
				alert("쿠폰을 지급할 회원을 선택하세요");
				return false;
			}
			else if(coupon.trim() == "") {
				alert("지급할 쿠폰을 선택하세요");
				return false;
			}
			else if(date.trim() == "") {
				alert("유효기간을 선택하세요");
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/couponGive",
				data : {midArr : midArr, coupon : coupon, date : date},
				traditional: true,
				success : function(res) {
					if(res == "1") {
						alert("쿠폰이 정상 지급되었습니다.");
						location.reload();
					}
					else alert("쿠폰지급실패");
				},
				error : function() {
					alert("전송오류");
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
	<div class="row">
		<div class="col">
			<font size="5"><b>쿠폰지급</b></font>
			<table class="table table-bordered">
				<tr>
					<th></th>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>닉네임</th>
				</tr>
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<tr>
						<td class="text-center"><input type="checkbox" name="coupon" value="${vo.mid}"/></td>
						<td>${st.count}</td>
						<td>${vo.mid}</td>
						<td>${vo.name}</td>
						<td>${vo.nickName}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="col">
		  <!-- 상품주문을 위한 옵션정보 출력 -->
		  <div class="form-group mt-3">
		    <form name="couponForm">  <!-- 옵션의 정보를 보여주기위한 form -->
		    	쿠폰 목록
				<select size="5" id="couponList" class="form-control">
				  <c:forEach var="couponVO" items="${couponVOS}">
				    <option value="${couponVO.idx}">${couponVO.name}</option>
				  </c:forEach>
				</select>
				<div class="mt-4">유효기간</div>
				<select size="5" id="date" class="form-control">
				    <option value="1">1일</option>
				    <option value="7">7일</option>
				    <option value="14">14일</option>
				    <option value="30">30일</option>
				    <option value="60">60일</option>
				    <option value="90">90일</option>
				    <option value="180">180일</option>
				</select>
				<input type="button" onclick="fCheck()" value="쿠폰지급" class="mt-5 text-center btn btn-primary"/>
		    </form>
		  </div>
		</div>
	</div>
</div>
<p><br/></p>
</body>
</html>