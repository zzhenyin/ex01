<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="/resources/ckeditor/ckeditor.js" ></script>
<!-- <script src="https://cdn.ckeditor.com/4.17.1/standard-all/ckeditor.js"></script> -->

<!-- <script type="text/javascript" src="/resources/js/modify.js"></script> -->
<link rel="stylesheet" type="text/css" href="/resources/css/register.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>modify</title>


</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>

<div class="row">

 <div class="col-md-2"></div>
 <div class="col-md-8">
  <h2 class="text-center" style="margin:1em;">수정하기</h2>
			
			<div class="table table-responsive">
				<form role="form" action="/board/modify" method="post">
					
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
  					<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>       
										
						<table class="table">
						<tr>
						<td>번호</td> 
						<td><input class="form-control" name='bno' style="background-color:transparent;"
							value='<c:out value="${board.bno}"/>' readonly="readonly"></td>
					</tr>
					<tr  class="form-group">
						<td>제목</td> 
						<td><input class="form-control" name='title'
							value='<c:out value="${board.title}"/>' ></td>
					</tr>
					<tr class="form-group"> 
						<td>작성자</td> 
						<td><input class="form-control" name='writer'
							value='<c:out value="${board.writer}"/>' readonly="readonly"></td>
					</tr>
					<tr class="form-group">
						<td>작성일</td> 
						<td><input class="form-control" name='regDate'
							value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>'
							readonly="readonly"></td>
					</tr>
					<tr class="form-group">
						<td>수정일</td> 
						<td><input class="form-control"
							name='updateDate'
							value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>'
							readonly="readonly"></td>
					</tr>
					<tr class="form-group">
						<td>내용</td>
						<td><textarea id="content" name='content' class="form-control" rows="10" cols="50"><c:out value="${board.content }" /></textarea>
     <script>
        CKEDITOR.replace('content',{
        	//filebrowserUploadUrl : "/ImageUpload"
        });
    </script>		</td>
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
						<button type="submit" data-oper='modify' class="btn btn-outline-secondary" style="margin-right:0.5em;"> 수정하기</button>
						<button type="submit" data-oper='remove' class="btn btn-outline-secondary" style="margin-right:0.5em;"> 삭제</button>
						<button type="submit" data-oper='list' class="btn btn-outline-secondary" style="margin-right:0.5em;"> 목록</button>
					</td>
					</tr>
		
					</table>
</form>
		</div>

	</div>

</div>

<script>
	$(document).ready(function() {

		(function(){
			var bno = '<c:out value="${board.bno}"/>';
			$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
				console.log(arr);
				
				var str="";
				
				$(arr).each(function(i,attach) {
					//image type
					if (attach.fileType) {
						var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
						
				          str += "<li data-path='"+attach.uploadPath+"'";
				          str += " data-uuid='"+attach.uuid+"' data-fileName='"+ attach.fileName+"'data-type='"+ attach.image+"'";
				          str += " ><div>";
				          str += "<span> " + attach.fileName + " </span>";
				          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
				          str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				          str += "<img src='display?fileName=" + fileCallPath + "'>";
				          str += "</div>";
				          str += "</li>";
					} else {
						var fileCallPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
						var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");

						 	str += "<li data-path='"+ attach.uploadPath+"'";
				            str += " data-uuid='"+ attach.uuid+"' data-fileName='"+ attach.fileName+"'data-type='"+ attach.image+"'";
				            str += " ><div>";
				            str += "<span> " + attach.fileName + " </span>";
				            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
				            str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				            str += "<img src='/resources/img/icon.png'></a>";
				            str += "</div>";
				            str += "</li>";
					}
				});	// end $(arr)
				
				$(".uploadResult ul").html(str);
			});
		});// end function

		
		$(".uploadResult").on("click", "button", function(e){
			   console.log("delete file");
			   if (confirm("삭제?")) {
			      var targetLi = $(this).closest("li");
			      targetLi.remove();
			   }
			}); 
	
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz|jar)$");
		var maxSize = 5242880; // 5MB
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		 
			
		$("input[type = 'file']").change(function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			for(var i=0; i<files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
				console.log(files); 
			}
			
			$.ajax({
				url : 'uploadAjaxAction',
				processData : false,
				contentType : false, 
				data : formData,
				type : 'POST',
				dataType : 'json',
					success:function(result){
						console.log(result);
						showUploadResult(result);
					}
			});	// end ajax
		});	// end input - file
		
		function showUploadResult(uploadResultArr){
			  if(!uploadResultArr || uploadResultArr.length == 0){return ;}
			  var uploadUL = $(".uploadResult ul");
			  var str = "";
			  
			  $(uploadResultArr).each(function(i, obj){
				  
				   //image type
			        if(obj.image){
			          var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
				          
			          str += "<li data-path='"+obj.uploadPath+"'";
			          str += " data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'data-type='"+obj.image+"'";
			          str += " ><div>";
			          str += "<span> " + obj.fileName + " </span>";
			          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
			          str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			          str += "<img src='display?fileName=" + fileCallPath + "'>";
			          str += "</div>";
			          str += "</li>";
			          
			       
			        }else{
			          var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);            
			            var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			              
			            str += "<li data-path='"+obj.uploadPath+"'";
			            str += " data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'data-type='"+obj.image+"'";
			            str += " ><div>";
			            str += "<span> " + obj.fileName + " </span>";
			            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
			            str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			            str += "<img src='/resources/img/icon.png'></a>";
			            str += "</div>";
			            str += "</li>";
			        } 
			  });
				uploadUL.append(str);
		  }	// end showUploadResult
		
		  var formObj = $("form");
			$('button').on("click", function(e){
				
				e.preventDefault();
				
				var operation = $(this).data("oper");
				
				console.log(operation);
				
				if(operation == 'remove'){
					formObj.attr("action", "/board/remove");
				
				}else if(operation == 'list'){
					
					formObj.attr("action","/board/list").attr("method","get");
				      
				      var pageNumTag = $("input[name='pageNum']").clone();
				      var amountTag = $("input[name='amount']").clone();
				     
				      formObj.empty();
				      
				      formObj.append(pageNumTag);
				      formObj.append(amountTag);

				      
				}else if(operation =='modify'){
					console.log("submit-----------");
					
					var str = "";
					
					$(".uploadResult ul li").each(function(i, obj){
						
						var jobj = $(obj);
						console.dir(jobj);
						
						str += "<input type = 'hidden' name = 'attachList["+i+"].fileName' value = '" + jobj.data("filename")+"'>";
						str += "<input type = 'hidden' name = 'attachList["+i+"].uuid' value = '" + jobj.data("uuid") + "'>";
						str += "<input type = 'hidden' name = 'attachList["+i+"].uploadPath' value = '" + jobj.data("path") + "'>";
						str += "<input type = 'hidden' name = 'attachList["+i+"].fileType' value = '" + jobj.data("type") + "'>";
					});
					formObj.append(str).submit();
				}
				formObj.submit();
			});
		
		
});

</script>    

</body>
</html>