<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 창</title>
<%@include file="../include/header.jsp"%>
</head>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
      function adfinding() {
         new daum.Postcode({
              oncomplete: function(data) {
                  // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                  
                   // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                   // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                   var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                   var extraRoadAddr = ''; // 도로명 조합형 주소 변수
    
                   // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                   // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                   if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                       extraRoadAddr += data.bname;
                   }
                   // 건물명이 있고, 공동주택일 경우 추가한다.
                   if(data.buildingName !== '' && data.apartment === 'Y'){
                      extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                   if(extraRoadAddr !== ''){
                       extraRoadAddr = ' (' + extraRoadAddr + ')';
                   }
                   // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                   if(fullRoadAddr !== ''){
                       fullRoadAddr += extraRoadAddr;
                   }
    
                   // 우편번호와 주소 정보를 해당 필드에 넣는다.
                   console.log(data.zonecode);
                   console.log(fullRoadAddr);
                   
                   $("[name=mb_ad1]").val(data.zonecode);
                   $("[name=mb_ad2]").val(fullRoadAddr);
                   checkcheck = 1;
                   
              }
          }).open();
      }
   
   
   $(document).ready(function(){
      var check = 0;
      var check1 = 0;
      var idid = "";
      var mail = "";
      
         $("#mb_idcheck").click(function() {
            $.ajax({
                 // async: true,
                  type : 'POST',
                  data : {id : $("#mb_id").val()},
                  url : "${contextPath}/Member/idChecking",
                  dataType : "json",
                  //contentType: "application/json; charset=UTF-8",
                  
                  success : function(data){
                     
                  if(data.cnt>0||$("#mb_id").val()==""){
                     alert("사용할 수 없는 아이디 입니다.");
                     $("#mb_id").val("");
                     $("#mb_id").focus();
                  } else {
                     alert("사용가능한 아이디입니다.");
                     check = 1;
                     idid= $("#mb_id").val();
                     $("mb_pw").focus();
                     
                  }
                  },
                  error : function(error) {
                     alert("error : " + error);
                  }
               });
         }); // 아이디 중복확인 end
   
         
         $("#mb_emailcheck").click(function() {
            $.ajax({
                 // async: true,
                  type : 'POST',
                  data : {email : $("#mb_email").val()},
                  url : "${contextPath}/Member/emailChecking",
                  dataType : "json",
                  //contentType: "application/json; charset=UTF-8",
                  
                  success : function(data){
                     
                  if(data.cnt>0||$("#mb_email").val()==""){
                     alert("사용할 수 없는 이메일입니다.");
                     $("#mb_email").val();
                     $("#mb_email").focus();
                  } else {
                     alert("사용가능한 이메일입니다.");
                     check1=1;
                     mail = $("#mb_email").val();
                     $("mb_email").focus();
                  }
                  },
                  error : function(error) {
                     alert("error : " + error);
                  }
               });
         }); // 이메일 중복확인 end
         
               $("#submit").on("click",function(){
                  
                  var getCheck= RegExp(/^[a-zA-Z0-9]{4,12}$/);
                  var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
				  var getPw = RegExp(/^[A-Za-z0-9]{5,}$/);

                  var getPh = RegExp(/^[0-9]{11}$/);
                  
                  
                  if(idid!=$("#mb_id").val()||check==0){
                     alert("아이디 중복검사를 해주세요");
                     $("#mb_id").focus(); 
                     check = 0;
                     
                     return false; 
                  }
                  
                  //아이디 유효성검사 
                  if(!getCheck.test($("#mb_id").val())){ 
                     alert("형식에 맞게 입력해주세요(4~12자리, 영문 또는 숫자)");
                     $("#mb_id").val(""); 
                     $("#mb_id").focus(); 
                     check = 0;
                     return false; 
                  }
                  
                  //아이디 값 입력
                  if($("#mb_id").val() == ""){ 
                     alert("아이디를 입력해주세요"); 
                     $("#mb_id").focus(); 
                     check = 0;
                     
                     return false; 
                  }
                  
                  if(mail!=$("#mb_email").val()||check1==0){
                     alert("이메일 중복검사를 해주세요");
                     $("#mb_email").focus(); 
                     check1 = 0;
                     
                     return false; 
                  }
                  
                  //비밀번호 공백 검사
                  if($("#mb_pw").val() == ""){ 
                     alert("비밀번호를 입력해주세요"); 
                     $("#mb_pw").focus(); 
                     
                     return false; 
                  }
                  
                  //비밀번호 유효성 검사
                  if(!getPw.test($("#mb_pw").val())){ 
                     alert("5자리 이상의 숫자,영문자인 비밀번호를 입력해주세요"); 
                     $("#mb_pw").focus(); 
                     
                     return false; 
                  }
                  
                  // 아이디와 비밀번호 같을 시
                  if($("#mb_id").val()==$("#mb_pw").val()){
                     alert("아이디와 동일한 비밀번호는 사용하실 수 없습니다.");
                     $("#mb_pw").val(""); 
                     $("#mb_pw").focus();
                     
                     return false;
                  }
            
                  //비밀번호 확인 검사
                  if($("#mb_pw").val() != $("#mb_pwcheck").val()){ 
                     alert("비밀번호가 일치하지 않습니다"); 
                     $("#mb_pwcheck").focus(); 
                     
                     return false; 
                  }
                  
                  //이름 공백 검사
                  if($("#mb_name").val() == ""){ 
                     alert("이름을 입력해주세요"); 
                     $("#mb_name").focus(); 
                     
                     return false; 
                  }
                  
                  // 휴대번호 공백 검사
                  if($("#mb_ph").val() == ""){ 
                     alert("휴대번호를 입력해주세요."); 
                     $("#mb_ph").focus(); 
                     
                     return false; 
                  }
                  
                  // 휴대번호 유효성검사
                  if(!getPh.test($("#mb_ph").val())){ 
                     alert("-을 제외한 11자리 숫자를 입력해주세요.");
                     $("#mb_ph").val(""); 
                     $("#mb_ph").focus(); 
                     
                     return false; 
                  }
                  
                  // 이메일 공백 검사
                  if($("#mb_email").val() == ""){ 
                     alert("휴대번호를 입력해주세요."); 
                     $("#mb_email").focus(); 
                     
                     return false; 
                  }
                  
               // 이메일 유효성검사 
                  if(!getMail.test($("#mb_email").val())){ 
                     alert("이메일 형식을 맞게 입력해주세요.");
                     $("#mb_email").val(""); 
                     $("#mb_email").focus(); 
                     
                     return false; 
                  }
               
               // 주소1,2 공백 검사
                  if($("#mb_ad1").val() == ""){ 
                     alert("우편번호 검색을 해주세요."); 
                     $("#mb_ad1").focus(); 
                     
                     return false; 
                  }
               
               // 주소3 공백 검사
                  if($("#mb_ad3").val() == ""){ 
                     alert("상세주소를 입력해주세요"); 
                     $("#mb_ad3").focus(); 
                     
                     return false; 
                  }
                  alert("회원가입되었습니다.");
               }); // submit end
            
   }); // 전체 코드 end
</script>
<body>
   <div class="container">
      <%@include file="../include/sideMenu.jsp"%>
      <div class = "bob_content">
         <h1 class="mt-4">Sign-Up</h1>
         <form style="text-align:center" method="post">
            <hr><br><br><br>
            
               
               <br><input type="text" name="mb_id" id="mb_id" placeholder="아이디 (4~12자)" style="width:210px; height:40px;">
               <input type="button" id="mb_idcheck" value="중복확인" style="height:40px; width:120px;"><br>
            
               <br><input type="password" name="mb_pw" id="mb_pw" placeholder="비밀번호" style="width:330px; height:40px;"><br>
               <br><input type="password" name="mb_pwcheck" id="mb_pwcheck" placeholder="비밀번호 확인" style="width:330px; height:40px;"><br>
            
               <br><input type="text" name="mb_name" id="mb_name" placeholder="이름" style="width:330px;  height:40px;"maxlength="45"><br>
               
               <br><input type="text" name="mb_ph" id="mb_ph" placeholder="휴대폰번호(-없이 11자리)" style="width:330px;  height:40px;" maxlength="11"><br>

               <br><input type="text" name="mb_email" placeholder="ex)bab@morning.com" id="mb_email" style="width:210px; height:40px;" maxlength="50">
               <input type="button" id="mb_emailcheck" value="중복확인" style="height:40px; width:120px;"><br>
               
               <br><input type="text" name="mb_ad1" id="mb_ad1" placeholder="우편번호" style="width:210px;  height:40px; background-color: #e2e2e2;" maxlength="200" readonly>
               <input type="button" onclick="adfinding()" value="우편번호 검색" style="height:40px; width:120px;"><br>
               <br><input type="text" name="mb_ad2" id="mb_ad2" placeholder="도로명주소" style="width:330px;  height:40px; background-color: #e2e2e2;" maxlength="200" readonly><br>
               <br><input type="text" name="mb_ad3" id="mb_ad3" placeholder="상세주소" style="width:330px;  height:40px;" maxlength="200"><br><br><br>
               
               <hr>
               <br><input type="submit" id="submit" style="width:100px;" value="회원가입">
         </form>
         
      </div>
   </div>
   

</body>
</html>