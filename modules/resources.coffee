class resources

	resourceCache: []
	loading: []
	readyCallBacks: []

	constructor: ->
		#does nothing

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

	window.resources = resources