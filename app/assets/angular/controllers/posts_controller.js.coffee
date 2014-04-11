window.PostsController = ($scope, $http, $routeParams, Post, security, PostInfinity) ->
	$scope.create = ->
		console.log "$scope.create"
		if $scope.new_post.$valid
			post_new = Post.save text: $scope.post.text, user_id: $routeParams.id, author_id: security.current_user.id
			$(".post-text").val("").trigger "autosize.resize"
			$scope.$emit "post:created", post_new
			$scope.post = new Post
			

	$scope.favorite = (id, index) ->
		if $scope.reddit.items[index].is_favorite == false
			path = "favorite"
		else
			path = "unfavorite"

		$http.get("/api/v1/posts/" + id + "/" + path).success((response) ->
			$scope.reddit.items[index].is_favorite = response.favorite
		).error ->
			alert "Error!"

	# $scope.upload = ->
	# 	console.log $scope.post

	$scope.post = new Post
	# $scope.post.images = []

	$scope.tab = $routeParams.tab

	$(".post-text").autosize()

	$scope.$on "post:created", (event, object) ->
		console.log event, object
		$scope.reddit.items.unshift object