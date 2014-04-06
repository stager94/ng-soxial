window.SessionController = ($scope, $http, $routeParams, security) ->
	$scope.user = {}
	$scope.authError = null
	
	$scope.login = ->
		$scope.authError = null
	
		security.login($scope.user.email, $scope.user.password).then ((response) ->
			$scope.authError = response.data.error unless response.data.success
			return
		), (x) ->
			$scope.authError = "Login Server offline, please try later"
			return