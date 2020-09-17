<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용약관</title>
<%@include file="../include/header.jsp"%>
<script type="text/javascript">
   $(document).ready(function(){
      $("#submit").on("click", function(){
         if($('input:checkbox[id="agree"]').is(":checked")==false){
            alert("약관에 동의해주세요.");
            $("#submit").focus();
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
         <h1 class="mt-4">Terms of Use</h1>
         <hr><br><br>
         
         <div class="panel-body">
            <div class="row">
            
                <div class="col-lg-12">
               <h4>이용약관</h4>
                  
                <div class="panel-body" style="border: 1px solid #ccc">
                   <p>
                      
제1장 총칙

 

제1조 (목적)
이 약관은 BAB-Morning 주식회사(이하 “밥모닝”)가 제공하는 위치기반서비스(이하 ‘서비스’)에 관하여 회사와 이용계약을 체결한 고객이 서비스를 이용하는 데 필요한 회사와 고객의 권리 및 의무, 기타 제반 사항을 정함을 목적으로 합니다.

 

제2조 (약관의 효력 및 변경)
① 본 약관은 본 서비스를 이용하고자 하는 모든 고객을 대상으로 합니다. ② 본 약관의 내용은 서비스 화면에 게시하거나 기타의 방법으로 고객에게 공시하고, 이에 동의한 고객이 본 서비스에 가입함으로써 효력이 발생합니다.
                   </p>
                </div>
              <br><br>
                <h4>개인정보</h4>
                 <div class="panel-body" style="border: 1px solid #ccc">
                    <p>
                     개인정보 동의
① 서비스에 가입할 수 있는 자는 위치기반서비스를 이용할 수 있는 이동전화 단말기, 기타 서비스를 이용할 수 있는 단말기(이하 “단말기”)의 소유자 본인이어야 합니다.
② 법인은 법인의 사업자번호를 사용하여 서비스에 가입할 수 있습니다.

 

제5조 (서비스 가입)
회사는 다음 각 호의 고객 가입신청을 승낙하지 않을 수 있습니다.
1. 실명이 아니거나 다른 사람의 명의를 사용하는 등 허위로 신청하는 경우
2. 고객 등록 사항을 빠뜨리거나 잘못 기재하여 신청하는 경우
3. 공공질서 또는 미풍양속을 해치거나 그럴 목적으로 신청한 경우
4. 기타 회사가 정한 이용신청 요건을 충족하지 않았을 경우

 

제6조 (서비스의 해지)
서비스 해지를 희망하는 고객은 회사가 정한 절차(유무선 인터넷 홈페이지 등을 통해 공지합니다)를 통해 서비스 해지를 신청할 수 있습니다.
                    </p>
              </div>
              
                 <form role="form" action="${contextPath}/Member/SignUp2">
                  <div class="form-group">
                   
                   <br><br>
                   <label class="checkbox-inline">
                       <input type="checkbox" id="agree">동의합니다.
                   </label>
                     </div>
                     <hr>
                  <input type="submit" id="submit" value="다음 단계">
              </form>
             </div>
         </div>
         </div>
      </div>
   </div>

</body>
</html>