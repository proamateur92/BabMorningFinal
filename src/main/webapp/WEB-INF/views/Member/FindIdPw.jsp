<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디, 비밀번호 찾기</title>
<%@include file="../include/header.jsp"%>

<script>
$(document).ready(function(){

      $("#submit1").on("click",function(){
            if($("#name").val()==""){
               alert("이름을 입력해주세요."); 
               $("#name").focus();
               
               return false;
            }
            
            if($("#email1").val()==""){
               alert("이메일을 입력해주세요.");
               $("#email1").focus();
               
               return false;
            }
      });   
      
      $("#submit2").on("click",function(){
         if($("#id").val()==""){
            alert("아이디를 입력해주세요."); 
            $("#id").focus();
            
            return false;
         }
         
         if($("#email2").val()==""){
            alert("이메일을 입력해주세요.");
            $("#email2").focus();
            
            return false;
         }
   });   
});
   
</script>
</head>
<body>
   <div class="container">
      <%@include file="../include/sideMenu.jsp"%>
         <div class = "bob_content">
         <h1 class="mt-4">아이디/ 비밀번호 찾기</h1>
         <hr>
         <br><br>
            아이디 찾기
            
               <br><br> 
               
               <form action="${contextPath}/Member/FindId" method="POST">
               
                  이름 : <input type="text" name="mb_name" id="name"><br>
                  이메일 : <input type="text" name="mb_email" id="email1"><br><br>
                  
                  <input type="submit" id = "submit1" value="아이디 찾기"><br><br><hr>
               
               </form>
               
               <br><br>               
               임시 비밀번호 발급<br><br>
               
               <form action="${contextPath}/Member/NewPw" method="POST">
                  아이디 : <input type="text" name="mb_id" id="id"><br>
                  이메일 : <input type="text" name="mb_email" id="email2"><br><br>
                  
                  <input type="submit" id="submit2" value="새 비밀번호 발급">   
               </form>
               
               <br><br><br>
               
         </div>
   </div>

</body>
</html>