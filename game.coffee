class game
	
	constructor: ->

	update: (dt) ->

	render: ->

	main: ->
		now = Date.now
		dt = (now - lastTime) / 120.0
		lastTime = now
		render
		update dt
		setTimeout main, 1


class entity


class level