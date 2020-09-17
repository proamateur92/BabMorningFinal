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
.star-input>.input,
.star>.input>input:focus+label,
.star>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('../resources/star/img/grade_img.png')no-repeat;}
.star-input{display:inline-block; white-space:nowrap;width:225px;height:40px;padding:25px;line-height:30px;}

.star>.input{display:inline-block;width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position: relative;}

.star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
.star-input>.input.focus{outline:1px dotted #ddd;}
.star>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
.star>.input>label:hover,
.star>.input>input:focus+label,
.star>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
.star>.input>label,
.star-input>.input>label[for="p1"]{width:30px;z-index:5;}
.star-input>.input>label[for="p2"]{width:60px;z-index:4;}
.star-input>.input>label[for="p3"]{width:90px;z-index:3;}
.star-input>.input>label[for="p4"]{width:120px;z-index:2;}
.star-input>.input>label[for="p5"]{width:150px;z-index:1;}
.star>output{display:inline-block;width:60px; font-size:18px;text-align:right; vertical-align:middle;}
</style>
<meta charset="UTF-8">
<script src="<c:url value='/resources/jQuery/jquery-3.4.1.min.js'/>"></script>
<title>글 상세 보기</title>
<%@include file="../include/header.jsp"%>
</head>
<body>
	<div class="container">	
	<%@include file="../include/sideMenu.jsp"%>	
	<script>
		$(document).ready(function(){
			replylist();
			getlike();
			likecnt();
		});
		
		//댓글 저장 버튼 클릭시 이벤트
		$(document).on('click','#btnReplySave',function(){
			var re_content = $('#re_content').val();
			var re_writer = $('#re_writer').val();
			var b_writer = "${boardDetail.b_id}";
			var url = "${contextPath}/board/replyRegister";
			var paramData = {
					"re_content" : re_content,
					"re_writer" : re_writer,
					"b_number" : "${boardDetail.b_number}"
			};
			
			if(${boardDetail.bcode_number} == 9 || ${boardDetail.bcode_number} == 6 && "${member.mb_id}" != 'admin'){
				alert("권한이 없습니다.");
				return;
			}
				
			
			if(${boardDetail.bcode_number} >= 2 && ${boardDetail.bcode_number} <=5)
			{
				if("${member.mb_id}" != 'admin' && "${member.mb_id}" != b_writer){
					alert("권한이 없습니다.");
					return;
				}
			}
			$.ajax({
				type : "POST",
				url : url,
				data : paramData,
				dataType : 'json',
				success : function(result){
					replylist();
					
					$('#re_content').val('');
				},
				error: function(error){
					console.log("에러 :" + error);
				}
			});
		});
		
		//댓글 보기///////////////////////////////////////////////////
		function replylist(){
			var url = "${contextPath}/board/getReply";
			var paramData = {"b_number":"${boardDetail.b_number}"};
			var id = "${member.mb_id}";
			console.log(id);
			$.ajax({
				type : 'POST',
				url : url,
				data : paramData,
				dataType: 'json',
				success : function(result){
					var htmls = "";
					if(result.length < 1)
					{
						htmls+="<hr>";	
						htmls+="<br>";	
						htmls+="등록된 댓글이 없습니다.";				
					}
					else
					{						
						$(result).each(function(){							
							htmls += '<div class = "table-responsive" id = "re_number' + this.re_number + '" >';
							htmls += '<table class = "table">';
							htmls += '<tr><td><strong>댓글번호 : ' + this.re_number + '&nbsp&nbsp&nbsp&nbsp</strong>';
							if(id == this.re_writer)
							{
								htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.re_number + ', \'' + this.re_writer + '\', \'' + this.re_content + '\' )" style="padding-right:5px">수정</a>';							
								htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.re_number + ')" >삭제</a></td>';
							}             
		                    htmls += '<strong><td>' + this.re_date + '&nbsp&nbsp</td></strong></tr>';
							htmls += '<tr><td><strong>작성자 : ' + this.re_writer + '</strong>';
							htmls += '<strong>&nbsp&nbsp&nbsp&nbsp&nbsp 내용 : ' + this.re_content + '</strong></td></tr>';
							htmls += '</table>';
							htmls += '</div>';
						}); //each end //////////
					}
					$("#replylist").html(htmls);
				}, 
				erorr : function(data){
					alert("에러발생");
				}
						
			});//Ajax End//////////////	
		}
		
		
		/////////////////댓글 수정//////////////////////////	
		function fn_editReply(re_number, re_writer, re_content){
	   		var htmls = "";
			
	   		htmls += '<div class="media text-muted pt-3" id="re_number' + re_number + '">';	
	  		htmls += '<span>';
	   		htmls +=  re_number + ' - ';
	  		htmls += '<strong>' + re_writer + '</strong>';
	 		htmls += '<span style="padding-left: 7px; font-size: 9pt"><hr>';
	   		htmls += '<a href="javascript:void(0)" onclick="fn_updateReply(' + re_number + ', \'' + re_writer + '\')" style="padding-right:5px">저장</a>';
	   		htmls += '<a href="javascript:void(0)" onClick="replylist()">취소<a>';
	   		htmls += '</span>';
	   		htmls += '</span>';      
	   		htmls += '<textarea name="editrememo" id="editrememo" class="form-control" rows="3">';
	   		htmls += re_content;
	   		htmls += '</textarea>';
	   		htmls += '</p>';	   		
	   		htmls += '</div>'; 
	   		
	  	 	$('#re_number' + re_number).replaceWith(htmls);  //  선택한 요소를 다른 것으로 바꿉니다.변경(바꾸기)
	  		$('#re_number' + re_number + ' #editrememo').focus();	
	  	 	
		}

		// 댓글 수정 저장

		function fn_updateReply(re_number, re_writer){
		   var editrememo = $("#editrememo").val();
		   var url = "${contextPath}/board/replyUpdate";
		   var paramData = {
				   "re_number" : re_number,
		         "re_content" : editrememo         
		   };  //수정			
		   
		   $.ajax({
		        type: 'POST',
		        url: url,
		        data : paramData,
		        dataType: 'json',
		        success: function() {
		             replylist();  // 댓글리스트 호출	           
		        },
		        error:function(data){
		         alert("에러가 발생했습니다.")
		      }
		   });
		   
		}
		//댓글 삭제
		function fn_deleteReply(re_number){
			   var url = "${contextPath}/board/deleteReply";//수정
			   var paramData = {"re_number" : re_number};  //수정

			   $.ajax({
			        type: 'POST',
			        url: url,
			        data : paramData,
			        dataType: 'json',
			        success: function(result) {
			          console.log(result);    
			             replylist();  // 댓글리스트 호출
			           
			        },
			        error:function(data){
			         alert("에러가 발생했습니다.")
			      }
			   });
			}
		
		/////////////////////////////////////좋아요/////////////////////////////////////////////////////////////////////////
		
		//게시글 좋아요 클릭		
		function like_func(){
			if("${member.mb_id}" == "")
			{
				alert("로그인하세요");
				return false;
			}
			var url = "${contextPath}/board/BoardLike";			
			var paramData = {
					 "b_number": "${boardDetail.b_number}",
					 "mb_id" : "${member.mb_id}"
					   };
		   $.ajax({
			    url: url,
		        type: 'POST',		        
		        data : paramData,
		        success: function(str){
		        	likecnt();
		        	getlike();
		        },
		        error:function(str){
		        	
		      }
		   });
		}
		
		//좋아요버튼을 누른 상태인지 아닌지에 따라 다른 이미지 보여주기
		//빈 하트 일 경우 like_func() 호출
		//빨간 하트일 경우 deletelike() 호출
		function getlike()
		{
			var htmls ="";
			var url = "${contextPath}/board/GetLike";
			var paramData = {
					"b_number":"${boardDetail.b_number}",
					"mb_id" : "${member.mb_id}"
					};
			$.ajax({
				type : 'POST',
				url : url,
				data : paramData,
				success : function(result){
					if(result != null){
		        		like_img = "<a href='javascript: deletelike();' id='hate_img'><img src='${contextPath}/resources/img/like.png' style = 'width : 30px'></a>";
		        		$('#hate_img').replaceWith(like_img);		        		
		        		}					
					
				},
				erorr : function(){
				}
				
			});//Ajax End//////////////	
		}
		
		//좋아요 취소 
		function deletelike()
		{
			var like_img ="";
			var url = "${contextPath}/board/DeleteLike";
			var paramData = {
					"b_number":"${boardDetail.b_number}",
					"mb_id" : "${member.mb_id}"
					};
			$.ajax({
				type : 'POST',
				url : url,
				data : paramData,
				success : function(){
					likecnt();	//카운팅 함수 호출
					like_img = "<a href='javascript: like_func();' id='hate_img'><img src='${contextPath}/resources/img/hate.png' style = 'width : 30px'></a>";
			        $('#hate_img').replaceWith(like_img);
					getlike();					
					
				},
				erorr : function(){
					
				}
						
			});//Ajax End//////////////	
		}
		
		//좋아요 카운팅
		function likecnt()
		{
			var like_cnt ="";
			var url = "${contextPath}/board/LikeCnt";
			var paramData = {"b_number":"${boardDetail.b_number}"};
			$.ajax({
				type : 'POST',
				url : url,
				data : paramData,
				success : function(result){
					like_cnt = '<span id="likecnt">'+ result + '</span>';
					$("#likecnt").replaceWith(like_cnt);
					
				},
				erorr : function(){					
				}
						
			});//Ajax End//////////////	
		}
	
		</script>

		<script>
		$(function () {
			
			var innerHtml = "";
			var r = ${boardDetail.getPdnum_star()};
			
			console.log(r);
				
				  if(r>=0.0 && r<=0.3) {
					 innerHtml  = '<img src ="${contextPath}/resources/star/img/star0.png" />' ; 
				  }
							  
				  else if(r>=0.4 && r<=0.7) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star05.png" />' ; 
				  }
				  
				  else if(r>=0.8 && r<=1.0) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star1.png" />' ; 
				  }
				  
				  else if(r>=1.1 && r<=1.3) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star1.png" />' ; 
			 	  }
								  
				  else if(r>=1.4 && r<=1.7) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star15.png" />' ; 
				  }
					  
				  else if(r>=1.8 && r<=2.0) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star2.png" />' ; 
				  }
				  
				  else if(r>=2.1 && r<=2.3) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star2.png" />' ; 
			 	  }
								  
				  else if(r>=2.4 && r<=2.7) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star25.png" />' ; 
				  }
					  
				  else if(r>=2.8 && r<=3.0) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star3.png" />' ; 
				  }
				  
				  else if(r>=3.1 && r<=3.3) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star3.png" />' ; 
			 	  }
								  
				  else if(r>=3.4 && r<=3.7) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star35.png" />' ; 
				  }
					  
				  else if(r>=3.8 && r<=4.0) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star4.png" />' ; 
				  }
				  
				  else if(r>=4.1 && r<=4.3) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star4.png" />' ; 
			 	  }
								  
				  else if(r>=4.4 && r<=4.7) {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star45.png" />' ; 
				  }
					  
				  else  {
					  innerHtml  = '<img src ="${contextPath}/resources/star/img/star5.png" />' ; 
				  }


				$('#pdf_star').html(innerHtml);
		});
		</script>

		<div class = "bob_content">
		<section class="content">
		<div class="box">
			<div class="box-header">
				<h3 class="box-title">상세보기</h3>
			</div>
			<div class="box-body">
				<div class="form-group">
					<label>제목</label> <input type="text" name="title"
						class="form-control" value="${boardDetail.b_title}" readonly="readonly" />
				</div>

				<div class="form-group">
					<label>내용</label>
					<textarea name="content" rows="5" readonly="readonly"
						class="form-control">${boardDetail.b_content}</textarea>
				</div>

				<div class="form-group">
					<label>작성자</label> 
					<input type="text" name="id" class="form-control" value="${boardDetail.b_id}" readonly="readonly" />					
				</div>
				<c:if test = "${boardDetail.bcode_number == 1}">
				<div>
				<label>별점</label>				
					<div id = "pdf_star"></div>						  	
					<output for="star-input"><b>${boardDetail.pdnum_star }</b>점</output>				
				</div>
				</c:if>
			</div>

		</div>
		<div class="box-footer">
			<button style = "float : left;" class="btn btn-success" onclick="location.href='${contextPath}'">메인</button>
			<c:if test = "${member.mb_id == boardDetail.b_id }">			
				<button style = "float : left;" class="btn btn-warning" onclick="location.href='BoardUpdate?b_number=${boardDetail.b_number}'">수정</button>
			</c:if>
			
			<c:if test = "${member.mb_id == boardDetail.b_id }">
				<c:if test = "${boardDetail.bcode_number != 3 && boardDetail.bcode_number != 4 && boardDetail.bcode_number != 5}">
					<button style = "float : left;" class="btn btn-danger" onclick="location.href='${contextPath}/board/BoardDelete?bcode_number=${boardDetail.bcode_number}&b_number=${boardDetail.b_number}'">삭제</button>
				</c:if>
				<c:if test = "${boardDetail.bcode_number == 3 || boardDetail.bcode_number == 4 || boardDetail.bcode_number == 5}">
					<button style = "float : left;" class="btn btn-danger" onclick="location.href='${contextPath}/board/BoardDelete?bcode_number=2&b_number=${boardDetail.b_number}'">삭제</button>
				</c:if>
			</c:if>
			
			<c:if test = "${boardDetail.bcode_number == 3 || boardDetail.bcode_number == 4 || boardDetail.bcode_number == 5}">
				<button style = "float : left;" class="btn btn-primary" onclick="location.href='${contextPath}/board/list_paging?bcode_number=2'">목록</button>
			</c:if>
			<c:if test = "${boardDetail.bcode_number != 3 && boardDetail.bcode_number != 4 && boardDetail.bcode_number != 5}">
				<button style = "float : left;" class="btn btn-primary" onclick="location.href='${contextPath}/board/list_paging?bcode_number=${boardDetail.bcode_number}'">목록</button>
			</c:if>
			
			<div style = "border : 1px solid; width : 55px; float : left;" >			
				<a href='javascript: like_func();' id='hate_img'><img src='${contextPath}/resources/img/hate.png' style = 'width : 30px'></a>
				<span id = "likecnt"></span>	
							
			</div>
		</div>
			<div class="box-body">
			<br>
			<br>
		      <table>
		         <tr>
		         <td rowspan="2" width="70%"><textarea class="form-control" name="re_content"  id="re_content" placeholder="댓글을 입력하세요."></textarea></td>
		         
		         <td><input type="text" name="re_writer" id="re_writer" placeholder="${member.mb_id}" value = "${member.mb_id}" readonly="readonly"></td>
		         </tr>
		         <tr><td><button type="button" id="btnReplySave" class="">저장</button></td></tr>   
		      </table>    
		      <div id ="replylist"></div>     
      		</div>
			
		</div>
	</section>
	
	</div>
</body>


<script src = "../resources/star/img/grade_img.png"></script>





</html>