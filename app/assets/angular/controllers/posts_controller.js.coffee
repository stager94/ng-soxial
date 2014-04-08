window.PostsController = ($scope, $http, $routeParams, Post, User, security) ->
	$scope.create = ->
		if $scope.new_post.$valid
			post_new = Post.save text: $scope.post.text, user_id: $routeParams.id, author_id: security.current_user.id
			$scope.$emit "post:created", post_new
			$scope.post = new Post

	$scope.post = new Post
	$scope.posts = Post.query user_id: $routeParams.id

	User.get
		id: 2
	, (response) ->
		$scope.user = response

	$scope.$on "post:created", (event, object) ->
		$scope.posts.unshift object