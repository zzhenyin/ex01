<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>

<script type="text/javascript" src="/resources/js/register.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/register.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 

</head>
<title>register</title>
<body>
<% request.setCharacterEncoding("UTF-8"); %>

<div class="row">
 <div class="col-md-2"></div>
 <div class="col-md-8">
  <h2 class="text-center" style="margin:1em;">작성하기</h2><p></p>
  
   
   <div class="table table-responsive">
  <form role ="form" action="/board/register" method="post">
       <table class="table">
    <tr>
     <td>제목</td>
     <td><input type="text"  class="form-control" name='title' id="title"></td>
    </tr>
    <tr>
     <td>작성자</td>
     <td><input type="text"  class="form-control" name='writer' id="writer"></td>
    </tr>
    <tr>
     <td>내용</td>
     <td><textarea id="content" name='content' class="form-control" rows="10" cols="50"></textarea>
     	<script>
     		CKEDITOR.replace("content",{
     			//filebrowserUploadUrl : "ImageUpload"
     		});  		
     	</script>
     </td>
    </tr>
    
    <tr>
    	<td>첨부파일</td>
    	<td colspan="2">
    		<div class="uploadDiv">
    			<input type="file" name="uploadFile" multiple />
    		</div>
    		<div class="uploadResult">
    			<ul></ul>
    		</div>
    	</td>
    </tr>

    
     <tr> 
     <td colspan="2"  class="text-center">
      <button type="submit" class="btn btn-outline-secondary" style="margin-right:0.5em;"> 작성하기 </button>
      <button type="reset" class="btn btn-outline-secondary" style="margin-right:0.5em;"> Reset </button>
      <button type="button"  class="btn btn-outline-secondary" style="margin-right:0.5em;"
      onclick="location.href='/board/list'"> 목록 </button>
     </td>
    </tr>
    
    </table>
 
  </form> 
   </div>

 </div>
</div>
 
</body>
</html>