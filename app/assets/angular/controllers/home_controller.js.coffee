window.HomeController = ($scope, User) ->
	$scope.users = User.query()

# HomeController.resolve =
#   users: (User, $q) ->
#     deferred = $q.defer()
#     User.query ((successData) ->
#       deferred.resolve successData
#       return
#     ), (errorData) ->
#       deferred.reject()
#       return

#     deferred.promise

#   delay: ($q, $timeout) ->
#     delay = $q.defer()
#     $timeout delay.resolve, 10000
#     delay.promise