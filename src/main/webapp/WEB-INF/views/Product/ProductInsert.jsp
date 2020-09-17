<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 추가</title>
<%@include file="../include/header.jsp"%>
 <style>
      td {
        padding: 8px 8px 8px 8px;
        border : 1px solid;
      }
      input{
      	width : 300px;
      }
    </style>
</head>
<body>
	<div class="container">
		<%@include file="../include/sideMenu.jsp"%>
		<div class = "bob_content">
			<h1 class="mt-4">Product Insert</h1>
			<form method="POST" enctype="multipart/form-data">
				<table>
				<tr>
					<td>
					<p>상품 이름</p>
					</td>
					<td>
					<input type="text" name="pd_name" class="form-control">
					</td>
				</tr>
				
				<tr>
					<td>
					<p>상품 가격</p>
					</td>
					<td>
					<input type="text" name="pd_price" class="form-control">
					</td>
				</tr>
				
				<tr>
					<td>
					<p>상품 분류</p>
					</td>
					<td>
					<input type="text" name="pd_category" class="form-control">
					</td>
				</tr>
				
				<tr>
					<td>
					<p>요약 설명</p>
					</td>
					<td>
					<input type="text" name="pd_memo" class="form-control">
					</td>
				</tr>
				<tr>
					<td>
					<p>상세 설명</p>
					</td>
					<td>
					<textarea name="pd_detail" class="form-control" style="width:600px; height:200px;"></textarea>
					</td>
				</tr>
				
				<tr>
					<td>
					<p>제조사</p>
					</td>
					<td>
					<input type="text" name="pd_company" class="form-control">
					</td>
				</tr>
				<tr>
					<td>
					<p>재고수</p>
					</td>
					<td>
					<input type="text" name="pd_stock" class="form-control">
					</td>
				</tr>
	
				<tr>
					<td>
					<p>이미지</p>
					</td>
					<td>
					<input type="file" name="up_upload" style="width:400px;">
					</td>
				</tr>
				<tr>
					<td>
					<p></p>
					<td>
					<br>
					<input type="submit" class="button" style="width:100px;" value="상품 추가">
					<input type="reset" class="button" style="width:100px;" value="취소">
					</td>
				</tr>
				</table>
			</form>
			<%@include file="../include/footer.jsp"%>
		</div>
	</div>
</body>
</html>