<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>Home</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
	<link rel="stylesheet" href="${ctp}/css/home.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<div id="demo" class="carousel slide carousel-fade" data-ride="carousel">
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
	<div class="main_content">새로운 마이닭 친구들!</div>
	<hr::after/><hr/>
</div>
</body>
</html>
