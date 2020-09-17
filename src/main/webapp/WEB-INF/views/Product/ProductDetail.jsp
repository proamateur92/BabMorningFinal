<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="num" value="1" />
<c:set var="total" value="${product.pd_price*num }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../include/header.jsp"%>
<style>

   td {
      width : 500px;
      border : 1px solid;
   }
.productDetail_table td {
   width: 500px;
   border: 1px solid;
   padding: 12px;
}

img {
   width: 80%;
}

.pd_img {
   text-align: center;
}

.pd_name {
   font-size: 30px;
}

.pd_detail {
   font-size: 10px;
}

.productReviewBox {
   padding: 35px 0px 0px 0px;
}

.pd_ReviewBox {
   list-style: none;
   padding: 0 0 0 0px;
   text-align: center;
}

.pd_ReviewBox_menu {
   border: 1px solid;
   float: left;
   width: 33.3%;
}
/* Style the tab */
.tab {
   overflow: hidden;
   border: 1px solid #ccc;
   background-color: #f1f1f1;
   margin: 35px 0px 0px 0px;
}

/* Style the buttons that are used to open the tab content */
.tab button {
   background-color: inherit;
   float: left;
   border: none;
   outline: none;
   cursor: pointer;
   padding: 14px 16px;
   transition: 0.3s;
   width: 33.3%;
}

/* Change background color of buttons on hover */
.tab button:hover {
   background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
   background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
   display: none;
   padding: 6px 15px;
   border: 1px solid #ccc;
   border-top: none;
}

.productDetail_star {
   width: 70%;
   float: left;
}

.productDetail_totalPrice {
   text-align: center;
   border: none;
   outline: none;
   width: 51px;
}

.productDetail_count {
   float: left;
   font-size: 20px;
   padding-left: 11px;
   padding-right: 15px;
}

.productDetail_count2 {
   float: left;
   padding-top: 2px;
}

.productDetail_h3 {
   text-align: center;
   margin: 30px;
   font-size: 40px;
   font-family : Lato, sans-serif;
   font-weight : 600;
}
</style>
</head>
<body>
<div class="container">
   <%@include file="../include/sideMenu.jsp"%>
   <div class="bob_content">
      <h1 class="mt-4">Product</h1>
      <form method="POST" name="form">
         <table class="productDetail_table">
            <tr>
               <td rowspan="10" class="pd_img">
               <img src="${contextPath}/resources/upload/${product.pd_img}">
               </td>
            </tr>
            <tr>
               <td class="pd_name">${product.pd_name }</td>
            </tr>
            <tr>
               <td>${product.pd_price}원</td>
            </tr>
            <tr>
               <td>
                  <div id="pdf_star" class="productDetail_star"></div>
                  <div style="font-size: 36px;">${product.getPd_avgstar()}점</div>
               </td>
            </tr>
            <tr>
               <td>${product.pd_category}</td>
            </tr>
            <tr>
               <td>${product.pd_memo}</td>
            </tr>
            <tr>
               <td class="pd_detail">${product.pd_detail}<br>
               <br>
               <br></td>
            </tr>
            <tr>
               <td>
                  <div class="productDetail_count">수량</div>
                  <div class="productDetail_count2">
                     <input type="button" onclick="button_click1();" value="-">
                     <input type="text" id="${num }" name="cart_amount"
                        value="${num }" style="text-align: center;" readonly> <input
                        type="button" onclick="button_click2();" value="+">
                  </div>
                  <div class="productDetail_count">총
                  <input type="text" id="${total }" name="cart_totalPrice"
                        value="${total }" class="productDetail_totalPrice" readonly>원
                  </div>
               </td>
            </tr>
            <tr>
               <td style="text-align: center;">
               <c:if test = "${member == null }">
               		<a href='javascript: login_check();'><input type="button" class="p_reply" value="구매후기"></a>
               		<a href='javascript: login_check();'><input type="button" value="장바구니"/> </a>
               		<a href='javascript: login_check();'> <input type="button" value="구매하기"/></a>
               </c:if>
               <c:if test = "${member != null }">
	               <input type="button" class="p_reply" value="구매후기"> 
	               <input type="submit" value="장바구니" onclick="javascript: form.action='ProductDetail'; fn();" /> 
	               <input type="submit" value="구매하기" onclick="javascript: form.action='ProductOrderPage';" /></td>
               </c:if>
            </tr>
         </table>
         <input type="hidden" name="mb_number" value="${member.mb_number}">
         <input type="hidden" name="pd_number" value="${product.pd_number}">
      </form>
      
      <!-- Tab links -->
      <div class="tab">
        <button class="tablinks" onclick="openCity(event, 'London')" id="defaultOpen">상세 정보</button>
        <button class="tablinks" onclick="openCity(event, 'Paris')">구매 평가</button>
        <button class="tablinks" onclick="openCity(event, 'Tokyo')">Q&A</button>
      </div>
      
      <!-- Tab content -->
      <div id="London" class="tabcontent">
        <img src="${contextPath}/resources/bootstrap/images/detail.jpg" style="width:100%;">
      </div>
      
      <div id="Paris" class="tabcontent">        
        <c:forEach var="list" items="${list}">
          <table class="table">
              <tr>
                 <td>작성자 ${list.b_id}</td> 
                 <td>작성일 ${list.b_regdate}</td>
                 <td>점수 ${list.pd_star}</td>
              </tr>
               <tr>
                  <td colspan="2">${list.b_title }</td>
                  <td rowspan="2"><div id = "pdf_star${list.b_number }" style="width : 50%;"></div></td>
               </tr>
               <tr>
                  <td colspan="2">${list.b_content }</td>
               </tr>
               <script>
            $(function () {
               i = "";
               var arr = new Array(); 
                  
               var r1 = ${list.pd_star};
               
                    if(r1>=0.0 && r1<=0.3) {
                      i  = '<img src ="${contextPath}/resources/star/img/star0.png" />' ; 
                    }
                             
                    else if(r1>=0.4 && r1<=0.7) {
                       i  = '<img src ="${contextPath}/resources/star/img/star05.png" />' ; 
                    }
                    
                    else if(r1>=0.8 && r1<=1.0) {
                       i  = '<img src ="${contextPath}/resources/star/img/star1.png" />' ; 
                    }
                    
                    else if(r1>=1.1 && r1<=1.3) {
                       i  = '<img src ="${contextPath}/resources/star/img/star1.png" />' ; 
                     }
                                
                    else if(r1>=1.4 && r1<=1.7) {
                       i  = '<img src ="${contextPath}/resources/star/img/star15.png" />' ; 
                    }
                       
                    else if(r1>=1.8 && r1<=2.0) {
                       i  = '<img src ="${contextPath}/resources/star/img/star2.png" />' ; 
                    }
                    
                    else if(r1>=2.1 && r1<=2.3) {
                       i  = '<img src ="${contextPath}/resources/star/img/star2.png" />' ; 
                     }
                                
                    else if(r1>=2.4 && r1<=2.7) {
                       i  = '<img src ="${contextPath}/resources/star/img/star25.png" />' ; 
                    }
                       
                    else if(r1>=2.8 && r1<=3.0) {
                       i  = '<img src ="${contextPath}/resources/star/img/star3.png" />' ; 
                    }
                    
                    else if(r1>=3.1 && r1<=3.3) {
                       i = '<img src ="${contextPath}/resources/star/img/star3.png" />' ; 
                     }
                                
                    else if(r1>=3.4 && r1<=3.7) {
                       i  = '<img src ="${contextPath}/resources/star/img/star35.png" />' ; 
                    }
                       
                    else if(r1>=3.8 && r1<=4.0) {
                       i  = '<img src ="${contextPath}/resources/star/img/star4.png" />' ; 
                    }
                    
                    else if(r1>=4.1 && r1<=4.3) {
                       i  = '<img src ="${contextPath}/resources/star/img/star4.png" />' ; 
                     }
                                
                    else if(r1>=4.4 && r1<=4.7) {
                       i  = '<img src ="${contextPath}/resources/star/img/star45.png" />' ; 
                    }
                       
                    else  {
                       i  = '<img src ="${contextPath}/resources/star/img/star5.png" />' ; 
                    }
                  
               $('#pdf_star${list.b_number }').html(i);
            });
            </script>
               
           </table>
         </c:forEach>
      </div>
      
      <div id="Tokyo" class="tabcontent">
         
         <p style="margin : 15px;">
            ※ 구매한 상품의 취소/반품은 마이쿠팡 구매내역에서 신청 가능합니다.<br> ※ 상품문의 및 후기게시판을 통해
            취소나 환불, 반품 등은 처리되지 않습니다.<br> ※ 가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와
            관련 없는 문의는 고객센터 내 1:1 문의하기를 이용해주세요.<br> ※ 공개 게시판이므로 전화번호, 메일 주소
            등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.
         </p>
      </div>
      <%@include file="../include/footer.jsp"%>
   </div>
</div>

</body>
<script>
var count =1;
function button_click1(){
   if(count>1){
      count--;
      document.getElementById("${num}").value = count;
      var sum = ${product.pd_price}*count;
      document.getElementById("${total}").value = sum;
      console.log(sum);
   }
}
function button_click2(){
   count++;
   document.getElementById("${num}").value = count;
   var sum = ${product.pd_price}*count;
   document.getElementById("${total}").value = sum;
   console.log(sum);
}
function openCity(evt, cityName) {
     // Declare all variables
     var i, tabcontent, tablinks;

     // Get all elements with class="tabcontent" and hide them
     tabcontent = document.getElementsByClassName("tabcontent");
     for (i = 0; i < tabcontent.length; i++) {
       tabcontent[i].style.display = "none";
     }

     // Get all elements with class="tablinks" and remove the class "active"
     tablinks = document.getElementsByClassName("tablinks");
     for (i = 0; i < tablinks.length; i++) {
       tablinks[i].className = tablinks[i].className.replace(" active", "");
     }

     // Show the current tab, and add an "active" class to the button that opened the tab
     document.getElementById(cityName).style.display = "block";
     evt.currentTarget.className += " active";
}

document.getElementById("defaultOpen").click();
</script>
<script>
$(function () {
   $(".p_reply").click(function() {
      location.href = "../board/BoardRegister?pd_number=${product.pd_number}&bcode_number=1"
   });
})
</script>
 
<script>
      $(function () {
         
         var innerHtml = "";
         var r = ${product.getPd_avgstar()};
         
         console.log(r);
            
              if(r>=0 && r<=0.3) {
                innerHtml  = '<img src ="${contextPath}/resources/star/img/star0.png" />' ; 
              }
                       
              else if(r>=0.4 && r<=0.7) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star05.png" />' ; 
              }
              
              else if(r>=0.8 && r<=1.0) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star1.png" />' ; 
              }
              
              else if(r>=1.1 && r<=1.3) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star1.png" />' ; 
               }
                          
              else if(r>=1.4 && r<=1.7) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star15.png" />' ; 
              }
                 
              else if(r>=1.8 && r<=2.0) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star2.png" />' ; 
              }
              
              else if(r>=2.1 && r<=2.3) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star2.png" />' ; 
               }
                          
              else if(r>=2.4 && r<=2.7) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star25.png" />' ; 
              }
                 
              else if(r>=2.8 && r<=3.0) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star3.png" />' ; 
              }
              
              else if(r>=3.1 && r<=3.3) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star3.png" />' ; 
               }
                          
              else if(r>=3.4 && r<=3.7) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star35.png" />' ; 
              }
                 
              else if(r>=3.8 && r<=4.0) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star4.png" />' ; 
              }
              
              else if(r>=4.1 && r<=4.3) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star4.png" />' ; 
               }
                          
              else if(r>=4.4 && r<=4.7) {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star45.png" />' ; 
              }
                 
              else  {
                 innerHtml  = '<img src ="${contextPath}/resources/star/img/star5.png" />' ; 
              }

            $('#pdf_star').html(innerHtml);
      });
      </script>
</html>