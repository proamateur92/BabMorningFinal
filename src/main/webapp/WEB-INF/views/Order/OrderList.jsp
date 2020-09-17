<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 관리</title>
<%@include file="../include/header.jsp"%>
<script>
	function change(od_state${num}, od_id){
		if(od_state==-1){
			alert("배송상태를 선택해주세요.");
			return false;
		} 
		$.ajax({
			type: 'POST',
			url: "${contextPath}/Order/OrderUpdateState",
			data: {"od_state" : od_state,
				"od_id" : od_id},
			success: function(data){
				if(data){
					alert("배송상태 변경완료");
					window.location.href = data;
				}
			},
			error:function(data){
				alert("에러가 발생하였습니다.");
			},
		});
	};
</script>
</head>
<body>
	
	<div class="container">
		<%@include file="../include/sideMenu.jsp"%>
		<div class = "bob_content">
			<br>
			<h1>Order List</h1>
			<br>
		<div class = "table-responsive">
		<table class="table" >
		<tr style="text-align: center;">
			<td>NO.</td>
			<td>ORDER NAME</td>
			<td>RECEIVER</td>
			<td>DATE</td>
			<td>STATE</td>
			<td>STATE_CHANGE</td>
		</tr>
		<c:set var="num" value="0" />
		<c:forEach var="orderList" items="${orderList}">
			<c:if test="${state==orderList.od_state}">
			<tr>
				<td>${orderList.od_number}</td>
				<td>${orderList.od_id}</td>
				<td>${orderList.od_name}</td>
				<td>${orderList.od_date}</td>
				
				<c:choose>
					<c:when test="${orderList.od_state == 1}"><td>배송중</td></c:when>
					<c:when test="${orderList.od_state == 2}"><td>배송완료</td></c:when>
					<c:otherwise><td>배송전</td></c:otherwise>
				</c:choose>
					<td><select name="od_state" id="od_state${num }">
						<c:if test="${orderList.od_state==0 }">
							<option value=-1>▒▒선택▒▒</option>
							<option value=1>배송중</option>
							<option value=2>배송완료</option>
						</c:if>
						<c:if test="${orderList.od_state==1 }">
							<option value=-1>▒▒선택▒▒</option>
							<option value=0>배송전</option>
							<option value=2>배송완료</option>
						</c:if>
						<c:if test="${orderList.od_state==2 }">
							<option value=-1>▒▒선택▒▒</option>
							<option value=0>배송전</option>
							<option value=1>배송중</option>
						</c:if>
					</select>
					<input type="button" onclick="change($('#od_state${num }').val(),'${orderList.od_id }')" value="확인">
					</td>
			</tr>
			</c:if>
			<c:set var="num" value="${num + 1}" />
		</c:forEach>
		</table>
			</div>
		</div>
	</div>
</body>
</html>