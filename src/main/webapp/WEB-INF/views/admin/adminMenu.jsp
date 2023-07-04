<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminMenu.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
        function collapse(element) {
            var before = document.getElementsByClassName("active")[0];              // 기존에 활성화된 버튼
            if (before && document.getElementsByClassName("active")[0] != element) {  // 자신 이외에 이미 활성화된 버튼이 있으면
                before.nextElementSibling.style.maxHeight = null;   // 기존에 펼쳐진 내용 접고
                before.classList.remove("active");                  // 버튼 비활성화
            }
            element.classList.toggle("active");         // 활성화 여부 toggle

            var content = element.nextElementSibling;
            if (content.style.maxHeight != 0) {         // 버튼 다음 요소가 펼쳐져 있으면
                content.style.maxHeight = null;         // 접기
            } else {
                content.style.maxHeight = content.scrollHeight + "px";  // 접혀있는 경우 펼치기
            }
        }
    </script>
</head>
<body>
<p><br/></p>
	<button type="button" class="collapsible" onclick="collapse(this);">회원 관리</button>
    <div class="content">
        <p>내용 1 입니다.</p>
    </div>
    <button type="button" class="collapsible" onclick="collapse(this);">상품 관리</button>
    <div class="content">
        <p>내용 2 입니다.</p>
    </div>
    <button type="button" class="collapsible" onclick="collapse(this);">뭐할까</button>
    <div class="content">
        <p>내용 3 입니다.</p>
    </div>
<p><br/></p>
</body>
</html>