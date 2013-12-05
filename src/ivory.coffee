define ['keystring', 'mixins'], (keystring, mixins) ->
	# parent object with mixins, keystring, tickle alias
	return {
		mixins
		keystring
		tickle: keystring
	}
