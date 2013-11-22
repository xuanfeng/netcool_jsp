$(function(){
	$("h1").click(function(){
		
		$.ajax({
			async: false,
			url: "http://localhost:3001/haha?id=1",
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
				alert(json)
			}		
		});
		
	});
})