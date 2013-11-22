$(function(){
	$("#delete").click(function(){
		var url = $(this).attr("href");
		
		$.ajax({
			async: false,
			url: url,
			dataType: 'html',
			type: 'get',
			// data: {"courseAddress": courseAddress} ,
			beforeSend: function (xhr) {
				 xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
			},
			statusCode: {
			     404: function() {
			     	
			     }
		   	},
			success: function(json){
				$("#delete").after(json);
			}		
		});

		return false;
		
	});
})