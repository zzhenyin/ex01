<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<!DOCTYPE html>
<html>
<head>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
  <link rel="stylesheet" type="text/css" href="/resources/css/get.css">
  <script type="text/javascript" src="/resources/js/get.js"></script> 

<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");
		$("button[data-oper='modify'").on("click", function(e){
			operForm.attr("action","/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.attr("action", "/board/list")
			operForm.submit();
		});
	});
</script>

</head>
<title>get</title>
<body>

<div class="row">
 <div class="col-md-2"></div>
 <div class="col-md-8">
  <h2 class="text-center" style="margin:1em;">게시물</h2><p></p>
   <div class="table table-responsive">

  <form id='operForm' action="/board/modify" method="get">
  	<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
  	
  	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
  	<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>

       <table class="table">
    <tr>
     <td>번호</td>
     <td><input type="text"  class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly"
      style="background-color:transparent;"></td>
    </tr>
    <tr>
     <td>제목</td>
     <td><input type="text"  class="form-control" name='title' value='<c:out value="${board.title }"/>' readonly="readonly"
     style="background-color:transparent;"></td>
    </tr>
     <tr>
     <td>작성자</td>
     <td><input type="text"  class="form-control" name='writer' value='<c:out value="${board.writer }"/>' readonly="readonly"
     style="background-color:transparent;"></td>
    </tr>
    <tr>
     <td>작성일</td>
     <td><input class="form-control" name='regdate' readonly="readonly"
     value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate}"></fmt:formatDate>'/> </td>
    </tr>
     <tr>
     <td>수정일</td>
     <td><input type="text" class="form-control" name='updateDate' readonly="readonly"
     value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.updateDate}"></fmt:formatDate>'/> </td>
     </tr>
    <tr>
    <tr>
     <td>내용</td>
     <td>
	     <div class="contents" contenteditable="false" style="width=100%;">
	     	<c:out value="${board.content}" escapeXml="false"/>
	     </div>
     </td>
    </tr> 
    
    <tr>
    	<td>첨부파일</td>
    	<td colspan="2">
    		<div class="uploadResult">
    			<ul></ul>
    		</div>
    		<div class="bigPictureWrapper">
				<div class="bigPicture"></div>
			</div>
    		
    	</td>
    </tr>    
    
     <tr> 
     <td colspan="2"  class="text-center">
  	
      <button class="btn btn-outline-secondary" data-oper='modify' >수정하기</button>
      
      <button class="btn btn-outline-secondary" data-oper='list' >목록</button>

     </td>
    </tr>
    
    </table>
 
  </form> 

   </div>
 </div>
</div>

<script>
$(document).ready(function(){
    var bno = "${board.bno}";
    
    $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
        console.log(arr);
        
        var str="";
        
		$(arr).each(function(i,attach) {
			if (attach.fileType) {
				var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
				str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"'";
				str += " data-uuid='"+attach.uuid+"' data-fileName='"+attach.fileName+"'data-type='"+attach.fileType+"'>";
				str += " <div>";
				str += "<img src='display?fileName=" + fileCallPath + "'>";
				str += "</div>";
				str += "</li>";
			} else {
				var fileCallPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
				str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"'";
				str += " data-uuid='"+attach.uuid+"' data-fileName='"+attach.fileName+"'data-type='"+attach.fileType+"'>";
				str += "<span> " + attach.fileName + " </span>";
				str += " <div>";
				str += "<img src='/resources/img/icon.png'></a>";
				str += "</div>";
				str += "</li>";
			}
		});
        $(".uploadResult ul").html(str);
    });
});
</script>


</body>
</html>