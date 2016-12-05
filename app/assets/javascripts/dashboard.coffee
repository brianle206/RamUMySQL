user_dashboard = ->
	$('.user-dash-dropdown').click ->
		$sub = $(this).children('.user-dash-sub-menu')
		if $sub.hasClass 'hidden'
			console.log('doodle')
			$sub.removeClass 'hidden'
			$sub.hide()
			$sub.slideDown 200
			# setTimeout (->
			# 	$sub.slideDown 200
			# 	return
			# ), 300
		else
			console.log('meister')
			$sub.slideUp 200
			setTimeout (->
				$sub.addClass 'hidden'
				return
			), 300
		return
	return

$(document).ready user_dashboard
