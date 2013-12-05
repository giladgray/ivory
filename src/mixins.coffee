define ['keystring'], (tickle) ->
	# Event handler for a KeyEvent
	keypress = (event) ->
		# Event action is keyed either by exact keystring or by generic keyname
		# "+key" that matches key with any combo of modifiers (including none).
		# Event value can be:
		#  - a function
		#  - name of function on View
		#  - a self-scoped CSS selector
		# If the value is a function then will be called in the current context
		# and passed the event. If it is a selector then it will be queried in
		# the view's DOM context and clicked.

		# get complete keystring for exact matching (Ctrl+N)
		keystring = tickle(event)
		# get name of key pressed without modifiers for general matching (+D)
		keyname   = '+' + tickle(event.which)
		# attempt to find action in keyEvents hash
		action    = @keyEvents[keystring] or @keyEvents[keyname]
		# quick debug option, in case you want to see keys
		if window.KEYS then console.log keystring, action
		# escape to deselect whatever is focused (generally input or text field)
		# TODO: is this behavior final? user-configurable?
		if keystring is 'Esc' then $(':focus').blur()
		# keys only happen when nothing is focused, because they're useful in inputs and forms
		else if action and _.isEmpty $(':focus').get()
			event.preventDefault()
			# if the action is the name of a function here then call it
			if @[action] then action = @[action]
			# if it is a function then let it handle event
			if _.isFunction action then action.call(@, event)
			# otherwise assume it's a selector and click on it.
			# this allows us to reuse standard Backbone event handling.
			# TODO: perform generic events on target
			else @$(action).click()

	return {
		# a 'constructor' and 'destructor' for key event bindings
		setupIvory    : -> $('body').on 'keydown.ivory', (e) => @keypress(e)
		teardownIvory : -> $('body').off 'keydown.ivory'
		keypress
	}
