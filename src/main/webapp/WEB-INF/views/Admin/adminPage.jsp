<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="a" value="0" />
<c:set var="b" value="0" />
<c:set var="c" value="0" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@include file="../include/header.jsp"%>
<title>BobMorning</title>
</head>
<body>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<style>
.admin_sales_table {
	width: 100%;
	margin-top: 15px;
}

.admin_sales_table tr {
	text-align: center;
}

.admin_salie_table_tr1 {
	background-color: #ccc;
}

.admin_sales_table td {
	border: 1px solid;
	padding: 8px;
}

.admin_text {
	width: 100px;
	text-align: center;
	border: none;
}

.admin_memberdiv {
	text-align: center;
	margin: 15px;
	border: 3px solid #ff3d09;
	padding: 15px;
	font-size: 18px;
}
</style>
	<!-- Page Content -->
	<div class="container">
		<%@include file="../include/sideMenu.jsp"%>
		<div class="bob_content">
			<h1 class="mt-4">Admin</h1>
			<hr style="border: 2px solid;">
			<br>
			<div class="admin">
				<div class="admin_order">
					<div style="font-size: 25px; text-align: center;">주문 관리</div>
					<c:forEach var="orderList" items="${orderList }">
						<c:if test="${orderList.od_state == 0}">
							<c:set var="a" value="${a + 1}" />
						</c:if>
						<c:if test="${orderList.od_state == 1}">
							<c:set var="b" value="${b + 1}" />
						</c:if>
						<c:if test="${orderList.od_state == 2}">
							<c:set var="c" value="${c + 1}" />
						</c:if>
					</c:forEach>

					<table class="admin_table">
						<tr>
							<td class="admin_td">
								<div class="admin_div1">입금 대기</div>
								<div class="admin_div2">
									<a href="">2</a> 건
								</div>
							</td>
							<td class="admin_td">
								<div class="admin_div1">결제 완료</div>
								<div class="admin_div2">
									<a href="">1</a> 건
								</div>
							</td>
							<td class="admin_td">
								<div class="admin_div1">배송 전</div>
								<div class="admin_div2">
									<a href="${contextPath }/Order/OrderList?od_state=0">${a }</a>
									건
								</div>
							</td>
						</tr>
						<tr>
							<td class="admin_td">
								<div class="admin_div1">배송 중</div>
								<div class="admin_div2">
									<a href="${contextPath }/Order/OrderList?od_state=1">${b }</a>
									건
								</div>
							</td>
							<td class="admin_td">
								<div class="admin_div1">배송 완료</div>
								<div class="admin_div2">
									<a href="${contextPath }/Order/OrderList?od_state=2">${c }</a>
									건
								</div>
							</td>
							<td class="admin_td">
								<div class="admin_div1">교환/환불 접수</div>
								<div class="admin_div2">
									<a href="">3</a> 건
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div class="admin_memo">
					<div style="font-size: 25px; text-align: center;">메모</div>
					<textarea style="width: 100%; height: 142px;">Memo</textarea>
				</div>
			</div>
			<div class="admin">
				<div class="admin_board">
					<h4 class="admin_h4">공지사항 
						<a href="${contextPath}/board/BoardRegister?bcode_number=9&pd_number=0" class="a_board"> 
							<input class="button_bu" type="button" value="작성"></a>
						<a href="${contextPath}/board/list_paging?bcode_number=9" class="a_board"> 
							<input class="button_bu" type="button" value="더보기"></a>
					</h4>
					<table class="board_table">
						<c:forEach var="noticelist" items="${noticeList}" varStatus="status"
							begin="0" end="4" step="1">
							<tr>
								<td><a href="../board/BoardDetail?page=1&perPageNum=10&bcode_number=9&b_number=${noticelist.b_number}">${noticelist.b_title}</a></td>
								<td style="text-align: right; color: #2848ab;">${noticelist.b_regdate}</td>
							</tr>
						</c:forEach>
					</table>
				</div>

				<div class="admin_QnA">
					<h4 class="admin_h4">QnA 접수 현황
					<a href="${contextPath}/board/list_paging?bcode_number=2" class="a_board"> 
						<input class="button_bu" type="button" value="더보기"></a>
					</h4>
					<table class="QnA_table">
						<c:forEach var="boardList" items="${boardList}" varStatus="status"
							begin="0" end="4" step="1">
							<tr>
								<td><a href="../board/BoardDetail?page=1&perPageNum=10&bcode_number=2&b_number=${boardList.b_number}">${boardList.b_title}</a></td>
								<td style="text-align: right; color: #2848ab;">${boardList.b_regdate}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<div class="admin_div">주요사항</div>
			<hr style="border: 2px solid;">

			<!-- Tab links -->
			<div class="tab">
				<button class="tablinks" onclick="openCity(event, 'London')"
					id="defaultOpen">매출 관리</button>
				<button class="tablinks" onclick="openCity(event, 'Tokyo')">게시판
					관리</button>
				<button class="tablinks" onclick="openCity(event, 'Seoul')">회원
					관리</button>
			</div>
			<!-- Tab content -->
			<div id="London" class="tabcontent">
				<div class="admin">
					<div class="admin_order" style="height: 450px;">
						<div style="font-size: 25px; text-align: center;">매출 관리</div>
						<table class="admin_sales_table">
							<tr class="admin_salie_table_tr1">
								<td>날짜</td>
								<td>판매 건수</td>
								<td>판매 금액</td>
							</tr>
							<c:forEach var="i" begin="0" end="6" varStatus="status">
								<tr>
									<td>${time[i]}</td>
									<td>${count[i]}</td>
									<td>${price[i]}</td>
								</tr>
							</c:forEach>
						</table>
					</div>

					<div class="admin_memo" style="height: 450px;">
						<div style="font-size: 25px; text-align: center;">그래프</div>
						<canvas id="myChart" width="400" height="400"></canvas>
					</div>
				</div>
			</div>

			<div id="Tokyo" class="tabcontent">
				<div class="admin">
					<div class="admin_order" style="height: 450px;">
						<div style="font-size: 25px; text-align: center;">게시판 관리</div>
						<table class="admin_sales_table">
							<tr class="admin_salie_table_tr1">
								<td>날짜</td>
								<td>교환/환불</td>
								<td>배송문의</td>
								<td>신고접수</td>
							</tr>
							<c:forEach var="i" begin="0" end="6" varStatus="status">
								<tr>
									<td>${time[i]}</td>
									<td>${boardCount[i][3]}</td>
									<td>${boardCount[i][4]}</td>
									<td>${boardCount[i][5]}</td>
								</tr>
							</c:forEach>
						</table>
					</div>

					<div class="admin_memo" style="height: 450px;">
						<div style="font-size: 25px; text-align: center;">그래프</div>
						<canvas id="myChart2" width="400" height="400"></canvas>
					</div>
				</div>
			</div>

			<div id="Seoul" class="tabcontent">
				<div class="admin">
					<div class="admin_order" style="height: 500px;">
						<div style="font-size: 25px; text-align: center;">회원 관리</div>
						<table class="admin_sales_table">
							<tr class="admin_salie_table_tr1">
								<td>날짜</td>
								<td>신규회원</td>
							</tr>
							<c:forEach var="i" begin="0" end="6" varStatus="status">
								<tr>
									<td>${time[i]}</td>
									<td>${signUpCount[i]}</td>
								</tr>
							</c:forEach>
						</table>
						<div class="admin_memberdiv">
							총 회원수 : ${memberCount } <input type="button" value="회원관리"
								onClick="location.href='${contextPath}/Member/memberList'"
								style="float: right;">
						</div>
					</div>

					<div class="admin_memo" style="height: 500px;">
						<div style="font-size: 25px; text-align: center;">그래프</div>
						<canvas id="myChart3" width="400" height="400"></canvas>
					</div>
				</div>
			</div>
			<%@include file="../include/footer.jsp"%>

		</div>
	</div>
</body>
<script>
var today = new Date();
var time = new Array();

for(var i=0; i<7; i++){
   time[i] = (today.getMonth()+1)+'/'+today.getDate();
   today.setDate(today.getDate()-1);
}

var ctx = document.getElementById('myChart').getContext('2d');
var chart = new Chart(ctx, { // 챠트 종류를 선택 
   type : 'line',
   // 챠트를 그릴 데이타 
   data : {
	   labels : [time[6],time[5],time[4],time[3],time[2],time[1],time[0]],
      datasets : [ {
         label : '매출 금액',
         backgroundColor : 'transparent',
         borderColor : 'red',
         data : [${price[6] }, ${price[5] }, ${price[4] }, ${price[3] }, ${price[2] }, ${price[1] }, ${price[0] }]
      }]
   },
   // 옵션 
   options : {}
});
</script>
<script>
var ctx = document.getElementById('myChart2').getContext('2d');
var chart = new Chart(ctx, { // 챠트 종류를 선택 
   type : 'line',
   // 챠트를 그릴 데이타 
   data : {
	   labels : [time[6],time[5],time[4],time[3],time[2],time[1],time[0]],

      datasets : [ {
         label : '교환/환불',
         backgroundColor : 'transparent',
         borderColor : 'red',
         data : [${boardCount[6][3]},${boardCount[5][3]},${boardCount[4][3]},${boardCount[3][3]},
            ${boardCount[2][3]},${boardCount[1][3]},${boardCount[0][3]}]
      },{
         label : '배송문의',
         backgroundColor : 'transparent',
         borderColor : 'green',
         data : [${boardCount[6][4]},${boardCount[5][4]},${boardCount[4][4]},${boardCount[3][4]},
            ${boardCount[2][4]},${boardCount[1][4]},${boardCount[0][4]}]
      },{
         label : '신고접수',
         backgroundColor : 'transparent',
         borderColor : 'blue',
         data : [${boardCount[6][5]},${boardCount[5][5]},${boardCount[4][5]},${boardCount[3][5]},
            ${boardCount[2][5]},${boardCount[1][5]},${boardCount[0][5]}]
      } ]
   },
   // 옵션 
   options : {}
});
</script>
<script>
var ctx = document.getElementById('myChart3').getContext('2d');
var chart = new Chart(ctx, { // 챠트 종류를 선택 
   type : 'line',
   // 챠트를 그릴 데이타 
   data : {
	   labels : [time[6],time[5],time[4],time[3],time[2],time[1],time[0]],

      datasets : [ {
         label : '회원 가입 수',
         backgroundColor : 'transparent',
         borderColor : 'red',
         data : [${signUpCount[6] },${signUpCount[5] },${signUpCount[4] },${signUpCount[3] },
            ${signUpCount[2] },${signUpCount[1] },${signUpCount[0] }]
      } ]
   },
   // 옵션 
   options : {}
});

</script>
<script>
function openCity(evt, cityName) {
     // Declare all variables
     var i, tabcontent, tablinks;

     // Get all elements with class="tabcontent" and hide them
     tabcontent = document.getElementsByClassName("tabcontent");
     for (i = 0; i < tabcontent.length; i++) {
       tabcontent[i].style.display = "none";
     }

     // Get all elements with class="tablinks" and remove the class "active"
     tablinks = document.getElementsByClassName("tablinks");
     for (i = 0; i < tablinks.length; i++) {
       tablinks[i].className = tablinks[i].className.replace(" active", "");
     }

     // Show the current tab, and add an "active" class to the button that opened the tab
     document.getElementById(cityName).style.display = "block";
     evt.currentTarget.className += " active";
}
document.getElementById("defaultOpen").click();

var now_date = new Date();
document.getElementById("now_date").value = now_date;


var arrNumber = new Array();
var ctx = document.getElementById('myChart').getContext('2d');

$(document).ready(function(){
   cartList();
});

</script>


</html>