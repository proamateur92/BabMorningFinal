<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>BobMorning</title>
<%@include file="../include/header.jsp"%>
</head>
<body>
   <!-- Page Content -->
   <div class="container">
      <%@include file="../include/sideMenu.jsp"%>
      <div class = "bob_content">
      <c:if test="${requestScope['javax.servlet.error.status_code'] == 500}"> 
      <br>
      <h1 class="mt-4">500Error</h1><br>
         <a href="${contextPath }/Member/LoginForm">로그인 하러가기</a>
      </c:if>
      <div style="height : 400px;"></div>
       <%@include file="../include/footer.jsp"%>
      </div>
   </div>
</body>
</html>