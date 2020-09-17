<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="sum" value="0" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@include file="../include/header.jsp"%>
<title>BobMorning</title>
<style>
	table {
		width : 100%;
		text-align : center;
	}
	td {
		border : 1px solid;
	}
</style>
</head>
<body>
<script>
var list = new Array();

<c:forEach var="item" items="${list}">
	list.push("${item.pd_number}");
</c:forEach>

console.log(list[0]);

function checkBox(chkbox) {
	if ( chkbox.checked == true ) {
		var htmls = "";
		var paramData = {"pd_number":list[0]};
		console.log(paramData);
		 $.ajax({
		      type : 'POST',
		      url : "${contextPath}/Product/CartView",
		      data : paramData,
		      success : function(data){
		    	  alert("100");
		      },
		      error : function(request, error){
		    	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		      }
		});
	}
	else {
		alert("2");
	}	 
}
</script>
	
	<!-- Page Content -->
	<div class="container">
		<%@include file="../include/sideMenu.jsp"%>
		<div class = "bob_content">
		<h1 class="mt-4"><img src="${contextPath}/resources/bootstrap/images/icons_cart.png"/> Cart</h1>
		<h3>${member.mb_id }님의 장바구니</h3>

		
		<form method="POST">
		<div>
			<table>
				<tr>
					<td style="width : 8%;">체크박스</td>
					<td>상품 이미지</td>
					<td>상품 정보</td>
					<td>상품 수량</td>
					<td>총 가격</td>
				</tr>
				<c:forEach var="product" items="${list }">
				<tr id="${product.pd_number}">
					<!--  <td><input type="checkbox" id="check" onClick="checkBox(this)"></td>-->
					<td id="test"><input type="checkbox" id="check" onClick="checkBox(this);">${product.pd_number}</td>
					<td style="width:40%">
					<img id="img" src="${contextPath}/resources/upload/${product.pd_img}" style="width:60%"><br></td>
					<td>${product.pd_name}</td>
					<td>${product.cart_amount}</td>
					<td>${product.cart_totalPrice}</td>
					<input type="hidden" name="pd_number" value="${product.pd_number}" />
				</tr>
				</c:forEach>
			</table>
			
			<div>
				<h1>총 상품 가격</h1>
				<p id="total">원</p>
			</div><br>
			
			<input type="submit" value="구매하기">
			<input type="reset" value="취소하기">
			<input type="button" onClick="Box();" value="아작스">
		</div>
		</form>
		<%@include file="../include/footer.jsp"%>	
		</div>
	</div>
	

</body>
</html>