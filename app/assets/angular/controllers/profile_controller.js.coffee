window.ProfileController = ($scope, $http, User, security) ->
	console.log "in ProfileController"
	$scope.user = security.requestCurrentUser()

	$scope.errors = null
	$scope.valid = true

	$scope.$on "event:updated", (event, message) ->
		$scope.message = message
		$scope.myAvatarFile = null
		$scope.myCoverFile = null
		security.reloadCurrentUser()


	$scope.update = ->
		$scope.errors = null
		$scope.valid = true
		$scope.message = null

		formElement = $("#update-form")
		fd = new FormData formElement

		angular.forEach $scope.user, (value, key) ->
			if value == `undefined`
				value = ""
			fd.append "user[" + key + "]", value if key not in ["avatar", "cover"]

		fd.append "user[avatar]", $scope.myAvatarFile if $scope.myAvatarFile
		fd.append "user[cover]", $scope.myCoverFile if $scope.myCoverFile


		security.update($scope.user, fd).then ((response) ->
			$scope.valid = response.data.success
			$scope.errors = response.data.errors unless response.data.success
			$scope.$emit("event:updated", response.data.message) if response.data.success
		), (x) ->
			$scope.authError = "Login Server offline, please try later"
			return