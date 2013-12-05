define ['keycodes'], (keycodes) ->
	# window.KEYS = true

	# map field name on Event object to key display name
	MODIFIERS = {
		ctrlKey : 'Ctrl'
		metaKey : 'Meta'
		altKey  : 'Alt'
		shiftKey: 'Shift'
	}

	# keycodes for modifier keys: Shift, Ctrl, Alt, Cmd
	MOD_CODES = [16, 17, 18, 91, 93]

	return (event) ->
		# accepts event.which directly for simple key naming
		if typeof event is 'number' then return keycodes[event]
		# build keystring that represents full event, key + modifiers:
		# if key is modifier then just return keyname
		else if event.which in MOD_CODES then return keycodes[event.which]
		else
			# otherwise build array of modifier names and keyname
			mods = (name for modKey, name of MODIFIERS when event[modKey])
			mods.push keycodes[event.which]
			mods.join('+')
