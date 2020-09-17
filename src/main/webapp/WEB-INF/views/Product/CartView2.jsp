<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="sum" value="0" />
<c:set var="cnt" value="0" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@include file="../include/header.jsp"%>
<title>BobMorning</title>

</head>
<body>
<style>
   .cartView_table {
      width : 100%;
      text-align : center;
   }
   .cartView_table td {
      border : 1px solid;
      padding : 0.75rem;
   }
   button {
      background-color : white;
   }
   .user_tier{
      border : 5px solid #cfcfcf;
      margin : 30px 5px 0 5px;
      padding : 20px;
      text-align : center;
      font-size : 20px;
      background-color : #FBFBFB;
   }
   .div_order{
      text-align: center;
      margin : 50px 0 0 0;
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
   		<input type = "hidden" id = "a"><c:set var="sum" value="0" /></input>
      <%@include file="../include/sideMenu.jsp"%>
      <div class = "bob_content">
      <h1 class="mt-4">Cart</h1><hr style="border : 2px solid;">
      <table id="cartList" class="cartView_table"></table><hr>
      <div class="user_tier" id="sum">      
         총 상품 가격 : <span style="color : dodgerblue;">원</span>입니다.
      </div>
      <div class="div_order">
         <input type ="button" class="goShopping" id = "sh"
         onClick="location.href='${contextPath}/'" value="계속 쇼핑하기">
         <input type ="button" class="goPayment" id = "order"
         onClick="javascript:orderCheck()" value="주문하기">
         
      </div>
      <%@include file="../include/footer.jsp"%>   
      </div>
   </div>
   
<script>
$(document).ready(function(){
   cartList();
});

function orderCheck(){
	alert("체크된 항목이 없습니다.");
	return;
}

function cartList(){
   var sum = 0;
   var htmls = "";
   var paramData = {"mb_number":"${member.mb_number }"};
   
    $.ajax({
         type : 'POST',
         url : "${contextPath}/Product/CartView2",
         data : paramData,
         success : function(data){
            htmls += '<tr style="background-color : #dee2e6;">';
            htmls += '<td>';
            htmls += '선택';
            htmls += '</td>';
            htmls += '<td>';
            htmls += '상품 이미지';
            htmls += '</td>';
            htmls += '<td>';
            htmls += '상품 정보';
            htmls += '</td>';
            htmls += '<td>';
            htmls += '상품 개수';
            htmls += '</td>';
            htmls += '<td>';
            htmls += '상품 가격';
            htmls += '</td>';
            htmls += '</tr>';
          
            $(data).each(function(){
              htmls += '<tr>';
              htmls += '<td style="padding-left: 30px;">';
              htmls += '<input type="checkbox" id=' +this.cart_number +' onClick="checkBox('+this.cart_totalPrice+',' +this.cart_number+');">';
              htmls += '</td>';
              htmls += '<td style="width:40%">';
               htmls += '<img id="img" src="${contextPath}/resources/upload/'+this.pd_img+'" style="width:60%"><br>';
               htmls += '</td>';
               htmls += '<td>';
               htmls += this.pd_name;
               htmls += '</td>';
               htmls += '<td>';
               htmls += this.cart_amount;
               htmls += '</td>';
               htmls += '<td>';
               htmls += this.cart_totalPrice+"원 ";
               htmls += '<a href="CartDelete?cart_number='+this.cart_number+'">X</a>'
               htmls += '</td>';
             htmls += '</tr>';
             htmls += this.cart_del
             console.log(this.cart_totalPrice);
             
            });
            
            $("#cartList").html(htmls);
         },
         error : function(request, error){
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
         }
         
   });
}
var sum = 0;
var count = 0;
function checkBox(cart_totalPrice, cart_number) {
	var dot = "'";	
    var order = "";
    var cnt = "";
    
	let htmls = "";
  	let cBox = document.getElementById(cart_number);  
  	let paramData = {"cart_number":cart_number};
   if (cBox.checked == true ) {
	   count += 1;	   
	  order += '<input type ="button" class="goPayment" id = "order" onClick=' + dot + 'location.href="CartOrderPage?mb_number=${member.mb_number }"' +dot+ 'value="주문하기">'
	  $("#order").replaceWith(order);
      $.ajax({
            type : 'POST',
            url : "${contextPath}/Product/CartDelOn",
            data : paramData,
            success : function(data){
               console.log("성공");
            },
            error : function(request, error){
               console.log("실패");
            }
      });
      console.log(sum+"+"+cart_totalPrice);
      sum=sum+cart_totalPrice;
      console.log(sum);
      sumPrint(sum);
      
      htmls += '<div class="user_tier" id="sum">총 상품 가격 : <span style="color : dodgerblue;">'
      htmls += sum
      htmls += '원</span>입니다.</div>' 
      
      $("#sum").html(htmls);
   }
   else {
      count -= 1;
      if(count <= 0){
    	  var notorder = "";
    	  notorder +=  '<input type ="button" class="goPayment" id = "order" onClick="javascript:orderCheck()" value="주문하기">'
    	  $("#order").replaceWith(notorder);
      }
    	  
      
      $.ajax({
            type : 'POST',
            url : "${contextPath}/Product/CartDelOff",
            data : paramData,
            success : function(data){
               console.log("성공");
            },
            error : function(request, error){
               console.log("실패");
            }
      });
      console.log(cBox.checked)
      console.log(sum+"-"+cart_totalPrice);
      sum=sum-cart_totalPrice;
      console.log(sum);
      sumPrint(sum);
      
      htmls += '<div class="user_tier" id="sum">총 상품 가격 : <span style="color : dodgerblue;"> '
      htmls += sum
      htmls += '원</span>입니다.</div>'   
         
      $("#sum").html(htmls);
   }    
}
function sumPrint(sum){
   var htmls = "";
   htmls += '<p id = "sum">' +sum + '원</p>';
   $('#sum').replaceWith(htmls);
   
}
</script>
</body>
</html>