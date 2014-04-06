window.AppController = ($scope, security) ->
  console.log "In AppCtrl"
  $scope.debug = false
  $scope.isAuthenticated = security.isAuthenticated
  $scope.lorem = "ipsum"