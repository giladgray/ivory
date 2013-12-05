define ['keystring', 'mixins'], (tickle, mixins) ->
	return {
		mixins
		tickle
		keystring: tickle
	}
