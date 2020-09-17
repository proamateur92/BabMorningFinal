<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri= "http://java.sun.com/jsp/jstl/core" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정하기</title>
<%@include file="../include/header.jsp"%>
</head>
<body>
	<div class="container">	
	<%@include file="../include/sideMenu.jsp"%>	
	<form role="form" method="post">	
		<div class = "bob_content">
		<section class="content">
		<div class="box">
			<div class="box-header">
				<h3 class="box-title">수정하기</h3>
			</div>
			<div class="box-body">
				<div class="form-group">
					<label>제목</label> 
					<input type="text" name="b_title" class="form-control"  value = "${b_Update.b_title}"/>									
				</div>

				<div class="form-group">
					<label>내용</label>
					<textarea name="b_content" rows="5" class="form-control" >${b_Update.b_content}</textarea>
				</div>

				<div class="form-group">
					<label>작성자</label> 
					<input type="text" name="b_id" class="form-control" value="${b_Update.b_id}" readonly="readonly"/>					
				</div>
			</div>
		</div>
			<div class="box-footer">
				<button type = "sumit" class="btn btn-success">완료</button>
				<button type = "button" class="btn btn-danger" 
				onclick="location.href='BoardDetail?b_number=${b_Update.b_number}'">취소</button>			
			</div>
			</section>
		</div>
	</form>
</body>
</html>