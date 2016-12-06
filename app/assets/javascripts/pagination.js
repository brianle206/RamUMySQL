$(function() {
	$('ul > li.next').click(function(){
		$('#new_complete').trigger('submit.rails');
	});
});
