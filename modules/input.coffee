Engine.input = ->
	pressedKeys: []
	keyDown: []

	setKey = (event, status) ->
		code = event.keyCode
		key: null

		switch code
			when 32
				key = 'SPACE'
				break
			when 37
				key = 'LEFT'
				break
			when 38
				key = 'UP'
				break
			when 39
				key = 'RIGHT'
				break
			when 40
				key = 'DOWN'
				break
			else
				key = String.fromCharCode code

		pressedKeys[key] = status

	document.addEventListener 'keydown', (e) ->
		@setKey e, true
	document.addEventListener 'keyup', (e) ->
		@setKey e, false

	window.addEventListener 'blur', () ->
		pressedKeys = []

	isDown = (key) ->
		pressedKeys[key.toUpperCase()]

	isPressed  = (key) ->
		key = keyDown

	Engine.input