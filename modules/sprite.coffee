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