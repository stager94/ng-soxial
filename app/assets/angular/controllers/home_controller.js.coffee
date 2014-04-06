window.HomeController = ($scope, $http, $routeParams, tokenHandler, security, users) ->
	$scope.users = users


HomeController.resolve =
  users: (User, $q) ->
    
    deferred = $q.defer()
    User.query ((successData) ->
      deferred.resolve successData
      return
    ), (errorData) ->
      deferred.reject()
      return

    deferred.promise

  # delay: ($q, $timeout) ->
  #   delay = $q.defer()
  #   $timeout delay.resolve, 1000
  #   delay.promise