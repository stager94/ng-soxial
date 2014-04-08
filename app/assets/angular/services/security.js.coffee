angular.module "security", ["security.service"]

angular.module("security.service", []).factory "security", [
	"$location",
	"$http",
	"$q",
	"Session",
	"tokenHandler",
	"profile"
	($location, $http, $q, Session, tokenHandler, profile) ->
		redirect = (url) ->
			url = url or "/"
			$location.path url
			return

		service = 
			showLogin: ->
				redirect "/login"

			hideLogin: ->
				redirect "/"

			login: (email, password) ->
				$http.post("/api/v1/login.json",
					user:
						email: email,
						password: password
				).success (data, status, header, config) ->
					service.current_user = data.user
					tokenHandler.set data.auth_token
					if service.isAuthenticated() then redirect()

			signup: (params) ->
				console.log "Params: ", params
				$http.post("/api/v1/signup.json",
					user: params
				).success (data, status, header, config) ->
					console.log "signup.success"
					service.current_user = data.user
					tokenHandler.set data.user.auth_token
					if service.isAuthenticated() then redirect()

			logout: (redirectTo) ->
				$http.post("/api/v1/logout.json").then (response) ->
					service.current_user = null
					tokenHandler.set "none"
					redirect redirectTo
					return
				return false

			update: (params, avatar_params) ->
				console.log "params:", params
				$http.post("api/v1/update_profile.json",
					avatar_params
					transformRequest: angular.identity,
					headers:
	          "Content-Type": `undefined`
				).success (data, status, header, config) ->
					console.log "PROFILE.USER", profile.user
					profile.user = null
					console.log "PROFILE.USER2", profile.user
					console.log "api.update_profile success"

			requestCurrentUser: ->
				if service.isAuthenticated()
					return service.current_user
				else
					service.reloadCurrentUser()
					# $http.get("/api/v1/current_user.json").then (response) ->
					# 	service.current_user = response.data.user
					# 	tokenHandler.set response.data.auth_token
					# 	return service.current_user

			reloadCurrentUser: ->
				$http.get("/api/v1/current_user.json").then (response) ->
					service.current_user = response.data.user
					tokenHandler.set response.data.auth_token
					return service.current_user				

			current_user: null

			isAuthenticated: ->
				!!service.current_user

		return service
]