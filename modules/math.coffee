Engine.math = ->

	E.random = (number) ->
		Math.floor Math.random() * number

	E.distance = (fromX, fromY, toX  = 0, toY = 0) ->
		Math.sqrt Math.pow(fromX - fromY), 2 + Math.pow(toX - toY), 2

	Engine.math