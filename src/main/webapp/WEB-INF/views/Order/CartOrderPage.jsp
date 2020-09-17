<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="sum1" value="0" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>주문 정보 입력 페이지</title>
<%@include file="../include/header.jsp"%>
</head>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<body>
<script>
$(document).ready(function(){
});
function adfinding() {
    new daum.Postcode({
         oncomplete: function(data) {
             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
             
              // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
              var extraRoadAddr = ''; // 도로명 조합형 주소 변수

              // 법정동명이 있을 경우 추가한다. (법정리는 제외)
              // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
              if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                  extraRoadAddr += data.bname;
              }
              // 건물명이 있고, 공동주택일 경우 추가한다.
              if(data.buildingName !== '' && data.apartment === 'Y'){
                 extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
              }
              // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
              if(extraRoadAddr !== ''){
                  extraRoadAddr = ' (' + extraRoadAddr + ')';
              }
              // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
              if(fullRoadAddr !== ''){
                  fullRoadAddr += extraRoadAddr;
              }

              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              console.log(data.zonecode);
              console.log(fullRoadAddr);
              
              $("[name=mb_ad1]").val(data.zonecode);
              $("[name=mb_ad2]").val(fullRoadAddr);
              checkcheck = 1;
              /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
              document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
              document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
             // document.getElementById('mb_ad1').value = data.zonecode; //5자리 새우편번호 사용
              //document.getElementById('mb_ad2').value = fullAddr;
              
         }
     }).open();
 }
</script>
<style>
   .h1_order{
      font-family: Lato, sans-serif;
      font-weight: 600;
   }
   .hr_order{
      color : black;
      border: 1px solid;
   }
   .td_order1{
      background-color :#cfcfcf4d;
      width : 15%;
      border-top : 1px solid;
      border-bottom : 1px solid #aaa;
      
   }
   .td_order2{
      border-top : 1px solid;
      border-bottom : 1px solid #aaa;
   }
   .text_order1{
      border: insert;
      width : 100%;
   }
   .div_order{
      text-align: center;
      margin : 50px 0 0 0;
   }
   .OrderPage_text{
      width : 400px;
      margin : 5px 0 5px 0;
      padding: 0 0 0 5px;
      border: 1px solid #bbb;
   }
   .OrderPage_div{
     padding: 10px;
     margin: 15px;
     border: 1px solid;
   }
   .goShopping{
      font-size: 22px;
       font-weight: 700;
       display: inline-block;
       position: relative;
       width: 216px;
       line-height: 18px;
       border: 2px solid #0073e9;
       border-radius: 4px;
       padding: 22px 0 19px;
       text-align: center;
       color : #0073e9;
       background-color: white;
   }
   .goPayment{
      font-size: 22px;
       font-weight: 700;
       display: inline-block;
       position: relative;
       width: 216px;
       line-height: 18px;
       border: 2px solid #0073e9;
       border-radius: 4px;
       padding: 22px 0 19px;
       text-align: center;
       color : white;
       background-color:  #0073e9;
   }
</style>
   <!-- Page Content -->
   <div class="container">
      <%@include file="../include/sideMenu.jsp"%>
      <div class = "bob_content"><br>
      <h1 class="h1_order">주문/결제</h1><hr class="hr_order"><br>
   <form action="${contextPath}/Order/CartOrderComplete" method="POST">
      <div style="font-size : 20px; margin : 0 0 6px 0">구매자 정보</div>
      <table class="table">
         <tr>
            <td class="td_order1">이름</td>
            <td class="td_order2">${member.mb_name }</td>
         </tr>
         <tr>
            <td class="td_order1">이메일</td>
            <td class="td_order2">${member.mb_email }</td>
         </tr>
         <tr>
            <td class="td_order1">휴대폰 번호</td>
            <td class="td_order2">${member.mb_ph }</td>
         </tr>
      </table>
      
      <br>
      <div style="font-size : 20px; margin : 0 0 6px 0">받는 사람 정보</div>
      <table class="table">
         <tr>
            <td class="td_order1">이름</td>
            <td class="td_order2" colspan="3">
               <input type="text" name="mb_name" style="border: 1px solid #bbb;" value=${member.mb_name }></td>
         </tr>
         <tr>
            <td class="td_order1">배송 주소</td>
            <td class="td_order2">
               <input type="text" name="mb_ad1" value=${member.mb_ad1 }>
               <input type="button" onclick="adfinding()" style="box-shadow: 0 -2px 0 rgba(0,0,0,0.1) inset; border: 1px solid #999;" value="우편번호 검색" style="height:30px; width:120px;"><br>
               <input type="text" name="mb_ad2" value=${member.mb_ad2 } style="width : 275px;" readonly><br>
               <input type="text" name="mb_ad3" value=${member.mb_ad3 } style="width : 275px;"></td>
         </tr>
         <tr>
            <td class="td_order1">휴대폰 번호</td>
            <td class="td_order2" colspan="3">
               <input type="text" style="border: 1px solid #bbb;" name="mb_ph" value=${member.mb_ph }></td>
         </tr>
         <tr>
            <td class="td_order1">배송 요청사항</td>
            <td class="td_order2" colspan="3">
               <input type=text class="text_order1" style="border: 1px solid #bbb;" name="mb_memo" placeholder="요청사항을 입력해주세요."></td>
         </tr>
      </table>
      
      <br>
      <div style="font-size : 20px; margin : 0 0 6px 0">배송 상품 목록</div>
      <table style="border :2px solid;">
         <tr>
            <td class="td_order1" style="height : 50px; text-align : center; border-bottom: 2px solid;">도착예정 날짜 : ${deliveryDay}</td>
         </tr>
          <c:forEach var="orderCartList" items="${orderCartlist }">
            <tr>
               <td class="td_order2" style="border : none;">
               <div class="OrderPage_div">
                  <img src="${contextPath}/resources/upload/${orderCartList.pd_img}" style="width:15%;">
                  ${orderCartList.pd_name } ${orderCartList.cart_amount }개 
                  ${orderCartList.cart_totalPrice }원 <br>
                  <c:set var="sum1" value="${sum1 + orderCartList.cart_totalPrice}" />  
               </div>
               </td>
            </tr>
         </c:forEach>
      </table>
     


      <br>
      <div style="font-size : 20px; margin : 0 0 6px 0">결제 정보</div>
      <table class="table">
         <tr>
            <td class="td_order1">총 상품 가격</td>
            <td class="td_order2"><c:out value="${sum1}원" /></td>
         </tr>
         <tr>
            <td class="td_order1">배송비</td>
            <c:if test="${sum1<20000}">
            <c:set var="delivery" value="3000" />
               <td class="td_order2">${delivery }원</td>
               <c:set var="sum1" value="${sum1 + delivery }" />
            </c:if>
            <c:if test="${sum1>20000 || sum1==20000}">
            <c:set var="delivery" value="0" />
               <td class="td_order2">${delivery }원</td>
            </c:if>
         </tr>
         <tr>
            <td class="td_order1">총 결제금액</td>
            <td class="td_order2">${sum1}원</td>
         </tr>
      </table>
      
      <div class="div_order">
      <input type="hidden" name="od_price" value="${sum1 }">
      <input type="hidden" name="od_delivery" value="${delivery }">
         <input type ="button" class="goShopping" 
         onClick="location.href='CartView2'" value="뒤로가기">
         <input type ="submit" class="goShopping" value="결제하기">
      </div>
      
      </form>
      <%@include file="../include/footer.jsp"%>   
      </div>
   </div>

</body>
</html>