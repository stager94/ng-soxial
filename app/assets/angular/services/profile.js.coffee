angular.module "profile", ["profile.service"]

angular.module("profile.service", []).factory "profile", (User, Session) ->
		service =
			user: null

			setUser: (user_id) ->
				service.user = User.get id: user_id

			requestUser: (user_id) ->
				service.setUser user_id if !service.user || service.user.id != user_id
				return service.user

			checkUser: (user) ->
				console.log user.id, service.user
				return

		return service