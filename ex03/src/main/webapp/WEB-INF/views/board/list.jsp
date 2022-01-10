<%@page import="com.ex03.mapper.BoardMapper"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@page import="com.ex03.domain.BoardVO" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css"> 
	a { text-decoration:none;
	color:black } 
	 a:link { color: black; text-decoration: none;}
	 a:visited { color: black; text-decoration: none;}
</style> 

<title>List</title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<body>

<div class="container">
  <h2 class="text-center" style="margin:1em;">List</h2>
 
	 <button type="button" class="btn btn-outline-secondary" style="float:right;" 
	 onclick="location.href='/board/register'" > 작성하기</button>
	
	 	<form action="/board/list" id="actionForm" method='get'>
	 		<input type="hidden" name='pageNum' value = '${pageMaker.cri.pageNum}'/>
	 		<input type="hidden" name='amount' value= '${pageMaker.cri.amount}'/>	
 
 
  <table class="table table-hover">
    <thead>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>수정일</th>
      </tr>
    </thead>
    
  
    <c:forEach items="${list}" var="board">
    <tbody>
      <tr>
        <td><c:out value="${board.bno}"></c:out></td>
        <td><a href='/board/get?bno=<c:out value="${board.bno}"/>'><c:out value="${board.title }"></c:out></a></td>
        <td><c:out value="${board.writer }"></c:out></td>
        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"></fmt:formatDate></td>
        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"></fmt:formatDate></td>
    </tbody>
    </c:forEach>
    
  </table>
 		
 		<div class="pag">
		<ul class="pagination" >
		
			<c:if test="${pageMaker.prev}">
			    <li class="page-item"><a class="page-link" href="${PageMaker.startPage -1 }">Previous</a></li>
			</c:if>
			    
			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage }">		    			    
			    <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
	    		<a class="page-link" href="${num}">${num}</a>   
			    </li>
			</c:forEach>
			
			<c:if test="${pageMaker.next}">
			    <li class="page-item">
			    <a class="page-link" href="${pageMaker.endPage +1 }">Next</a></li>
			</c:if>  
		
	 	</ul>
	 	</div>
	 	
	 	</form>

	 
 </div> <!-- .container end -->


<script type="text/javascript">
	$(document).ready(function(){
		var actionForm = $("#actionForm");
		$(".page-link").on("click", function(e){
			e.preventDefault();
			console.log('click');
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
	});

</script>


</body>
</html>