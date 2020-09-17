<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<%@include file="../include/header.jsp"%>
</head>
<body>
<div class="container">
<%@include file="../include/sideMenu.jsp"%>
<div class="bob_content">
   <h1 class="mt-4">Member List</h1>
      <table class="table">
         <tr style="text-align: center; border-bottom: 2px solid; background-color: DeepSkyBlue">
            <td>NO.</td>
            <td>DETAIL</td>
            <td>DEL</td>
            <td>VIEW</td>
         </tr>

         <c:forEach var="memberList1" items="${memberList}">
            <tr>
               <td style="text-align : center;">${memberList1.mb_number}</td>
               <td>
                  <div class="memberList_div">아이디 : ${memberList1.mb_id}</div> 
                  <div class="memberList_div">이 &nbsp&nbsp름 : ${memberList1.mb_name}</div>
                  <div class="memberList_div">이메일 : ${memberList1.mb_email}</div>
                  <div class="memberList_div">휴대번호 : ${memberList1.mb_ph}</div>
                  <div class="memberList_div">가입날짜 : ${memberList1.mb_signup}</div>
                  <div class="memberList_div">우편번호 : ${memberList1.mb_ad1}</div>
                  <div class="memberList_div">주 &nbsp&nbsp소 : ${memberList1.mb_ad2} ${memberList1.mb_ad3}</div>
               </td>

               <c:choose>
                  <c:when test="${memberList1.mb_del == 0}">
                     <td style="text-align : center;">N</td>
                  </c:when>
                  <c:when test="${memberList1.mb_del == 1}">
                     <td style="text-align : center;">Y</td>
                  </c:when>
               </c:choose>
               <td style="text-align : center;">
               <button onclick="location.href='${contextPath}/Member/AdminUpdate?mb_number=${memberList1.mb_number}'">수정</button>
               <button onclick="location.href='${contextPath}/Member/AdminDel?mb_number=${memberList1.mb_number}'">삭제</button>
               </td>
            </tr>
         </c:forEach>
      </table>
      <%@include file="../include/footer.jsp"%>
   </div>
</div>
</body>
</html>