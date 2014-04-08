window.MenuController = ($scope) ->
	$scope.isActive = (location, tab) ->
		return location == tab