<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>">
<title>상품</title>
</head>
<style>
   td{
      margin : 20px 0 0 0;
   }
   .pd_name{
      font-size : 32px;
   }
</style>
<body>

<script>
function fn_productDelete(pd_number){
      var url = "${contextPath}/ProductDelete";//수정
      var paramData = {"pd_number" : pd_number};  //수정

      $.ajax({
           type: 'POST',
           url: url,
           data : paramData,
           dataType: 'json',
           success: function(result) {
             console.log(result);    
             alret("삭제 완료");
           },
           error:function(data){
            alert("에러가 발생했습니다.")
         }
      });
   }
</script>

<%@include file="../include/header.jsp"%>

<div class="container">
   <%@include file="../include/sideMenu.jsp"%>
   <div class = "bob_content">
   <h1 class="mt-4">Product List</h1>
   <table class="table" style="border-top : 3px solid; margin-top : 1rem;">
   <c:forEach var="product" items="${ProductList }">
   <tr>
       <td style="width:20%"><img id="img" src="${contextPath}/resources/upload/${product.pd_img}" style="width:80%"><br>
       </td>
       <td><span class="pd_name">${product.pd_number }번 </span> 
       <a href="ProductDetail?pd_number=${product.pd_number }"><span class="pd_name">${product.pd_name}</span><br></a>
       <span>${product.pd_category} ${product.pd_memo} ${product.pd_company} ${product.pd_stock}</span><br></td>
       <td>${product.pd_price}원 <br> ${product.pd_img}</td>
       <td>
          <c:if test="${member.mb_id eq 'admin' and member.mb_pw eq '1'}">
          <button type="button" onclick="location.href='ProductUpdate?pd_number=${product.pd_number }'">수정</button>
          <button type="button" onclick="location.href='ProductDelete?pd_number=${product.pd_number }'">삭제</button>
          </c:if>
       </td>
   </tr>
   </c:forEach>

   </table>
   <c:if test="${member.mb_id eq 'admin' and member.mb_pw eq '1'}">
      <button type="button" onclick="location.href='ProductInsert'" style="float: right;">상품 추가</button>
   </c:if>
   <%@include file="../include/footer.jsp"%>
   </div>
</div>
</body>
<script src="<c:url value='/resources/jQuery/jquery-3.4.1.min.js'/>"></script>
<script src="<c:url value='/resources/bootstrap/js/bootstrap.min.js'/>"></script>
</html>