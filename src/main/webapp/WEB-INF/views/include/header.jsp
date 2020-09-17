<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
</head>
<script>
function login_check()
{
	alert("로그인 하세요.");
	self.location = "${contextPath}/Member/LoginForm";
}

</script>
<body>
<link rel="stylesheet" href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/resources/jQuery/jquery-3.4.1.min.js'/>"></script>
<script src="<c:url value='/resources/bootstrap/js/bootstrap.min.js'/>"></script>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
   <div class="container">
      <a class="navbar-brand" href="${contextPath}/"> 
         <img src="${contextPath}/resources/bootstrap/images/logo.jpg" alt="">
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse"
         data-target="#navbarResponsive" aria-controls="navbarResponsive"
         aria-expanded="false" aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
         <ul class="navbar-nav ml-auto">
            <c:if test="${member==null and userId == null}">
               <li><a class="nav-link" href="${contextPath}/Member/LoginForm">로그인</a></li>
            </c:if>
            
            <c:if test="${member!=null or userId !=null}">
               <c:choose>
               <c:when test="${member!=null and userId == null}">
                  <li class="nav-item"><a class="nav-link" href="${contextPath}/Member/Logout">로그아웃</a></li>
               </c:when>
               <c:when test="${userId!=null and member == null}">
                  <li class="nav-item"><a class="nav-link" href="${contextPath}/kakaoLogout">로그아웃</a></li>
               </c:when>
               </c:choose>
            </c:if>
            <c:if test="${member != null }">
            	<li class="nav-item"><a class="nav-link" href="${contextPath}/Member/Mypage?mb_number=${member.mb_number}">마이페이지</a></li>
            	<li class="nav-item"><a class="nav-link" href="${contextPath}/Product/CartView2">장바구니</a></li>
            </c:if>
            <c:if test="${member == null }">	
				<a class="nav-link" href='javascript: login_check();'>마이페이지</a>
				<a class="nav-link" href='javascript: login_check();'>장바구니</a>
			</c:if>
           
            <li class="nav-item"><a class="nav-link" href="${contextPath}/board/list_paging?bcode_number=2">고객센터</a></li>
         </ul>
      </div>
   </div>   
<!-- <li class="bob_sideMenu"><a href="${contextPath}/Member/DeleteForm">회원탈퇴</a></li> -->
</nav>
</body>
</html>