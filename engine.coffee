class engine extends resources
	canvas: null
	context: null

	constructor: ->
		@canvas = document.createElement 'canvas'
		@context = @canvas.getContext '2d'
		@setSize(512, 480)
		document.body.appendChild(@canvas)
		@resources = new Resources()
		@pattern = resources.get 'assets/images/terrain.png', 'repeat'

	setSize: (width, height) ->
		size = [width, height]
		@canvas.width = width
		@canvas.height = height
		size

	setBackground: (imageLoc, fullBackground) ->
		full = fullBackground or false;
		if full is false
			@terrainPattern = @context.drawImage imageLoc, 0, 0
		else
			@terrainPatter = @context.createPattern @pattern

	renderBackground: ->
		@context.fillStyle = @terrainPattern
		@context.fillRect 0, 0, @canvas.width, @canvas.height

	clear: ->
		@context.clearRect 0, 0, @canvas.width, @canvas.height

	collides: (x, y, r, b, x2, y2, r2, b2) ->
		not (r <= x2 or x > r2 or b <= y2 or y > b2)

	boxCollides: (pos, size, pos2, size2) ->
		@collides pos[0], 
		pos[1], 
		pos[0] + size[0], 
		pos[1] + size[1], 
		pos2[0], pos2[1], 
		pos2[0] + size2[0], 
		pos2[1] + size2[1]