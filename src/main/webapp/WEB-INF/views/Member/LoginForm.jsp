<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인폼</title>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">	
	$(document).ready(function(){
		$("#check").click(function(){
			var id = $("#mb_id").val();
			var pw = $("#mb_pw").val();
			
			if(id==""||pw=="") {
				alert("아이디 또는 비밀번호를 입력해주세요.");
			}
		});

		$("#join").click(function(){
			location.href="SignUp1";
		});
	});	
</script>
</head>
<body>
<style>
	body {
	    font-family: "Lato", sans-serif;
	}
	.login_h1{
		font-family: "Lato", sans-serif;
		font-weight: 600;
		text-align : center;
	}
	.login_div{
		margin : 50px 0 0 100px;
	}
	.login_div0{
		margin : 0 415px 0 215px;
	}
	.login_div1{
		margin : 20px 0 0 0;
		text-align : center;
		border : 1px solid;
		width : 100%;
	}
	.login_text{
		border : none;
		width : 310px;
	}
	.login_button{
		overflow : hidden;
	}
	.login_button1{
		float : left;
	    width: 183px;
	    height: 45px;
	    border : none;
	    border-radius: none;
	    background-color: #27c555;
	    color: white;
	    font-weight: bolder;
	    font-size: 15px;
	}
	.login_join{
		float : left;
	    width: 100%;
	    height: 45px;
	    border : none;
	    border-radius: none;
	    background-color: #12bbd6;
	    color: white;
	    font-weight: bolder;
	    font-size: 15px;
	}
	.login_a{
		float : right
	}
	.login_icon{

	}
	.login_icon_bab{
		vertical-align: sub;
	}
</style>
<div class="container">
<div class = "login_div">
		<form method="post">
			<div class="login_div0">
			<h1 class="login_h1"><img src="${contextPath}/resources/bootstrap/images/icon_bab.png" class="login_icon_bab">
				<span style="color : #27c555;">밥모닝</span> 로그인</h1>

				<div class="login_div1">
					<img src="${contextPath}/resources/bootstrap/images/icon_user.png">
					<input type="text" name="mb_id" id="mb_id" class="login_text" placeholder="아이디"/>		
				</div>

				<div class="login_div1">
					<img src="${contextPath}/resources/bootstrap/images/icon_lock.png" class="login_icon">
					<input type="password" name="mb_pw" id="mb_pw" class="login_text" placeholder="비밀번호"/>	
				</div>

				<div style="text-align : right; margin : 10px 0 10px 0">
					<a href="${contextPath}/Member/FindIdPw">아이디/비밀번호 찾기</a>				
				</div>
					<input type = "hidden" name = "referer" value = "${referer}">
				<div class="login_button">
					<input type="submit" value="밥모닝 로그인 " class="login_button1" id="check" />

					<!-- 카카오 로그인 버튼 -->
					<a href="https://accounts.kakao.com/login?continue=https%3A%2F%2Fkauth.kakao.com%2Foauth%2Fauthorize%3Fresponse_type%3Dcode%26client_id%3Df25ba85dd3dff2c295cc0a373e2ef8da%26redirect_uri%3Dhttp%253A%252F%252Flocalhost:8090/Bob/kakaoLogin"
					class="login_a">
						<img src="${contextPath}/resources/bootstrap/images/kakao.png" alt="">
					</a>
				</div><hr>
				<div class="login_button">
					<input type="button" value="회원가입" class="login_join" id="join" />				
				</div><br>
			</div>
		</form>
		<br>
		<br>

		<!-- 메인단추 -->
		<script>
			document.getElementById("main").onclick = function() {
				location.href = "../";
			}
		</script>
		</div>
	</div>
</body>
</html>