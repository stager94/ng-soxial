angular.module "access", ["access.service"]

angular.module("access.service", []).factory "access", ($http, $location, $q, tokenHandler) ->
		service =
			checkAuth: (signed) ->
				defered = $q.defer()
				$http.get("/api/v1/current_user.json"
				).success((response) ->
					if (response.success && signed == true) || (!response.success && signed == false)
						defered.resolve response
					else
						defered.reject()
						$location.path("/").replace()
					return
				).error ->
					defered.reject()
					$location.path("/").replace()
					return
				defered.promise

		return service