window.PostsController = ($scope, $http, $routeParams, Post, security, PostInfinity) ->
	$scope.create = ->
		if $scope.new_post.$valid
			post_new = Post.save text: $scope.post.text, user_id: $routeParams.id, author_id: security.current_user.id
			$scope.$emit "post:created", post_new
			$scope.post = new Post
			$(".post-text").val("").trigger "autosize.resize"

	$scope.reddit = new PostInfinity $routeParams.id

	$scope.post = new Post

	$(".post-text").autosize()

	# User.get
	# 	id: 2
	# , (response) ->
	# 	$scope.user = response

	$scope.$on "post:created", (event, object) ->
		$scope.reddit.items.unshift object