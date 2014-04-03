$( document ).ready(function() {
	$('.favourite_object_container .icon').click(function() {
		element = $(this)
		target_type = element.attr('-data-target-type');
		target_id = element.attr('-data-target-id');
		user_status = element.attr('-data-user-status');
		third_party_flag = element.attr('-data-third-party');

		if(user_status == 'true'){
			$.ajax({
			    type: "PUT",
			    url: '/favourite_object/favourites/'+ target_type +'/' + target_id + '/toggle' ,
			    data: {"target_type": target_type, 
			    	"target_id": target_id, "third_party_flag": third_party_flag}
			}).done(function(response){
				if (response['favourite']['is_favourited'] == true){
					element.addClass( "active" );
				}else{
					element.removeClass( "active" );
				}
			}).fail(function(){
				console.log("failed");
			});
		}else{
			alert("Please login to favourite");
		}
	});
});
