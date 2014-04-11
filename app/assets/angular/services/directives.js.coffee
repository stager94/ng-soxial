(->
  app = undefined
  app = angular.module("app.directives", [])

  app.directive "mainToolbar", (security) ->
    directive =
      templateUrl: "directives/toolbar.html"
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
          console.log 'event:unauthorized'
          $scope.isAuthenticated = security.isAuthenticated
          return

        $scope.$on "event:authenticated", (event) ->
          console.log "hideLogin"
          return
          
        return
    return directive

  app.directive "userPosts", ($routeParams, PostInfinity) ->
    directive =
      templateUrl: "directives/users/posts.html"
      restrict: "AECM"
      replace: true
      scope: true
      link: ($scope, $element, $attrs, $controller) ->
        console.log "in userPosts directive"
        $scope.reddit = new PostInfinity $routeParams.id

    return directive

  app.directive "userFavoritePosts", ($routeParams, PostInfinity) ->
    directive =
      templateUrl: "directives/users/posts.html"
      restrict: "AECM"
      replace: true
      scope: true
      link: ($scope, $element, $attrs, $controller) ->
        console.log "in userPosts directive"
        $scope.reddit = new PostInfinity $routeParams.id, true

    return directive


  app.directive "userInformation", ($routeParams, User) ->
    directive =
      templateUrl: "directives/users/information.html"
      restrict: "AECM"
      replace: false
      scope: false
      link: ($scope, $element, $attrs, $controller) ->
        console.log "in userPosts directive"
        # $scope.user = User.get {id: $routeParams.id}

    return directive

  app.directive "userMenu", (profile) ->
    directive =
      templateUrl: "directives/users/menu.html"
      restrict: "AECM"
      replace: true
      scope: true
      link: ($scope, $element, $attrs, $controller) ->
        $scope.$watch (->
          profile.user
        ), (user) ->
          $scope.user = user
          return

    return directive

  app.directive "upload", [
    "uploadManager"
    factory = (uploadManager) ->
      return (
        restrict: "A"
        link: (scope, element, attrs) ->
          $(element).fileupload
            dataType: "text"
            add: (e, data) ->
              uploadManager.add data
              return

            progressall: (e, data) ->
              progress = parseInt(data.loaded / data.total * 100, 10)
              uploadManager.setProgress progress
              return

            done: (e, data) ->
              uploadManager.setProgress 0
              return

          return
      )
  ]


  app.directive "fileModel", [
    "$parse"
    ($parse) ->
      return (
        restrict: "A"
        link: (scope, element, attrs) ->
          model = $parse(attrs.fileModel)
          modelSetter = model.assign
          element.bind "change", ->
            console.log "..fileModel changed.."
            scope.$apply ->
              modelSetter scope, element[0].files[0]
              return

            return

          return
      )
  ]
)()