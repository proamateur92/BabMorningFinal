<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
body {
  font-family: "Lato", sans-serif;
}

.sidenav {
  width: 150px;
  z-index: 1;
  top: 20px;
  left: 10px;
  overflow-x: hidden;
  padding: 8px 0;
}

.sidenav a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  font-size: 25px;
  color: #22B14C;
  display: block;
}

.sidenav a:hover {
  color: #064579;
}
</style>
   <div class = "bob_side">
      <h6><br><hr></h6>
      <h2>BAB-<br>Morning<hr></h2>
      <!--  
         <c:if test="${member.mb_id eq 'admin' and member.mb_pw eq '123'}">
            <li class="bob_sideMenu"><a href="${contextPath}/Product/ProductList">PRODUCT</a></li>
            <li class="bob_sideMenu"><a href="${contextPath}/Member/memberList">MemberList</a></li>
            <li class="bob_sideMenu"><a href="${contextPath}/Admin/adminPage">Admin</a></li>
            <li class="bob_sideMenu"><a href="${contextPath}/Product/Notice">Notice</a></li>
         </c:if>
         
         <li class="bob_sideMenu"><a href="${contextPath}/board/list_paging?bcode_number=1" >후기게시판</a></li>
         <li class="bob_sideMenu"><a href="${contextPath}/board/list_paging?bcode_number=2" >Q&A게시판</a></li>
         <li class="bob_sideMenu"><a href="${contextPath}/Order/Paypay">결제</a></li>
      -->
      
      
      
      
      <div class="sidenav">
     	<c:if test="${member.mb_id == 'admin' }">
	        <a class="aa" href="${contextPath}/Admin/adminPage">Admin</a>
	        <a href="${contextPath}/Member/memberList">Member</a>
      	</c:if>
        <a href="${contextPath}/Product/ProductList">Shopping</a>
        <a href="${contextPath}/board/list_paging?bcode_number=6">Board</a>
        	<c:if test="${member != null }">
            	<a class="nav-link" href="${contextPath}/Member/Mypage?mb_number=${member.mb_number}">MyPage</a>
            	<a class="nav-link" href="${contextPath}/Product/CartView2">Cart</a>            	
            </c:if>
            <c:if test="${member == null }">	
				<a class="nav-link" href='javascript: login_check();'>MyPage</a>
				<a class="nav-link" href='javascript: login_check();'>Cart</a>
			</c:if>
		<a class="nav-link" href="${contextPath}/board/list_paging?bcode_number=2">Q&A</a>	
      </div>
   </div>
</body>
</html>