window.ProfileController = ($scope, $http, User, security, fileUpload) ->
	console.log "in ProfileController"
	$scope.user = security.requestCurrentUser()
	$scope.errors = null
	$scope.valid = true

	$scope.$on "event:updated", (event, message) ->
		$scope.message = message
		$scope.myFile = null
		security.reloadCurrentUser()


	$scope.update = ->
		$scope.errors = null
		$scope.valid = true
		$scope.message = null

		formElement = $("#update-form")
		fd = new FormData formElement
		fd.append "user[avatar]", $scope.myFile if $scope.myFile

		angular.forEach $scope.user, (value, key) ->
			if value == `undefined`
				value = ""
			fd.append "user[" + key + "]", value

		security.update($scope.user, fd).then ((response) ->
			$scope.valid = response.data.success
			$scope.errors = response.data.errors unless response.data.success
			$scope.$emit("event:updated", response.data.message) if response.data.success
		), (x) ->
			$scope.authError = "Login Server offline, please try later"
			return