<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>마이닭</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/home.css">
	<style>
		a {
			text-decoration:none;
		}
		.circle {
			width : 30px;
			height : 30px;
			border-radius: 50%;
			background-color: #9BA4B5;
		}
		
		.shopping_icon {
			font-size:20px;
			color:white !important;
			padding:4px 0px 0px 4px;
		}
		#redline {
		    content: "";
		    display: inline-block;
		    width: 22px;
		    position: absolute;
		    height: 2px;
		    background: #fc2020;
		    margin-top : -2px;
		}
		#line {
			border-top: 1px solid #eee;	
		}
	</style>
	
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<div id="demo" class="carousel slide carousel-fade text-center" data-ride="carousel">
	<!-- Indicators -->
	<ul class="carousel-indicators" style="padding-right:40px;">
		<li data-target="#demo" data-slide-to="0" class="active"></li>
		<li data-target="#demo" data-slide-to="1"></li>
		<li data-target="#demo" data-slide-to="2"></li>
		<li data-target="#demo" data-slide-to="3"></li>
		<li data-target="#demo" data-slide-to="4"></li>
	</ul>

	<!-- The slideshow -->
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img src="${ctp}/images/banner01.jpg">
		</div>
		<div class="carousel-item">
			<img src="${ctp}/images/banner02.jpg">
		</div>
		<div class="carousel-item">
			<img src="${ctp}/images/banner03.jpg">
		</div>
		<div class="carousel-item">
			<img src="${ctp}/images/banner04.jpg">
		</div>
		<div class="carousel-item">
			<img src="${ctp}/images/banner05.jpg">
		</div>
	</div>

	<!-- Left and right controls -->
	<a class="carousel-control-prev" href="#demo" data-slide="prev">
		<span class="carousel-control-prev-icon"></span>
	</a>
	<a class="carousel-control-next" href="#demo" data-slide="next">
		<span class="carousel-control-next-icon"></span>
	</a>
</div>
<p><br/></p>
<div class="container">
	<div class="row">
		<div class="col main_content">새로운 마이닭 친구들!</div>
		<div class="col text-right plus_icon">+</div>
	</div>
	<hr/>
	<div class="row">
		<c:forEach var="i" begin="1" end="4">
			<div class="card col" style="width:265px; border:none;">
			    <img class="card-img-top" src="${ctp}/images/product1.jpg" style="width:100%">
			    <div class="card-body p-0 mt-2">
			    	<div class="card-title" style="font-size:17px;"><b>미트리 파워에너지 프로틴바 2종 골라담기</b></div>
					<p class="card-text">
						<span style="color:red;font-size:22px;"><b>37%</b></span>&nbsp;&nbsp;
						<span style="font-size:19px;"><b>2,200원</b></span>&nbsp;
						<span style="color:gray;font-size:14px;"><b><s>3,500원</s></b></span>
					</p>
		    	</div>
		    </div>
	    </c:forEach>
    </div>
</div>
<p><br/></p>
<div class="hot_deal">
	<div class="container">
    	<div class="hot_deal_title"><i class="fa-regular fa-clock"></i>&nbsp;이달의 <font color="#F45050">핫딜</font></div>
    	<p></p>
    	<div class="row">
	    	<c:forEach var="i" begin="1" end="3">
				<div class="card col" style="margin-right:20px; border:none;">
				    <img class="card-img-top" src="${ctp}/images/hot_deal1.jpg" style="width:100%">
				    <div class="card-body p-0 mt-2">
				    	<div class="card-title" style="font-size:17px;"><b>미트리 닭가슴살 후랑크핫바 5종 혼합 10팩</b></div>
						<p class="card-text">
							<div class="row">
								<div class="col-10">
								  	<span style="color:red;font-size:22px;"><b>45%</b></span>&nbsp;&nbsp;
									<span style="font-size:19px;"><b>10,900원</b></span>&nbsp;
									<span style="color:gray;font-size:14px;"><b><s>20,000원</s></b></span>
						 		</div>
							 	<div class="col-2">
							 		<div class="circle"><i class="fa-solid fa-basket-shopping shopping_icon"></i></div>
							 	</div>
							</div>
						</p>
			    	</div>
			    </div>
		    </c:forEach>
		</div>
		<p><br/></p><p><br/></p>
    </div>
	<div class="mb-5 text-center"><img src="${ctp}/images/banner_join.jpg"></div>
</div>
<div class="container mt-5 mb-5">
	<div class="row">
		<div class="col main_content">Best! 인기상품</div>
		<div class="col text-right plus_icon">+</div>
	</div>
	<hr/>
	<div class="row">
		<c:forEach var="i" begin="1" end="4">
			<div class="card col" style="width:265px; border:none;">
			    <img class="card-img-top" src="${ctp}/images/product1.jpg" style="width:100%">
			    <div class="card-body p-0 mt-2">
					<div class="card-title" style="font-size:17px;"><b>미트리 닭가슴살/볶음밥 외 전상품 골라담기</b></div>
					<p class="card-text">
						<span style="color:red;font-size:22px;"><b>48%</b></span>&nbsp;&nbsp;
						<span style="font-size:19px;"><b>1,300원</b></span>&nbsp;
						<span style="color:gray;font-size:14px;"><b><s>2,500원</s></b></span>
					</p>
		    	</div>
		    </div>
	    </c:forEach>
    </div>
</div>
<p></p>
<div class="container mt-3">
	<div id="line"></div>
	<div class="row mt-5">
		<div class="col-3">
			<div class="main_content mb-3">Review</div>
			<div id="redline"></div>
			<div class="mt-5 mb-5">생생한 후기를 만나보세요!</div>
			<input type="button" value="후기 보러가기 >" class="review_button"/>
		</div>
		<div class="col-9 pl-0">
			<c:forEach var="j" begin="1" end="2">
				<div class="row mb-3">
					<c:forEach var="i" begin="1" end="2">
						<div class="col">
							<div class="pr-2" style="float:left">
								<img src="${ctp}/images/review1.jpg" width="130px"/>
							</div>
							<div class="mb-2 pt-1" style="color:gray">미트리 스팀 닭가슴살 4종 골라담기</div>
							<div><font size="4"><b>양념치킨 먹는 느낌</b></font></div>
							<div><font size="3">은 오바고 닭가슴살 브랜드중 제일 ㅇ맛난듯함</font></div>
						</div>
					</c:forEach>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<div class="mt-5 text-center"><img src="${ctp}/images/banner_coupon.jpg"></div>
<p></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>

