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
	<script>
		'use strict';
		function setThumbnail(event){
			$("#originPhoto").css('display','none');
			var reader = new FileReader();
			
			reader.onload = function(event){
				var img = document.createElement("img");
				img.setAttribute("src", event.target.result);
				img.setAttribute("class", "col-lg-3");
				let child = document.querySelector("div#picture")
				child.innerHTML = "";
				document.querySelector("div#picture").appendChild(img);
			};
			
			reader.readAsDataURL(event.target.files[0]);
		}
		
		function categoryMainChange(cnt) {
			let mainCode = $("#categoryMainCode").val();
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/getCategorySubName",
				data : {mainCode : mainCode},
				success:function(data) {
					let str = "";
					if(data.length == 0) {
						str += "<option value='no'>소분류가 존재하지 않습니다.</option>"
						$("#categorySubCode").attr('disabled', true);
					}
					else {
						$("#categorySubCode").attr('disabled', false);
						str += "<option value=''>소분류를 선택하세요</option>";
						for(var i=0; i<data.length; i++) {
							str += "<option value='"+data[i].categorySubCode+"'>"+data[i].categorySubName+"</option>";
						}
					}
					$("#categorySubCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
			
		}
		
		function fCheck() {
			let categoryMainCode = myform.categoryMainCode.value;
	    	let categorySubCode = myform.categorySubCode.value;
	    	let productName = myform.productName.value;
			let productPrice = myform.productPrice.value;
			let file = myform.file.value;
			let content = myform.content.value;
			let ext = file.substring(file.lastIndexOf(".")+1);
			let uExt = ext.toUpperCase();
			
			if(categorySubCode == "") {
				alert("상품 소분류를 선택하세요!");
				return false;
			}
			else if(productName == "") {
				alert("상품명을 입력하세요!");
				return false;
			}
			else if(file != "" && uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(productPrice == "") {
				alert("상품가격을 입력하세요!");
				return false;
			}
			else if(document.getElementById("file").value != "") {
				var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
				var fileSize = document.getElementById("file").files[0].size;
				if(fileSize > maxSize) {
					alert("첨부파일의 크기는 10MB 이내로 등록하세요");
					return false;
				}
				else {
					myform.submit();
				}
			}
			else {
				myform.submit();
			}
		}
	</script>
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
	          <c:if test="${fn:length(vosSub) == 0}">
	       		<select id="categorySubCode" name="categorySubCode" class="pdselect" disabled>
	          	  <option value="no">소분류가 존재하지 않습니다.</option>
	        	</select>
	          </c:if>
	          <c:if test="${fn:length(vosSub) != 0}">
	            <select id="categorySubCode" name="categorySubCode" class="pdselect">
			      <c:forEach var="vos" items="${vosSub}">
			        <option value="${vos.categorySubCode}" <c:if test="${vo.categorySubCode == vos.categorySubCode}">selected</c:if>>${vos.categorySubName}</option>
			      </c:forEach>
		        </select>
	          </c:if>
	      </div>
        </div>
      </div>
      <div class="form-group">
        <label for="productName">상품명</label><br/>
        <input type="text" name="productName" id="productName" value="${vo.productName}" class="form-control" placeholder="상품명을 입력하세요" required />
      </div>
      <div class="form-group">
        <label for="file">메인이미지</label>
        <div id="picture"></div>
        <img src="${ctp}/data/shop/product/${vo.FSName}" width="150px" id="originPhoto"/>
        <input type="file" name="file" id="file" class="form-control-file" accept=".jpg,.gif,.png,.jpeg" onchange="setThumbnail(event);"/>
        (업로드 가능파일:jpg, jpeg, gif, png)
      </div>
      <div class="form-group">
      	<label for="productPrice">상품가격</label>
      	<input type="number" name="productPrice" id="productPrice" value="${vo.productPrice}" class="form-control" required />
      </div>
      <div class="form-group">
      	<label for="content">상품상세설명(이미지만 등록가능)</label>
      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control"></textarea>
      </div>
      <script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${ctp}/admin/imageUpload",
		    	filebrowserUploadUrl: "${ctp}/admin/imageUpload",
		    	height:350
		    });
	  </script>
      <div class="text-center">
		  <input type="button" value="상품수정" onclick="fCheck()" class="btn btn-primary mr-1"/> &nbsp;
		  <input type="reset" value="초기화" class="btn btn-warning mr-1"/> &nbsp;
		  <input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/productContent?idx=${vo.idx}';" class="btn btn-secondary"/> &nbsp;
	  </div>
	  <input type="hidden" name="idx" value="${vo.idx}"/>
    </form>
  </div>
</div>
<p><br/></p>
</body>
</html>