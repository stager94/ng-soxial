angular.module "security", ["security.service"]

angular.module("security.service", []).factory "security", [
	"$location",
	"$http",
	"Session",
	"tokenHandler"
	($location, $http, Session, tokenHandler) ->
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

			logout: (redirectTo) ->
				$http.post("/api/v1/logout").then ->
					console.log "Logout"
					service.current_user = null
					tokenHandler.set "none"
					redirect redirectTo
					return

			requestCurrentUser: ->
				if service.isAuthenticated()
					console.log "requestCurrentUser 1", service.current_user
					return service.current_user
				else
					$http.get("/api/v1/current_user.json").then (response) ->
						service.current_user = response.data.user
						tokenHandler.set response.data.auth_token
						console.log "requestCurrentUser 2", service.current_user
						return service.current_user

			checkingAuth: ->
				console.log "checkingAuth: ", service.current_user
				# if service.isAuthenticated() then hideLogin

			current_user: null

			isAuthenticated: ->
				!!service.current_user

		return service
]