define ['keycodes'], (keycodes) ->
	# map field name on Event object to key display name
	MODIFIERS = {
		ctrlKey : 'Ctrl'
		metaKey : 'Meta'
		altKey  : 'Alt'
		shiftKey: 'Shift'
	}

	# keycodes for modifier keys: Shift, Ctrl, Alt, Cmd
	MOD_CODES = [16, 17, 18, 91, 93]

	# returns a string that represents the key combination of a given Event
	# object or the keyname of a given keyCode.
	# Event object   --> Ctrl+N, Alt+Shift+Tab
	# keyCode number --> L, ;
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
