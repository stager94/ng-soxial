(->
  app = undefined
  app = angular.module("app.directives", [])

  app.directive "loginToolbar", [
    "security"
    (security) ->
      directive =
        templateUrl: "toolbar.html"
        restrict: "E"
        replace: true
        scope: true
        link: ($scope, $element, $attrs, $controller) ->
          $scope.isAuthenticated = security.isAuthenticated
          $scope.login = security.showLogin
          $scope.logout = security.logout
          $scope.$watch (->
            security.current_user
          ), (current_user) ->
            $scope.current_user = current_user
            return

          $scope.$on "event:unauthorized", (event) ->
            $scope.isAuthenticated = security.isAuthenticated
            security.showLogin()  
            console.log "showLogin"
            return

          $scope.$on "event:authenticated", (event) ->
            # security.hideLogin()
            console.log "hideLogin"
            return

          return

      return directive
  ]

  app.directive "mainToolbar", (security) ->
    directive =
      templateUrl: "directives/toolbar.html"
      restrict: "E"
      replace: true
      scope: true
      link: ($scope, $element, $attrs, $$controller) ->
        $scope.isAuthenticated = security.isAuthenticated
        $scope.login = security.showLogin
        $scope.logout = security.logout
        $scope.$watch (->
          security.current_user
        ), (current_user) ->
          $scope.current_user = current_user
          return


        $scope.$on "event:unauthorized", (event) ->
          $scope.isAuthenticated = security.isAuthenticated
          security.showLogin()  
          console.log "showLogin"
          return

        $scope.$on "event:authenticated", (event) ->
          # security.hideLogin()
          console.log "hideLogin"
          return
          
        return

    return directive
)()