<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Insert title here</title>

<style>
.uploadResult{
width:100%
background-color : gray;}
.uploadResult ul{
display:flex; flex-flow: fow; justify-content:center; align--items:center;}
.uploadResult ul li{
list-style:none; padding:10px;}
.uploadResult ul li img{
width: 60px;}
.bigPictureWrapper{
position:absolute; display:none; justify-content:center; align-items:center; top:0%; width:100%; height:100%;
background-color:gray; z-index:100; background:rgba(255,25,,25,,0.5);}
.bigPicture{
position:relative;display:flex;justify-content:center; align-items:center;}
.bigPicture img{
width:600px;}
</style>

</head>
<body>

 <div class="uploadDiv">

	<input type="file" name='uploadFile' multiple="multiple"/>
 </div>
 
<button id="uploadBtn">Upload</button>

<div class="uploadResult">
	<ul id="uploadResult">
	</ul>
</div>

<div class="bigPictureWrapper">
	<div class="bigPicture"></div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" 
crossorigin="anonymous"></script>

<script>
function showImage(fileCallPath){
	$(".bigPictureWrapper").css("display","flex").show();
	$(".bigPicture")
	.html("<img src='display?fileName="+encodeURI(fileCallPath)+"'>")
	.animate({width:'100%', height:'100%'}, 1000);
	
	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
		setTimeout((
				)=>{ $(this).hide();},1000);
	});
}

$(document).ready(function(){
	var cloneObj = $(".uploadDiv").clone();
	$("#uploadBtn").on("click", function(e){
		var formData = new FormData();
	
	});
	
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); //파일 확장자 정규식 
	var maxSize = 5242880; // 5MB
	
	function checkExtension(fileName,fileSize){
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
	
	
	$("#uploadBtn").on("click",function(e){
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		console.log(files);
		
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile",files[i]);
		}
		
		$.ajax({
			url: 'uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			datType: 'json',
			success: function(result){
				alert("Uploaded");
				
				console.log(result);
							
				showUploadResult(result);
				
				$(".uploadDiv").html(cloneObj.html());
			}
		});// end ajax

		
	var uploadResult = $(".uploadResult ul");	
	function showUploadResult(uploadResultArr){
		var str = "";
		
		$(uploadResultArr).each(function(i,obj){
		
			if(!obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath+ "/" + obj.uuid + "_" + obj.fileName);
				
				var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
				
				str += "<li><div><a href='download?fileName="+fileCallPath+"'>" +
						"<img src='/resources/img/icon.png'>"+obj.fileName+"</a>"+
						"<span data-file=\'"+ fileCallPath+"\' data-type='file'> X </span>"+
						"<div></li>";	
				 
			}else{
				//str += "<li>" + obj.fileName + "</li>";
				var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_" + obj.uuid+"_"+obj.fileName);
				
				var originPath = obj.uploadPath+ "\\" + obj.uuid + "_" + obj.fileName;
				
				originPath = originPath.replace(new RegExp(/\\/g), "/");
				
				str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
				"<img src='display?fileName="+fileCallPath+"'></a>"+
				"<span data-file=\'"+fileCallPath+"\' data-type='image'> X </span>" +
				"<li>";
			}
		});
		uploadResult.append(str);
		
	}	// end showUploadResult
	
	$(".uploadResult").on("click","span", function(e){
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		
		$.ajax({
			url:'deleteFile',
			data: {fileName: targetFile, type:type},
			dataType: 'text',
			type:'POST',
				success:function(result){
					alert(result);
				}
		});	// end ajax
	});
		

	});	//end .uploadBtn
}); //end document
</script>



	
</body>
</html>