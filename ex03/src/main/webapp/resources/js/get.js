$(document).ready(function(){

	$('.uploadResult').on("click", "li", function(e){
		
		console.log("image----------");
		
		var liObj = $(this);
		
		var path = encodeURIComponent(liObj.data("path")+"/"+ liObj.data("uuid")+ "_" + liObj.data("filename"));
		
		if(liObj.data("type")){
			showImage(path.replace(new RegExp(/\\/g), "/"));
		}else{
			// download
			self.location = "download?fileName=" + path
		}
		
	});
	
	
	function showImage(fileCallPath){
		//alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture").html("<img src='display?fileName="+fileCallPath+"'>")
		.animate({width:'50%', height:'50%'});
	}
	
	$(".bigPictureWrapper").on("click", function(e){
		$(".bicPicture").animate({width:'0%', heiht:'0%'}, 1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		});
	});

	
});		// end document


