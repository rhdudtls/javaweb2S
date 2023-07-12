<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<title>productInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.pdinput {
			padding: 0 15px;
		    width: 60%;
		    height: 35px;
		    border: 1px solid #e1e1e1;
			border-bottom: 1px solid #e1e1e1;
			box-sizing: border-box;
			outline:none;
		}
		.pdselect {
			width: 100%;
		    height: 35px;
		    padding-left:10px;
		    color : gray;
		    border: 1px solid #e1e1e1;
			border-bottom: 1px solid #e1e1e1;
			box-sizing: border-box;
			outline:none;
		}
	</style>
	<script>
		'use strict';
		
		function categoryMainChange(cnt) {
			let mainCode = $("#categoryMain").val();
			
			if(mainCode.trim() == "") {
				$("#categorySubDemo").hide();
				return false;
			}
			
			$("#categorySubDemo").show();
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/getCategorySubName",
				data : {mainCode : mainCode},
				success:function(data) {
					let str = "";
					if(data.length == 0) {
						str += "<option value='no'>소분류가 존재하지 않습니다.</option>"
						$("#categorySub").attr('disabled', true);
					}
					else {
						$("#categorySub").attr('disabled', false);
						str += "<option value=''>소분류를 선택하세요</option>";
						for(var i=0; i<data.length; i++) {
							str += "<option value='"+data[i].categorySubCode+"'>"+data[i].categorySubName+"</option>";
						}
					}
					$("#categorySub").html(str);
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
<div class="left" style="height:100vh;">
	<jsp:include page="/WEB-INF/views/admin/adminMenu.jsp"/>
</div>
<div class="container">
  <div id="product" class="ml-5">
    <div class="mb-3 mt-5 text-center" style="font-size:30px;"><b>상품등록</b></div>
    <hr style="border:1px solid gray"/>
    <form name="myform" method="post" enctype="multipart/form-data">
      <div class="row">
      	<div class="col-6">
	      <div class="form-group">
	        <label for="categoryMain"><font size="3">대분류</font></label><br/>
	        <select id="categoryMain" name="categoryMain" class="pdselect" onchange="categoryMainChange()">
	          <option value="">대분류를 선택하세요</option>
	          <c:forEach var="vom" items="${vosMain}">
	          	<option value="${vom.categoryMainCode}">${vom.categoryMainName}</option>
	          </c:forEach>
	        </select>
	      </div>
	    </div>
	    <div id="categorySubDemo" class="col-6" style="display:none;">
	      <div class="form-group">
	        <label for="categorySub">소분류</label><br/>
	        <select id="categorySub" name="categorySub" class="pdselect">
	          <option value="">소분류명</option>
	        </select>
	      </div>
        </div>
      </div>
      <div class="form-group">
        <label for="productName">상품명</label><br/>
        <input type="text" name="productName" id="productName" class="form-control" placeholder="상품 모델명을 입력하세요" required />
      </div>
      <div class="form-group">
        <label for="file">메인이미지</label>
        <input type="file" name="file" id="file" class="form-control-file" accept=".jpg,.gif,.png,.jpeg" required />
        (업로드 가능파일:jpg, jpeg, gif, png)
      </div>
      <div class="form-group">
      	<label for="productPrice">상품가격</label>
      	<input type="text" name="productPrice" id="productPrice" class="form-control" required />
      </div>
      <div class="form-group">
      	<label for="content">상품상세설명</label>
      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
      </div>
      <div class="text-center">
		  <input type="reset" value="초기화" class="btn btn-secondary"/> &nbsp;
		  <input type="button" value="상품등록" onclick="fCheck()" class="btn btn-primary mr-2"/> &nbsp;
	  </div>
    </form>
  </div>
</div>
<p><br/></p>
</body>
</html>