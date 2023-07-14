<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<title>productInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.productInfor {
			padding : 20px 0 0 30px;
			width:700px;
			height:250px;
			border: 1px solid lightgray;
			font-size:16px;
			line-height: 30px;
		}
		.productOptionInfo {
			padding : 20px 0 0 30px;
			margin : 0 0 0 50px;
			width:380px;
			height:250px;
			border: 1px solid lightgray;
			font-size:16px;
			line-height: 30px;
		}
		.row {
			margin-left:0px !important;
		}
		
		.optionDel {
			margin-right:40px;
		}
		
		.optionDel:hover {
			color:red;
		}
	</style>
	<script>
		'use strict';
		
		let cnt = 1;
	    
	    // 옵션항목 추가
	    function addOption() {
	    	let strOption = "";
	    	let test = "t" + cnt; 
	    	
	    	cnt++;
	    	
	    	strOption += '<div id="'+test+'"><hr size="5px"/>';
	    	strOption += '<font size="4"><b>상품옵션등록</b></font>&nbsp;&nbsp;';
	    	strOption += '<input type="button" value="옵션삭제" class="btn btn-outline-danger btn-sm" onclick="removeOption('+test+')"/><br/>'
	    	strOption += '상품옵션이름';
	    	strOption += '<input type="text" name="optionName" id="optionName'+cnt+'" class="form-control"/>';
	    	strOption += '<div class="form-group">';
	    	strOption += '상품옵션가격';
	    	strOption += '<input type="number" name="optionPrice" id="optionPrice'+cnt+'" class="form-control"/>';
	    	strOption += '</div>';
	    	strOption += '</div>';
	    	$("#optionType").append(strOption);
	    	
	    }
	    
	 	// 옵션항목 삭제
	    function removeOption(test) {
	    	/* $("#"+test).remove(); */
	    	$("#"+test.id).remove();
	    }
	 	
		 // 옵션 입력후 등록전송
	    function fCheck() {
	    	let priceArr = [];
			let nameArr = [];
			
	    	if(document.getElementById("categoryMainCode").value=="") {
	    		alert("대분류를 선택하세요");
	    		return false;
	    	}
	    	if(document.getElementById("categorySubCode").value=="") {
	    		alert("소분류를 선택하세요");
	    		return false;
	    	}
	    	if(document.getElementById("productName").value=="") {
	    		alert("상품명을 선택하세요");
	    		return false;
	    	}
	    	
	    	for(let i=1; i<=cnt; i++) {
	    		let name = $("#optionName"+i).val();
	    		let price = $("#optionPrice"+i).val();
	    		if(name == "") {
	    			alert("빈칸 없이 상품 옵션명을 모두 등록하셔야 합니다");
	    			return false;
	    		}
	    		else if(price == "") {
	    			alert("빈칸 없이 상품 옵션가격을 모두 등록하셔야 합니다");
	    			return false;
	    		}
	    		else if(nameArr.indexOf(name) != -1) {
					alert("같은 옵션명을 입력하셨습니다. 다시 확인하세요.");
					return false;
				}
	    		nameArr.push(name);
	    		priceArr.push(price);
	    	}
	    	
	    	myform.submit();
	    	
	    }
	    
		function categoryMainChange(cnt) {
			let mainCode = $("#categoryMainCode").val();
			
			$("#productName").html("<option value=''>상품선택</option>");
			$("#demo").css('display', 'none');
			$("#demo2").css('display', 'none');
			
			if(mainCode.trim() == "") {
				$("#categorySubCode").attr('disabled', false);
				$("#categorySubCode").html("<option value=''>소분류명</option>");
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/getCategorySubName",
				data : {mainCode : mainCode},
				success:function(data) {
					let str = "";
					if(data.length == 0) {
						str += "<option value=''>소분류를 선택하세요</option>";
						str += "<option value='no'>소분류가 존재하지 않습니다. 해당 칸을 선택해주세요.</option>"
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
		
		// 상품 입력창에서 소분류 선택(Change)시 해당 상품들을 가져와서 품목 선택박스에 뿌리기
	    function categorySubChange() {
	    	let categoryMainCode = myform.categoryMainCode.value;
	    	let categorySubCode = myform.categorySubCode.value;
	    	
	    	$("#demo").css('display', 'none');
	    	$("#demo2").css('display', 'none');
	    	
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/categoryProductName",
				data : { categoryMainCode : categoryMainCode, categorySubCode : categorySubCode},
				success:function(data) {
					var str = "";
					str += "<option value=''>상품선택</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].productName+"'>"+data[i].productName+"</option>";
					}
					$("#productName").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
	  	}
		
	 // 상품명을 선택하면 상품의 설명을 띄워준다.
	    function productNameCheck() {
	    	var productName = document.getElementById("productName").value;
	    	
	    	if(productName == "") {
	    		$("#demo").css('display', 'none');
	    		$("#demo2").css('display', 'none');
	    	}
	    	
	    	else{
		    	$.ajax({
		    		type:"post",
		    		url : "${ctp}/admin/getProductInfor",
		    		data: {productName : productName},
		    		success:function(vo) {
		    			$("#demo").css('display', 'block');
		    			let str = '<br/><div class="row productInfor">';
		    			str += '<div class="col">';
		    			str += '대분류명 : '+vo.categoryMainName+'<br/>';
		    			if(vo.categorySubCode != null) {
			    			str += '소분류명 : '+vo.categorySubName+'<br/>';
		    			}
		    			str += '상 품 명 : '+vo.productName+'<br/>';
		    			str += '상품가격 : '+numberWithCommas(vo.productPrice)+'원<br/>';
		    			str += '<input type="button" value="등록된옵션" onclick="optoinShow('+vo.idx+')" class="btn btn-info btn-sm"/><br/>';
		    			str += '</div>';
		    			str += '<div class="col">';
		    			str += '<img src="${ctp}/data/shop/product/'+vo.fsname+'" width="160px" height="160px"/><br/>';
		    			str += '</div>';
		    			str += '</div><hr/>';
		    			$("#demo").html(str);
		    			document.myform.productIdx.value = vo.idx;
		    		},
		    		error : function() {
		    			alert("전송오류!");
		    		}
		    	});
	    	}
	    }
	 
	 	// 콤마찍기
	    function numberWithCommas(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
	 	
	 	// 옵션상세내역보기
	    function optoinShow(productIdx) {
	    	$("#demo2").css('display', 'block');
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/admin/getOptionList",
	    		data : {productIdx : productIdx},
	    		success:function(vos) {
	    			let str = '';
	    			if(vos.length != 0) {
							str += "<br/><div class='productOptionInfo'>";
							str += "<div>";
		    			for(let i=0; i<vos.length; i++) {
		    				str += '<span>'+vos[i].optionName+'&nbsp;&nbsp;<a href="javascript:optionDelete('+vos[i].idx+')" class="optionDel"><i class="fa-solid fa-xmark"></i></a></span>';
		    				if(i % 2 == 1) {
		    					str+="</div><div>";
		    				}
		    			}
		    			str += "</div>";
		    			str += "</div>";
	    			}
	    			else {
	    				str += "<br/><div class='productOptionInfo'>등록된 옵션이 없습니다.<div>";
	    			}
						$("#demo2").html(str);
	    		},
	    		error : function() {
	    			alert("전송오류!");
	    		}
	    	});
	    }
	 	
	    function optionDelete(idx) {
	    	let ans = confirm("해당 옵션을 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/admin/optionDelete",
	    		data : {idx : idx},
	    		success:function() {
	    			alert("옵션이 삭제되었습니다.");
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
<div class="container">
	<div class="mb-3 mt-5 text-center" style="font-size:30px;"><b>상품 옵션 관리</b></div>
	<hr style="border:1px solid gray;"/>
  <form name="myform" method="post">
    <div class="form-group">
      <label for="categoryMainCode">대분류</label>
      <select id="categoryMainCode" name="categoryMainCode" class="form-control" onchange="categoryMainChange('${mainVo.cnt}')">
        <option value="">대분류를 선택하세요</option>
        <c:forEach var="mainVo" items="${mainVos}">
        	<option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
        </c:forEach>
      </select>
    </div>
    <div class="form-group">
      <label for="categorySubCode">소분류</label>
      <select id="categorySubCode" name="categorySubCode" class="form-control" onchange="categorySubChange()">
        <option value="">소분류명</option>
      </select>
    </div>
    <div class="form-group">
      <label for="productName">상품명(모델명)</label>
      <select name="productName" id="productName" class="form-control" onchange="productNameCheck()">
        <option value="">상품선택</option>
      </select>
    <div class="row">
      <div id="demo"></div>
      <div id="demo2"></div>
    </div>
    </div>
    <hr/>
    <font size="4"><b>상품옵션등록</b></font>&nbsp;&nbsp;
    <input type="button" value="옵션박스추가하기" onclick="addOption()" class="btn btn-secondary btn-sm"/><br/>
    <div class="form-group">
      <label for="optionName">상품옵션이름</label>
      <input type="text" name="optionName" id="optionName1" class="form-control"/>
    </div>
    <div class="form-group">
      <label for="optionPrice">상품옵션가격</label>
      <input type="number" name="optionPrice" id="optionPrice1" class="form-control"/>
    </div>
    <div id="optionType"></div>
    <hr/>
    <div class='text-right'><input type="button" value="옵션등록" onclick="fCheck()" class="btn btn-primary"/></div>
    <input type="hidden" name="productIdx">
  </form>
</div>
<p><br/></p>
</body>
</html>