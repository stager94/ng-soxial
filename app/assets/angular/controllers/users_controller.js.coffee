window.UsersController = ($scope, $routeParams, User) ->
	console.log "in UsersController"
	console.log $routeParams.id
	$scope.user = User.get({id: $routeParams.id})
	console.log $scope.user

UsersController.checkAuth = ($q, $http, $rootScope, $location) ->
	defered = $q.defer()
	$http.get("/api/v1/current_user.json"
	).success((response) ->
		if response.success
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