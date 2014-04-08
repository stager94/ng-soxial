window.UsersController = ($scope, $http, $compile, $routeParams, $q, $location, User, profile) ->
	console.log "in UsersController"

	User.get
		id: $routeParams.id
	, (response) ->
		$scope.user = response
		$scope.user.about = $.simpleFormat response.about


	# request user for menu directive
	profile.requestUser $routeParams.id unless profile.user && profile.user.id == parseInt($routeParams.id)

	if $routeParams.tab
		$scope.tab = $routeParams.tab
	else
		$scope.tab = "information"

	# show necessary tab
	newElement = $compile("<user-" + $scope.tab + " />")($scope)
	$("#user-directives").append newElement


# UsersController.resolve =
# 	users: (User, $q) ->
# 		deferred = $q.defer()

# 		User.get ((successData) ->
# 			deferred.resolve successData
# 			return
# 		), (errorData) ->
# 			deferred.reject()
# 			return

# 		deferred.promise

	# delay: ($q, $defer) ->
	#   delay = $q.defer()
	#   $defer delay.resolve, 1000
	#   delay.promise