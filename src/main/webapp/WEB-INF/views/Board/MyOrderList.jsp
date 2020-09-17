<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>내 주문목록</title>
<%@include file="../include/header.jsp"%>
</head>
<body>
<script>
	$(document).ready(function () {
	    $("#searchBtn").on("click", function (event) {
	        self.location =
	            "list_paging${pageMaker.makeQuery(1)}"
	            +"&bcode_number=8" 
	            + "&searchType=" + $("select option:selected").val()
	            + "&keyword=" + encodeURIComponent($("#keywordInput").val());
	    });
	});

	
</script>
<style>
<style>
	li{
		display : inline-block;
	}
	.review_table{
		width : 100%;
		margin : 20px 0 10px 0;
		border-top: 2px solid;
    	border-bottom: 2px solid;
	}
	.review_table tr{
		border-bottom: 1px solid #aaa;
	}
	.review_table td{
		padding : 12px;
	}
	.review_table2 {
		width : 100%;
	}
	.review_table2 tr{

	}
	.review_table2 td{
		padding : 12px 6px 12px 6px;
	}
</style>
	
	<!-- Page Content -->
	<div class="container">
		<%@include file="../include/sideMenu.jsp"%>		
		<br>
		<div class = "bob_content">
		<div class="table-responsive">
		<h1 style="font-family: Lato, sans-serif; font-weight: 600;">내 주문목록</h1>
		  <table class="table">
            <tr style="background-color : #FBFBFB;">
               <td style="width : 10%;">번호</td>
               <td style="width : 20%;">상품명</td>
               <td style="width : 20%;">구매자</td>
               <td style="width : 50%;">주문일자</td>
            </tr>            

            <c:forEach var="orderList" items="${orderList}" varStatus="status" >
            <tr>
               <td>${orderList.od_number}</td>
               <td><a href = "${contextPath }/Member/OrderDetail?od_id=${orderList.od_id}">${orderList.mypage_odname}</a></td>
               <td>${member.mb_name }</td>
               <td>${orderList.od_date}
               </td>
               
					<!-- Modal HTML embedded directly into document -->
            </tr>
					<div id="ex${status.index }" class="modal">
						<div style="background-color: #404b66; color : white; text-align : center; padding : 15px;">
							<h3>오늘 ${orderList.od_date} <br>
								고객님의 상품이 발송됩니다.</h3><br>
								배송 완료일은 ${orderList.od_date} 입니다.<br>
						</div>
						
						
					  <div class="items">
					  	<c:choose>
					  	  <c:when test="${orderList.od_state == 0}">
					  	  <br>
					  	  	<div style="width : 100%; text-align : center;">
					  	  		<div class="mypage_imgdiv">
							  		<img src="${contextPath}/resources/img/wallet.png" style="background-color:#67de9f" class="mypage_icons"><br>
							  		결제완료
					  	  		</div>
					           	
					           	<div class="mypage_imgdiv">
								  	<img src="${contextPath}/resources/img/loading.png" style="background-color:#67de9f"  class="mypage_icons"><br>
								  	상품준비중
					           	</div >
					           	
					           	<div class="mypage_imgdiv">
									<img src="${contextPath}/resources/img/flag.png" class="mypage_icons"><br>
								  	배송시작
					           	</div>
					           	
					           	<div class="mypage_imgdiv" style="margin-left : 113px;">
					           		<img src="${contextPath}/resources/img/truck.png" class="mypage_icons"><br>
								  	배송중
					           	</div>
					           	
					           	<div class="mypage_imgdiv">
								  	<img src="${contextPath}/resources/img/pin.png" class="mypage_icons"><br>
								  	배송완료
					           	</div>						  	
							</div>
							  <br>
					  	  </c:when>
					  	  <c:when test="${orderList.od_state == 1}">
					  	  <br>
					  	  	<div style="width : 100%; text-align : center;">
					  	  		<div class="mypage_imgdiv">
							  		<img src="${contextPath}/resources/img/wallet.png" style="background-color:#67de9f" class="mypage_icons" ><br>
							  		결제완료
					  	  		</div>
					           	
					           	<div class="mypage_imgdiv">
								  	<img src="${contextPath}/resources/img/loading.png" style="background-color:#67de9f" class="mypage_icons"><br>
								  	상품준비중
					           	</div >
					           	
					           	<div class="mypage_imgdiv">
									<img src="${contextPath}/resources/img/flag.png" style="background-color:#67de9f" class="mypage_icons"><br>
								  	배송시작
					           	</div>
					           	
					           	<div class="mypage_imgdiv" style="margin-left : 113px;">
					           		<img src="${contextPath}/resources/img/truck.png" style="background-color:#67de9f" class="mypage_icons"><br>
								  	배송중
					           	</div>
					           	
					           	<div class="mypage_imgdiv">
								  	<img src="${contextPath}/resources/img/pin.png" class="mypage_icons"><br>
								  	배송완료
					           	</div>						  	
							</div>
							  <br>
					  	  </c:when>
					  	  <c:when test="${orderList.od_state == 2}">
					  	  	<div style="width : 100%; text-align : center;">
					  	  <br>
					  	  		<div class="mypage_imgdiv">
							  		<img src="${contextPath}/resources/img/wallet.png" style="background-color:#67de9f" class="mypage_icons"><br>
							  		결제완료
					  	  		</div>
					           	
					           	<div class="mypage_imgdiv">
								  	<img src="${contextPath}/resources/img/loading.png" style="background-color:#67de9f" class="mypage_icons"><br>
								  	상품준비중
					           	</div >
					           	
					           	<div class="mypage_imgdiv">
									<img src="${contextPath}/resources/img/flag.png" style="background-color:#67de9f" class="mypage_icons"><br>
								  	배송시작
					           	</div>
					           	
					           	<div class="mypage_imgdiv" style="margin-left : 113px;">
					           		<img src="${contextPath}/resources/img/truck.png" style="background-color:#67de9f" class="mypage_icons"><br>
								  	배송중
					           	</div>
					           	
					           	<div class="mypage_imgdiv">
								  	<img src="${contextPath}/resources/img/pin.png" style="background-color:#67de9f" class="mypage_icons"><br>
								  	배송완료
					           	</div>						  	
							</div>
					  	  </c:when>
					  	</c:choose>
					  </div><br>
							  <div style="background-color: white; height : 100%; text-align : center; font-size:25px;">
							  	<c:if test="${orderList.od_state == 0}">
							  	현재 ${orderList.od_name }님의 상품을 준비하고 있습니다. (^-^)
							  	</c:if>
							  	<c:if test="${orderList.od_state == 1}">
							  	현재 ${orderList.od_name }님의 상품을 신속하게 운송중입니다. (^o^)
							  	</c:if>
							  	<c:if test="${orderList.od_state == 2}">
							  	현재 ${orderList.od_name }님의 상품이 안전하게 배송되었습니다. (_ _)<br>
							  	저희 Bab Morning을 이용해주셔서 감사합니다.
							  	</c:if>
							  </div>
					</div>
            </c:forEach>
         </table>
			
		        <ul class="pagination">
		            <c:if test="${pageMaker.prev}">
		                <li><a href="${contextPath}/board/list_paging?page=${pageMaker.startPage - 1}&perPageNum=10&bcode_number=8&searchType=${pageMaker.criteria.searchType}&keyword=${pageMaker.criteria.keyword}">이전</a></li>
		            </c:if>
		            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		                <li <c:out value="${pageMaker.criteria.page == idx ? 'class=active' : ''}"/>>
		                    <a href="${contextPath}/board/list_paging?page=${idx}&perPageNum=10&bcode_number=8&searchType=${pageMaker.criteria.searchType}&keyword=${pageMaker.criteria.keyword}">${idx}</a>
		                </li>
		            </c:forEach>
		            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		                <li><a href="${contextPath}/board/list_paging?bcode_number=8&page=${pageMaker.endPage + 1}&perPageNum=10&bcode_number=6&searchType=${pageMaker.criteria.searchType}&keyword=${pageMaker.criteria.keyword}">다음</a></li>
		            </c:if>
		        </ul>
			</div>
			<%@include file="../include/footer.jsp"%>
		</div>
	</div>
</body>
</html>