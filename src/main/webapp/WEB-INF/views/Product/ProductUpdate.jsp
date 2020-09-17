<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<%@include file="../include/header.jsp"%>
 <style>
      td {
        padding: 8px 8px 8px 8px;
        border : 1px solid;
      }
      input{
      	width : 300px;
      }
      img{
      	width : 80%;
      }
      tr{
      	text-align : center;
      }
</style>
</head>
<body>
	<div class="container">
		<%@include file="../include/sideMenu.jsp"%>
		<div class = "bob_content">
			<h1 class="mt-4">Product Update</h1>
			<form id="target" method="post" enctype="multipart/form-data">
				<table>
					<tr>
					<td rowspan="18">
					<span>${product.pd_img}</span><br>
					<img src="${contextPath}/resources/upload/${product.pd_img}">
					</td>
					</tr>
					
					<tr><td style="text-align : left;">상품 이름</td></tr>					
					<tr>
					<td><input type="text" name="pd_name" class="form-control" value="${product.pd_name }"></td>
					</tr>
					
					<tr><td style="text-align : left;">상품 가격</td></tr>
					<tr>
					<td><input type="text" name="pd_price" class="form-control" value="${product.pd_price }"></td>
					</tr>
					
					<tr><td style="text-align : left;">상품 분류</td></tr>
					<tr>
					<td><input type="text" name="pd_category" class="form-control" value="${product.pd_category }"></td>
					</tr>
					
					<tr><td style="text-align : left;">상품 메모</td></tr>
					<tr>
					<td><input type="text" name="pd_memo" class="form-control" value="${product.pd_memo }"></td>
					</tr>
					
					<tr><td style="text-align : left;">상품 정보</td></tr>
					<tr>
					<td><textarea name="pd_detail" class="form-control">${product.pd_detail }</textarea></td>
					</tr>
					
					<tr><td style="text-align : left;">제조사</td></tr>
					<tr>
					<td><input type="text" name="pd_company" class="form-control" value="${product.pd_company }"></td>
					</tr>
					
					<tr><td style="text-align : left;">상품 재고</td></tr>
					<tr>
					<td><input type="text" name="pd_stock" class="form-control" value="${product.pd_stock }"></td>
					</tr>
					
					<tr><td style="text-align : left;">상품 이미지</td></tr>
					<tr>
					<td><input type="file" name="up_upload" style="width:400px;" value="${product.pd_img }"></td>
					</tr>
					
				</table>
				<br>
				<div style="text-align : right;">
					<button type="submit" >수정</button>
           		 	<button type="button" onclick="location.href='./productTable'">취소</button>
				</div>
				
			</form>
			<%@include file="../include/footer.jsp"%>
		</div>
	</div>
</body>
</html>