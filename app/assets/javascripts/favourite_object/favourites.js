$( document ).ready(function() {
	$('.favourite_object_container .icon').click(function() {
		element = $(this)
		$.ajax({
		    type: "PUT",
		    url: '/favourite_object/favourites/update',
		    data: {"target_type": $(this).attr('-data-target-type'), 
		    	"target_id": $(this).attr('-data-target-id')}
		}).done(function(response){
			if (response == 'true'){
				element.addClass( "active" );
			}else{
				element.removeClass( "active" );
			}
		}).fail(function(){
			console.log("failed");
		});
	});
});
