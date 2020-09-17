<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../include/header.jsp"%>
</head>
<body>
   <div class="container">
      <%@include file="../include/sideMenu.jsp"%>
         <div class = "bob_content">
         <h1 class="mt-4">아이디/ 비밀번호 결과</h1>
         <hr>
         <br><br>
   
            <c:choose>
               <c:when test="${check eq 0 }"> 일치하는 회원 정보가 없습니다.</c:when>
               <c:when test="${check eq 1}"> 회원님의 비밀번호가 변경되었습니다. <br>${newPw }</c:when>
               <c:when test="${mb_id eq null}">일치하는 회원 정보가 없습니다. ㅠ-ㅠ</c:when>
               <c:when test="${mb_id ne null}">회원님의 아이디는 ${mb_id } 입니다.</c:when>
            </c:choose>
            
            <br><br><hr>
         
            <input type="button" onclick="location.href='LoginForm'" value="로그인">
            
            <%@include file="../include/footer.jsp"%>
         </div>
   </div>
</body>
</html>