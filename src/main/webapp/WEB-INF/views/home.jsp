<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@include file="include/header.jsp"%>
<title>BobMorning</title>
</head>
<body>
	<!-- Page Content -->
	<div class="container">
		<%@include file="include/sideMenu.jsp"%>
		<div class = "bob_content">
		<h1 class="mt-4">Hello Bab-Morning</h1>
		 <table>
		 <c:forEach var="product" items="${ProductList }">
		 <td style="width:30%; float : left; margin : 10px;">
		 <div>
		 	<img id="img" src="${contextPath}/resources/upload/${product.pd_img}" style="width:80%"><br>
		 	<span class="pd_name">${product.pd_number }번 </span> 
			<a href="Product/ProductDetail?pd_number=${product.pd_number }"><span class="pd_name">${product.pd_name}</span><br></a>
			<span>${product.pd_category} ${product.pd_company}</span><br>
		 </div>
		 </td>
		 </c:forEach>
		 </table>
		 <%@include file="include/footer.jsp"%>
		</div>
	</div>
</body>
</html>