<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>주문 확인 페이지</title>
<%@include file="../include/header.jsp"%>
</head>
<body>
<script>
$(document).ready(function(){
});
</script>
<style>
   table td{
      
   }
   .complete_div{
      width: 100%;
       text-align: center;
       margin-top: 30px;
       margin-bottom: 20px;
   }
   .complete_div2{
      text-align : right;
      margin-right : 10px;
   }
   .complete_td1{
      width: 15%;
       text-align: center;
   }
   .complete_td2{

   }
</style>
   <!-- Page Content -->
   <div class="container">
      <%@include file="../include/sideMenu.jsp"%>
      <div class = "bob_content">
      <h1 class="mt-4">Order Complete</h1><hr class="hr_order"><br>
      
     <form action="${contextPath}/Order/OrderComplete" method="POST">
      <div style="font-size : 20px; margin : 0 0 6px 0">주문 상품 정보</div>
      <table class="table">
         <tr>
           <td class="td_order1">주문 일자: </td>
               <td class="td_order2">${payDate }</td>
               <td class="td_order1">주문 번호: </td>
               <td class="td_order2">${order.od_id }</td>
               <td class="td_order1">배송 상태: </td>
               
               <td class="td_order2">
                  <c:choose>
                        <c:when test="${order.od_state == 1}">배송중</c:when>
                        <c:when test="${order.od_state == 2}">배송 완료</c:when>
                        <c:otherwise>배송전</c:otherwise>
                  </c:choose>
               </td>
         </tr>
        <c:forEach var="product" items="${product }" varStatus="status">
            <tr>
               <td class="td_order2">${product.pd_img }</td> <!-- 이미지 가져와야됌 -->
               <td class="td_order2">상품명: ${product.pd_name }</td>
               <td class="td_order2">상품금액: ${product.pd_price }</td>
               <td class="td_order2">상품 개수: ${seq[status.index].od_amount }</td>
            </tr>
        </c:forEach>
        
       </table>
      <div style="font-size : 20px; margin : 0 0 6px 0">배송지 정보</div>
      <table class="table">
         <tr>
            <td class="complete_td1">받는사람 이름</td>
            <td class="complete_td2" colspan="3">${order.od_name }</td>
         </tr>
         <tr>
            <td class="complete_td1">휴대폰 번호</td>
            <td class="complete_td2" colspan="3">${order.od_ph }</td>
         </tr>
         <tr>
            <td class="complete_td1">주 소</td>
            <td class="complete_td2">[${order.od_ad1 }] ${order.od_ad2 } ${order.od_ad3 }</td>
         </tr>
         <tr>
            <td class="complete_td1">배송 요청사항</td>
            <td class="complete_td2" colspan="3">${order.od_memo }</td>
         </tr>
      </table>
      
      <br>
      <br>
      <div style="font-size : 20px; margin : 0 0 6px 0">결제 금액 정보</div>
      <table class="table">
         <tr>
            <td class="complete_td1">총 상품 가격</td>
            <td class="complete_td2">${order.od_price-order.od_delivery }원</td>
         </tr>
         <tr>
            <td class="complete_td1">배송비</td>
            <td class="complete_td2">${order.od_delivery }원</td>
         </tr>
         <tr>
            <td class="complete_td1">총 결제금액</td>
            <td class="complete_td2">${order.od_price}원</td>
         </tr>
      </table>
      <div class="complete_div">
         <img src="${contextPath }/resources/bootstrap/images/delivery.png" style="float: center;" >      
      </div>

      <div class="complete_div2">
         <input type ="button" class="goShopping" onClick="location.href='${contextPath}/'" value="홈으로">
      </div>
      
      <input type="hidden" name="od_price" value="${sum1 }">
      </form>
      <%@include file="../include/footer.jsp"%>   
      </div>
   </div>

</body>
</html>