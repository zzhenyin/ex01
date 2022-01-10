$(document).ready(function(e){
	
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
	
	
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		console.log("submit clicked");
		
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
	});
	
	
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
	
	
	  $(".uploadResult").on("click", "button", function(e){
		  console.log("delete file");
		  
		  var targetFile = $(this).data("file");
		  var type = $(this).data("type");
		  
		  var targetLi = $(this).closest("li");
		  
		  $.ajax({
		  	url : 'deleteFile',
		  	data : {fileName : targetFile, type : type},
		  	dataType : 'text',
		  	type : 'POST',
		  		success : function(result) {
		  			alert(result);
		  			targetLi.remove();
		  		}
		  });	// end ajax
	  });	// end delete
	  
});	// end document
