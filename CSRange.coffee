root = exports ? this

class CSRange
	constructor: (@location=NaN, @length=NaN, options={}) ->
		# initialOptions = initialOptions ? {}

		if typeof @location is 'object'
			o = @location
			o[k] = v for k, v of @length when typeof @length is 'object'
			o[k] = v for k, v of options when typeof options is 'object'
			options = o

		@location = if typeof @location is 'number' then @location else NaN
		@length = if typeof @length is 'number' then @length else NaN

		# defaultContextName = options['defaultContextName'] ? 'local'

		# @contexts = {}		

		# @options = {}
		for k, v of options
			if k == 'location' then @location = v
			else if k == 'length' then @length = v

			# else @options[k] = v

		
		# @c defaultContextName, default: true if not @c(defaultContextName)?
		
		# @contexts[options['defaultContextName'] ? 'local'] = @

		# @mode 		= @options.defaultContextName
		# @classes 	= ['CSRange']
	# @addMode: (modeName, range) ->
	# 	@modes[modeName] = range

	@newRangeFromArray: (a, options={}) ->
		new CSRange a[0], a.length, options

	@newRangeFromRange: (range) ->
		if range
			options = {}
			# options.contexts = range.c()
			new CSRange range.location, range.length, options
		


	range: (a, b) ->

		if a?
			if typeof a == 'object' and a.location? and a.length?
				@location 	= a.location
				@length 	= a.length
			else if b? and typeof a == 'number' and typeof b == 'number'
				@location   = a
				@length   = b

		location : 	@location
		length   : 	@length
	# TODO: Should this be recursive?
	# locationOfMode: (modeName, newLocation) ->
	# 	m = @mode[modeName]
	# 	lo = if newLocation then m.location(newLocation) else m.location()
	# 	lo

	# lengthOfMode: (modeName, newLength) ->
	# 	m = @mode[modeName]
	# 	le = if newLocation then m.location(newLocation) else m.location()
	# 	le
	
	# TODO: fat arrow?
	maxEdge: () ->
		@location + @length

	array: (a) ->
		if a
			@range a[0], a.length

		if @length then [@location...@maxEdge()] else []

	# nArray: () ->
	# 	if @length > 0 then @array() else []

	# TODO: This needs to be recursive.
	newJSON: () ->
		j =
			location 	: 	@location
			length 		: 	@length
			# contexts 	:	@contexts

		# dmn = [@options.defaultModeName] # Default mode name.
		# j.modes[dmn] = 'this'

		for k, v of @modes when k != j.mode
			j.modes[k] =
				location: v.location
				length 	: v.length
		j

	@newRangeFromJSON: (j, options={}) ->
		lo = j.location
		le = j.length
		if lo? and le?
			return new CSRange lo, le, options
		null



# class CSTextRange extends CSRange
# 	constructor: (@location=0, @length=0, @lines=[]) ->


class CSAttributedRange extends CSRange
	constructor: (@location=NaN, @length=NaN, options={}) ->
		o = if typeof @location is 'object' then @location
		super @location, @length, options

		# attributes = options.attributes ? {}
		@attributes = {}
		@addAttributes o.attributes if typeof o is 'object' and o.attributes
		@addAttributes options.attributes if options.attributes
		# for k, v of options.attributes ? {}
		# 	@attributes[k] = v
		
	# copy: () ->
	# 	_shallowCopy CSAttributedRange
	addAttribute: (k, v) ->
		@attributes[k] = v
		return

	addAttributes: (attributesToAdd) ->		
		@addAttribute k, v for k, v of attributesToAdd
		return
# class CSSingleTextLineRange extends CSRange
# 	constructor: (@location=0, @length=0, @lineNumber=0) ->

root.CSRange 				= CSRange
# root.CSTextRange 			= CSTextRange
root.CSAttributedRange 		= CSAttributedRange
# root.CSSingleTextLineRange 	= CSSingleTextLineRange