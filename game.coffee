class game

	canvas: null
	context: null

	entityList: []
	loading = true

	constructor: ->
		engine = new engine 540, 480

		@canvas = engine.canvas
		@context = engine.context

		@context.drawImage 'assets/menu/loading.png', 0, 0

		world = new world 60

		player = new Player 10, 10, 'assets/player.png', 0
		entityList.push player

		enemy = new Enemy 10, 10, 'assets/enemy.png', 0
		entityList.push enemy

		loading = false
		engine.clear()

	renderEntities: (entityArr) ->
		for [k=0...entityArr]
			renderEntity[k]

	renderEntity: (entity) ->
		@context.drawImage entity.pos[0], entity.pos[1]

	render: ->
		player.render()

	updateEntity: (entity, dt) ->
		entite.sprite.update dt

	update: (dt) ->
		now = Date.now()
		dt = (now - lastTime) / 120.0
		lastTime = now

		player.update(dt)

	window.game = game

class entity
	
	constructor: (x, y, sheet, pos) ->
		@x = x
		@y = y
		@sheet = sheet
		@sprite = new Sprite img, pos, 16, 16, 0

	render: ->
		@sprite.render

	update: (dt) ->
		@sprite.update dt

class player extends entity

	constructor: (x, y, sheet, pos) ->
		super x, y, sheet, pos

	render: ->
		super()

	update: (dt) ->
		super.update dt

class enemy extends entity

	constructor: (x, y, sheet, pos) ->
		super x, y, sheet, pos

	render: ->
		super()

	update: (dt) ->
		super dt

class tile

	constructor: (sheet, pos)->
		@sprite = new Sprite img, pos, 16, 16, 0

	render: (x, y) ->
		@context.drawImage @sprite, x, y

	update: ->
		@sprite.update dt


class world

	constructor: (size, type) ->
		@size = size
		@type = type or 'normal'
		@world = []
		@generate()

	generate: ->
		#iterate through size and generate world
		#or make pre-genned world
		for [k=0...size]
			world[size][size].tile = tile.grass

	render: (entityList) ->
		for [k=0..@size]
			world[size][size].tile.render size, size

	update: (entityList, dt) ->
		for [k=0..@size]
			world[size][size].tile.update dt