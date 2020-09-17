<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri= "http://java.sun.com/jsp/jstl/core" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<style>
.star-input>.input,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('../resources/star/img/grade_img.png')no-repeat;}
.star-input{display:inline-block; white-space:nowrap;width:225px;height:40px;padding:25px;line-height:30px;}
.star-input>.input{display:inline-block;width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position: relative;}
.star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
.star-input>.input.focus{outline:1px dotted #ddd;}
.star-input>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
.star-input>.input>label,
.star-input>.input>label[for="p1"]{width:30px;z-index:5;}
.star-input>.input>label[for="p2"]{width:60px;z-index:4;}
.star-input>.input>label[for="p3"]{width:90px;z-index:3;}
.star-input>.input>label[for="p4"]{width:120px;z-index:2;}
.star-input>.input>label[for="p5"]{width:150px;z-index:1;}
.star-input>output{display:inline-block;width:60px; font-size:18px;text-align:right; vertical-align:middle;}
</style>
<meta charset="UTF-8">
<title>글쓰기</title>
<%@include file="../include/header.jsp"%>
<script>
	$(document).ready(function(){
		
	
		$("#submit").click(function(){
			if($('#b_title').val() == "")
			{
				alert("제목을 입력하세요");	
				return false;
			}			
			if($("#b_content").val() == "")
			{
				alert("내용을 입력하세요");
				return false;
			}			
		});
		
		$(document).on('click', '[name="pd_star"]', function () {
			var htmls = '';
			var radioVal = $('input[name="pd_star"]:checked').val();		   	
		    htmls += '<b id ="star">'+ radioVal +'</b>';		    
		    $("#star").replaceWith(htmls);
		});		
	});
	
	function boardStateqna(){
		
		var boardstate = $('#boardstate').val();
		if(boardstate <= 0){
			alert("글종류를 선택하세요.");
			return false;
		}
		$('#state').val(boardstate);
		
	};
	
function boardState(){
		var state = ${list_number};
		$('#state').val(state);		
	};
	
	
</script>


</head>
<body>
<div class="container">
	<%@include file="../include/sideMenu.jsp"%>
	<br>
		<div class = "bob_content">
		<section class="content">
			<div class="box-header">
				<c:if test="${list_number != 9 }">
					<h3 class="box-title">게시판 글쓰기</h3>
				</c:if>
				<c:if test="${list_number == 9 }">
					<h3 class="box-title">공지사항 작성</h3>
				</c:if>
			</div>		
		
			<form role="form" method="post">
				<div class="box-body">
					<div class="form-group">
					<c:if test = "${list_number == 2 }">
						<select id = "boardstate">
							<option value = "0" >--선택--</option>
							<option value = "2" >Q&A</option>
							<option value = "3">교환/환불</option>
							<option value = "4" >배송문의</option>
							<option value = "5" >신고접수</option>
						</select>
					</c:if>
					<c:if test = "${list_number == 9 }">
						<select id = "boardstate">
							<option value = "0" >--선택--</option>
							<option value = "2" >Q&A</option>
							<option value = "6">자유게시판</option>
						</select>
					</c:if>
						<label>제목</label> 
						<input type="text" id = "b_title" name="b_title" class="form-control" placeholder="제목을 입력하세요">						
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" id="b_content" name="b_content" rows="3" placeholder="내용을 입력하세요"></textarea>
					</div>		
					<div class="form-group">
						<label>작성자</label> 
						<input type="text" name="b_id" class="form-control" value="${member.mb_id}" readonly>					
					</div>
					<c:if test = "${list_number == 1 }">
					<div>
						<label>별점</label>
						<span class="star-input">
							<span class="input">
						    	<input type="radio" name = "pd_star" value="1" id="p1" checked = "checked">
						    	<label for="p1">1</label>
						    	<input type="radio" name = "pd_star" value="2" id="p2">
						    	<label for="p2">2</label>
						    	<input type="radio" name = "pd_star" value="3" id="p3">
						    	<label for="p3">3</label>
						    	<input type="radio" name = "pd_star" value="4" id="p4">
						    	<label for="p4">4</label>
						    	<input type="radio" name = "pd_star" value="5" id="p5">
						    	<label for="p5">5</label>
						  	</span>
						  	<output for="star-input"><b id ="star">1</b>점</output>						 	
						</span>
					</div>
					</c:if>					
				</div>
					<c:if test = "${list_number == 1}">
						<input type = "hidden" name = "pd_number" value = "${pd_number }">
					</c:if>
					
					<input type="hidden" id="state" name = "boardstate" >
					<c:if test = "${list_number == 2 || list_number == 9}">
						<button type="submit" onclick="return boardStateqna()" class="btn btn-primary" id = "submit">완료</button>	
					</c:if>
					<c:if test = "${list_number != 2 && list_number != 9}">				
						<button type="submit" onclick="return boardState()" class="btn btn-primary" id = "submit">완료</button>
					</c:if>
					
					
					
					
					
					<button type="button" class="btn btn-danger" onclick="location.href='${contextPath}/board/list_paging?bcode_number=${list_number}'">취소</button>							
			</form>
		</section>
		</div>
	</div>
</body>



</html>