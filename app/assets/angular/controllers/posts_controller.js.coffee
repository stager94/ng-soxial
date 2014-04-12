window.PostsController = ($scope, $http, $routeParams, $rootScope, $timeout, Post, security, PostInfinity, profile) ->
	$scope.create = ->
		if $scope.new_post.$valid
			images_ids = _.pluck $scope.uploaded, "id"
			post_new = Post.save text: $scope.post.text, user_id: $routeParams.id, author_id: security.current_user.id, images_ids: images_ids
			$scope.$emit "post:created", post_new
			$timeout (->
				$(".media-images").plugin true
			), 10

	$scope.favorite = (id, index) ->
		if $scope.reddit.items[index].is_favorite == false
			path = "favorite"
		else
			path = "unfavorite"
		$http.get("/api/v1/posts/" + id + "/" + path).success((response) ->
			$scope.reddit.items[index].is_favorite = response.favorite
		).error ->
			alert "Error!"

	$scope.delete = (index) ->
		post = new Post $scope.reddit.items[index]
		$scope.reddit.items.splice index, 1
		$timeout (->
			$(".media-images").plugin false
		), 10
		post.$delete { user_id: $scope.current_user.id, id: post.id }

	$scope.reset = ->
		$(".post-text").val("").trigger "autosize.resize"
		$scope.post = new Post
		$scope.uploaded = []
		$scope.percentage = 0

	$scope.reddit = new PostInfinity $routeParams.id

	# Variables for creating new Post
	$scope.reset()

	$scope.tab = $routeParams.tab
	
	$scope.$watch (->
		security.current_user
	), (current_user) ->
		$scope.current_user = current_user
		return

	$scope.$watch (->
		$scope.reddit.busy
	), (reddit) ->
		$timeout (->
			$(".media-images").plugin true
		), 10

	$(".post-text").autosize()

	$scope.$on "post:created", (event, object) ->
		$scope.reset()
		$scope.reddit.items.unshift object
		$timeout (->
			$(".media-images").plugin true
		), 500

	$scope.$on "event:loadPosts", (event, object) ->
		alert "loadPosts"
		$('.media-images').plugin()