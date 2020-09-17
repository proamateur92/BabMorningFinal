<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 페이지</title>
<%@include file="../include/header.jsp"%>
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
             
             /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
             document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
             document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
            // document.getElementById('mb_ad1').value = data.zonecode; //5자리 새우편번호 사용
             //document.getElementById('mb_ad2').value = fullAddr;
        }
    }).open();
}
$(document).ready(function(){
   $("#submit").on("click", function(){
      var getPh = RegExp(/^[0-9]{11}$/);
      // 아이디와 비밀번호 같을 시
      if($("#mb_id").val() == $("#mb_pw").val()){
         alert("아이디와 동일한 비밀번호는 사용하실 수 없습니다.");
         $("#mb_pw").val(""); 
         $("#mb_pw").focus();
         
         return false;
      }
      
      // 비밀번호 공백 시
      if($("#mb_pw").val() == ""){ 
         alert("비밀번호를 입력해주세요"); 
         $("#mb_pw").focus(); 
         
         return false; 
      }
      
      //비밀번호 확인 검사
      if($("#mb_pw").val() != $("#mb_pwcheck").val()){ 
         alert("비밀번호가 일치하지 않습니다"); 
         $("#mb_pwcheck").focus(); 
         
         return false; 
      }
      
      // 우편 번호 및 도로명 주소 공백 검사
      if($("#mb_ad1").val() == ""){ 
         alert("주소를 입력해주세요"); 
         $("#mb_ad1").focus(); 
         
         return false; 
      }
      
      // 상세 주소 공백 검사
      if($("#mb_ad3").val() == ""){ 
         alert("상세주소를 입력해주세요"); 
         $("#mb_ad3").focus(); 
         
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
   <br>
   <h1 class="mt-4" style="text-align : center;">Member Update</h1>
      <form style="text-align:center" method="post" enctype="multipart/form-data">
         <input type="hidden" name="mb_number" id="mb_number" value="${memberDetail.mb_number}">
         <input type="hidden" name="mb_id" id="mb_id" value="${memberDetail.mb_id }">
         <br><input type="text" name="mb_id1" id="mb_id1" placeholder="${memberDetail.mb_id }" style="width:330px; height:40px; background-color: #e2e2e2;" readonly><br>
         
         <input type="hidden" name="mb_name" id="mb_name" value="${memberDetail.mb_name }">
         <br><input type="text" name="mb_name1" id="mb_name1" placeholder="${memberDetail.mb_name }" style="width:330px;  height:40px; background-color: #e2e2e2;" readonly><br>
         
         <br><input type="password" name="mb_pw" id="mb_pw" placeholder="비밀번호" style="width:330px; height:40px;" maxlength="45"><br>
         <br><input type="password" name="mb_pwcheck" id="mb_pwcheck" placeholder="비밀번호 확인" style="width:330px; height:40px;" maxlength="45"><br>
         
         <br><input type="text" name="mb_ad1" id="mb_ad1" value=${memberDetail.mb_ad1 } style="width:210px;  height:40px; background-color: #e2e2e2;" maxlength="200"  readonly>
         <input type="button" onclick="adfinding()" value="우편번호 검색" style="height:40px; width:115px;"><br>
         <br><input type="text" name="mb_ad2" id="mb_ad2" value="${memberDetail.mb_ad2 }" style="width:330px;  height:40px; background-color: #e2e2e2;" maxlength="200" readonly><br>
         <br><input type="text" name="mb_ad3" id="mb_ad3" value="${memberDetail.mb_ad3 }" style="width:330px;  height:40px;" maxlength="200"><br>
         
         
         <input type="hidden" name="mb_email" id="mb_email" value="${memberDetail.mb_email }">
         <br><input type="text" name="mb_email" id="mb_email" placeholder="${memberDetail.mb_email} " style="width:330px; height:40px; background-color: #e2e2e2;" maxlength="50" readonly><br>
         
         <br><input type="text" name="mb_ph" id="mb_ph" value="${memberDetail.mb_ph }" style="width:330px;  height:40px;"><br>
         <br><input type="submit" id="submit" class="button" style="width:100px;" value="수정완료">
         <a href="${contextPath}/Member/memberList"><input type="button" value="취소"></a>
      </form>
   <%@include file="../include/footer.jsp"%>
</div>
</div>
</body>
</html>