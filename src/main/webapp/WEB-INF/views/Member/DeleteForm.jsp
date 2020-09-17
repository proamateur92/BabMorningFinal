<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="../include/header.jsp"%>
<title>회원 탈퇴 페이지</title>
</head>
<script>
$(document).ready(function(){
	$("#submit").click(function(){ 
		var pass1 = $("#mb_pw").val();
		//alert(pass1);
		var pass2 = $("#mb_pw1").val();
		//alert(pass2);
		
		if(pass1 != pass2) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		} else {
			alert("탈퇴되었습니다.");
		}
	});
});

</script>
<body>
	<div class="container">
			<%@include file="../include/sideMenu.jsp"%>
			<div class = "bob_content">
				<br><br><br><br>
				<h1>Unsubscribe</h1>
				<hr><br><br><br>
				
				<form method="POST" style ="text-align: center;">
					<input type="hidden" name="mb_pw" id="mb_pw" value="${member.mb_pw}" >
				 	<input type="hidden" name="mb_number1" id="mb_number1" value="${member.mb_number}" >
					비밀번호 : <input type="password" name="mb_pw1" id="mb_pw1"><br><br><br>
					<input type="submit" id="submit" value="탈퇴하기">
				</form>
			</div>
		</div>
</body>
</html>