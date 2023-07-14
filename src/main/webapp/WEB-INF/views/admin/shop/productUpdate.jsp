<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<title>productUpdate.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<style>
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
</head>
<body style="background-color:#EEF1FF">
<div class="top" style="z-index: 1">
	<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"/>
</div>
<div class="left">
	<jsp:include page="/WEB-INF/views/admin/adminMenu.jsp"/>
</div>
<div class="container">
  <div id="product" class="ml-5">
    <div class="mb-3 mt-5 text-center" style="font-size:30px;"><b>상품정보수정</b></div>
    <hr style="border:1px solid gray"/>
    <form name="myform" method="post" enctype="multipart/form-data">
      <div class="row">
      	<div class="col-6">
	      <div class="form-group">
	        <label for="categoryMainCode"><font size="3">대분류</font></label><br/>
	        <select id="categoryMainCode" name="categoryMainCode" class="pdselect" onchange="categoryMainChange()">
	          <c:forEach var="vom" items="${vosMain}">
	          	<option value="${vom.categoryMainCode}" <c:if test="${vo.categoryMainCode == vom.categoryMainCode}">selected</c:if>>${vom.categoryMainName}</option>
	          </c:forEach>
	        </select>
	      </div>
	    </div>
	    <div id="categorySubDemo" class="col-6">
	      <div class="form-group">
	        <label for="categorySubCode">소분류</label><br/>
	        <select id="categorySubCode" name="categorySubCode" class="pdselect">
	          <c:forEach var="vos" items="${vosSub}">
	          	<option value="${vos.categorySubCode}" <c:if test="${vo.categorySubCode == vos.categorySubCode}">selected</c:if>>${vos.categorySubName}</option>
	          </c:forEach>
	        </select>
	      </div>
        </div>
      </div>
      <div class="form-group">
        <label for="productName">상품명</label><br/>
        <input type="text" name="productName" id="productName" value="${vo.productName}" class="form-control" placeholder="상품명을 입력하세요" required />
      </div>
      <div class="form-group">
        <label for="file">메인이미지</label>
        <br/><img src="${ctp}/data/shop/product/${vo.FSName}" width="150px"/>
        <input type="file" name="file" id="file" class="form-control-file" accept=".jpg,.gif,.png,.jpeg" required />
        (업로드 가능파일:jpg, jpeg, gif, png)
      </div>
      <div class="form-group">
      	<label for="productPrice">상품가격</label>
      	<input type="number" name="productPrice" id="productPrice" value="${vo.productPrice}" class="form-control" required />
      </div>
      <div class="form-group">
      	<label for="content">상품상세설명(이미지 1장만 등록가능)</label>
      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
      </div>
      <script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${ctp}/admin/imageUpload",
		    	filebrowserUploadUrl: "${ctp}/admin/imageUpload",
		    	height:350
		    });
	  </script>
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