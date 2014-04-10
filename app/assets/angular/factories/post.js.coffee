App.factory "Post", ($resource) -> $resource "api/v1/users/:user_id/posts/:id", id: "@id", user_id: "@user_id"


App.factory "PostInfinity", ($http) ->
	PostInfinity = (user_id) ->
		@user_id = user_id
		@items = []
		@busy = false
		@after = ""
		@stop = false
		return

	PostInfinity::nextPage = ->
		console.log "Next Page link", @after
		return if @busy or @stop
		@busy = true
		url = "/api/v1/users/" + @user_id + "/posts?after=" + @after
		$http.get(url).success ((data) ->
			if data.length
				i = 0
				while i < data.length
					@items.push data[i++]

				@after = data[data.length-1].id
				@busy = false
			else
				@stop = true
			return
		).bind(this)
		return

	PostInfinity