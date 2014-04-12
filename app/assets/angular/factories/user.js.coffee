App.factory "User", ($resource) -> $resource "api/v1/users/:id", id: "@id"

App.factory "Profile", ($q, $http, $resource) ->
	Profile = (user_id) ->
		@user_id = user_id
		@friends = []
		return
	
	Profile::getFriends = ->
		$http.get("/api/v1/users/" + @user_id + "/friends").success((response) ->
			@friends = response
			return
		)
		return

	Profile