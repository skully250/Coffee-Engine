window.requestAnimFrame = (->
  window.requestAnimationFrame or window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or window.oRequestAnimationFrame or window.msRequestAnimationFrame or (callback, element) ->
    window.setTimeout callback, 1000 / 60
)()

class game
	
	constructor: ->
		@reset()
		@main()

	update: (dt) ->

	render: ->

	main: ->
		now = Date.now
		dt = (now - lastTime) / 120.0
		lastTime = now
		render
		update dt
		setTimeout main, 1

	reset: ->
		player.x = (canvas.width / 2)
		player.y = (canvas.height / 2)


class entity


class player extends entity

	constructor: ->
		@pos = [0, 0]

	move: (Arrpos, amount)->
		return @pos[0] += amount if Arrpos = 0
		return @pos[1] += amount if Arrpos = 1

class tile
	constructor: (sprite, pos, ctx)->
		@sprite = sprite
		@sprite = new Engine.sprite 'assets/images/terrain.png', [0, 0], 16, 16, 0
		@pos = pos
		@ctx = ctx

	render: ->
		@ctx.drawImage sprite

class grass extends tile
	constructor: (sprite, pos)->
		super sprite, pos

class stone extends tile
	construcotr: (sprite, pos) ->
		super sprite, pos


class level