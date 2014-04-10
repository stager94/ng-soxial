App.factory "Post", ($resource) -> $resource "api/v1/users/:user_id/posts/:id", id: "@id", user_id: "@user_id"


App.factory "PostInfinity", ($http) ->
	PostInfinity = (user_id, favorite=false) ->
		console.log "in PostInfinity init"
		@user_id = user_id
		@items = []
		@busy = false
		@after = ""
		@stop = false
		@favorite = favorite
		console.log @after
		return

	PostInfinity::nextPage = ->
		console.log "Next Page link", @after
		return if @busy or @stop
		@busy = true
		if @favorite
			url = "/api/v1/users/" + @user_id + "/posts/favorites?after=" + @after
		else
			url = "/api/v1/users/" + @user_id + "/posts?after=" + @after

		$http.get(url).success ((data) ->
			if data.posts.length
				i = 0
				while i < data.posts.length
					@items.push data.posts[i++]

				@after = data.last_id
				@busy = false
			else
				@stop = true
			return
		).bind(this)
		return

	PostInfinity::favourite = (id) ->
		

	PostInfinity