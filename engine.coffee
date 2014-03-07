class resources

	resourceCache: []
	loading: []
	readyCallBacks: []

	load: (urlOrArr) ->
		if urlOrArr is Array
			urlOrArr.forEach (url) ->
				_load url
		else
			_load urlOrArr

	_load: (url) ->
		if resourceCache[url]
			resourceCache[url]
		else
			img = new Image()
			img.onLoad = () ->
				resourceCache[url] = img

				if isReady()
					readyCallbacks.forEach (func) -> func()

			resourceCache[url] = false
			img.src = url

	get: (url) ->
		resourceCache[url]

	isReady: ->
		ready = true
		for k in resourceCache
			if resourceCache.hasOwnProperty[k] and !resourceCache[k]
				ready = false

	onReady: ->
		readyCallbacks.push func

	window.resources = [
		load: load,
		get: get,
		onReady: onReady,
		isReady: isReady
	]

class engine extends resources
	canvas: null
	context: null

	constructor: ->
		@canvas = document.createElement 'canvas'
		@context = @canvas.getContext '2d'
		@setSize(512, 480)
		document.body.appendChild(@canvas)

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
			@terrainPatter = @context.createPattern resources.get 'assets/images/test/terrain.png', 'repeat'

	renderBackground: ->
		@context.fillStyle = @terrainPattern
		@context.fillRect 0, 0, @canvas.width, @canvas.height

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

class Sprite extends engine

	constructor: (url, pos, size, speed, frames, dir, once) ->
		@pos = pos
		@size = size
		@speed = 0 if speed is not 'number'
		@frames = frames
		@_index = 0
		@url = url
		@dir = dir or 'horizontal'
		@once = once or false

	update: (delta) ->
		@_index += @speed * delta

	render: (context) ->
		if speed > 0
			max = @frames.length
			idx = Math.floor(@_index)
			frame = @frames[idx % max]

			if (@once and idx >= max)
				@done = true
				return
		else
			frame = 0

		x = @pos[0]
		y = @pos[1]

		if @dir is 'vertical'
			y += frame * @size[1]
		else
			x += frame * @size[0]

		img = resources.get @url
		context.drawImage img, x, y, @size[0], @size[1], 0, 0, @size[0], @size[1]

window.Sprite = Sprite

class input

	pressedKeys: []
	keyDown: []

	setKey: (event, status) ->
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
		 	key = String.fromCharCode(code)

		pressedKeys[key] = status

	document.addEventListener 'keydown', (e) -> 
		setKey e, true

	document.addEventListener 'keyup', (e) ->
		setKey e, false

	window.addEventListener 'blur', () ->
		pressedKeys = []

	window.input = [
		isDown: (key) ->
			pressedKeys[key.toUpperCase()]

		isPressed: (key) ->
			key == keyDown
		]