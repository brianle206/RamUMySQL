$ ->
		slideUpTimeout = (selector, timeout) ->
			if $(selector).is(':visible')
					setTimeout ( ->
		    		$(selector).slideUp();
		    		), timeout

  slideUpTimeout('p.alert', 5000)
  false
