window.SessionController = ($scope, $http, $routeParams, security) ->
	$scope.user = {}
	$scope.authError = null
	$scope.valid = true
	$scope.tab = $routeParams.tab
	console.log "in SessionController"
	
	$scope.login = ->
		$scope.authError = null
	
		security.login($scope.user.email, $scope.user.password).then ((response) ->
			$scope.authError = response.data.error unless response.data.success
			return
		), (x) ->
			$scope.authError = "Login Server offline, please try later"
			return

	$scope.signup = ->
		$scope.errors = null
		$scope.valid = true
		console.log $scope.user

		security.signup($scope.user).then ((response) ->
			$scope.valid = response.data.success
			$scope.errors = response.data.errors unless response.data.success
		), (x) ->
			$scope.authError = "Login Server offline, please try later"
			return