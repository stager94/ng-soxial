window.AccessController = {}

AccessController.checkAuth = (access) ->
	access.checkAuth false

AccessController.checkAccess = (access) ->
	access.checkAuth true