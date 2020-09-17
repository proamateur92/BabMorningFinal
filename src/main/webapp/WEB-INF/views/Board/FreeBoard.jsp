<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>자유 게시판</title>
<%@include file="../include/header.jsp"%>
</head>
<body>
<script>
	$(document).ready(function () {
	    $("#searchBtn").on("click", function (event) {
	        self.location =
	            "list_paging${pageMaker.makeQuery(1)}"
	            +"&bcode_number=6" 
	            + "&searchType=" + $("select option:selected").val()
	            + "&keyword=" + encodeURIComponent($("#keywordInput").val());
	    });
	});

	
</script>
<style>
	li{
		display : inline-block;
	}
	.review_table2 {
		width : 100%;
	}
	.review_table2 td{
		padding : 12px 6px 12px 6px;
	}
</style>
	
	<!-- Page Content -->
	<div class="container">
		<%@include file="../include/sideMenu.jsp"%>		
		<div class = "bob_content">
		<h1 class="mt-4">Free Board</h1>
		<div class="table-responsive">
		  <table class="table">
		  <tr style= "background-color : sandyBrown; text-align: center; border-bottom : 2px solid; font-size : 18px;">
		  	<td style="width : 9%;">글번호</td>	  	
  	    	<td style="width : 50%;">제목</td>
	    	<td style="width : 15%;">작성일</td>
	    	<td style="width : 15%;">작성자</td>
	    	<td style="width : 12%;">조회수</td>	    	
		  </tr>	 		
		  
		 <c:forEach var="notice" items="${notice}">		 	
			<tr style = "background-color : BurlyWood;">
				<c:if test = "${notice.b_id == 'admin' && notice.bcode_number == 6 && pageMaker.criteria.page == 1}">
						<td style="text-align: center;">공지</td>					
				 	<td style="padding : 12px 12px 12px 25px;">
				 		<a href="BoardDetail${pageMaker.makeSearch(pageMaker.criteria.page)}&b_number=${notice.b_number}">[공지사항]  ${notice.b_title}</a></td> 		 	
				 	<td style="text-align: center;">${notice.b_regdate}</td>
				 	<td style="text-align: center;">${notice.b_id}</td>
				 	<td style="text-align: center;"><span class="badge">${notice.b_readcnt }</span></td>
				 </c:if>	
		 	</tr>
		</c:forEach> 
		  
		<c:forEach var="boardList" items="${boardList}">		 	
			<tr>
			 	<td style="text-align: center;">${boardList.b_number}</td>
			 	<td style="padding : 12px 12px 12px 25px;">
			 		<a href="BoardDetail${pageMaker.makeSearch(pageMaker.criteria.page)}&b_number=${boardList.b_number}">${boardList.b_title}</a></td> 		 	
			 	<td style="text-align: center;">${boardList.b_regdate}</td>
			 	<td style="text-align: center;">${boardList.b_id}</td>
			 	<td style="text-align: center;"><span class="badge">${boardList.b_readcnt }</span></td>
		 	</tr>
		</c:forEach>
		</table>
		
		<table class="review_table2">
			<tr>
				<td style="width : 10%; padding-left:30px;">
   				   <select class="form-control" name="searchType" id="searchType" style="width : 100px;">
		           <option value="n" <c:out value="${pageMaker.criteria.searchType == null ? 'selected' : ''}"/>>:::::: 선택 ::::::</option>
		           <option value="t" <c:out value="${pageMaker.criteria.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
		           <option value="c" <c:out value="${pageMaker.criteria.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
		           <option value="w" <c:out value="${pageMaker.criteria.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
		           <option value="tc" <c:out value="${pageMaker.criteria.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
		           <option value="cw" <c:out value="${pageMaker.criteria.searchType eq 'cw' ? 'selected' : ''}"/>>내용+작성자</option>
		           <option value="tcw" <c:out value="${pageMaker.criteria.searchType eq 'tcw' ? 'selected' : ''}"/>>제목+내용+작성자</option>
	    		   </select>
	    		</td>
				<td style="width:55%;"> 					
	        		<div class="input-group">
	        			<input type="text" class="form-control" name="keyword" id="keywordInput" value="${pageMaker.criteria.keyword}" placeholder="검색어">
	        		</div>
				</td>
				<td style="width : 8%;">
					<span class="input-group-btn">
	            		<button type="button" class="btn btn-primary btn-flat" id="searchBtn">검색</button>	            				
	        		</span>
				</td>
				<td style="width : 1px;">
					<c:if test="${member != null }">	
						<a href = "${contextPath}/board/BoardRegister?bcode_number=${pageMaker.criteria.bcode_number}&pd_number=0"><input  class="btn btn-success" type="button" value="글쓰기" id="main" /></a>
					</c:if>
					<c:if test="${member == null }">	
						<a href='javascript: login_check();'><input  class="btn btn-success" type="button" value="글쓰기" id="main" /></a>
					</c:if>
				</td>
				<td>
					<button class="btn btn-primary" onclick="location.href='${contextPath}/board/list_paging?bcode_number=${pageMaker.criteria.bcode_number}'">목록</button>				
				</td>
			</tr>
	  	</table>
	  	
		        <ul class="pagination">
		            <c:if test="${pageMaker.prev}">
		                <li><a href="${contextPath}/board/list_paging?page=${pageMaker.startPage - 1}&perPageNum=10&bcode_number=6&searchType=${pageMaker.criteria.searchType}&keyword=${pageMaker.criteria.keyword}">이전</a></li>
		            </c:if>
		            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		                <li <c:out value="${pageMaker.criteria.page == idx ? 'class=active' : ''}"/>>
		                    <a href="${contextPath}/board/list_paging?page=${idx}&perPageNum=10&bcode_number=6&searchType=${pageMaker.criteria.searchType}&keyword=${pageMaker.criteria.keyword}">${idx}</a>
		                </li>
		            </c:forEach>
		            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		                <li><a href="${contextPath}/board/list_paging?bcode_number=2&page=${pageMaker.endPage + 1}&perPageNum=10&bcode_number=6&searchType=${pageMaker.criteria.searchType}&keyword=${pageMaker.criteria.keyword}">다음</a></li>
		            </c:if>
		        </ul>
			</div>
			<%@include file="../include/footer.jsp"%>
		</div>
	</div>
</body>
</html>