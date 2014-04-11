window.PostsController = ($scope, $http, $routeParams, $rootScope, $filter, Post, security, PostInfinity, profile, uploadManager) ->
	$scope.create = ->
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

	$scope.delete = (index) ->
		post = new Post $scope.reddit.items[index]
		console.log post.id
		$scope.reddit.items.splice index, 1
		post.$delete { user_id: $scope.current_user.id, id: post.id }

	$rootScope.$on "fileAdded", (e, call) ->
		$scope.uploaded.push call
		$scope.$apply()
		return

	$rootScope.$on "uploadProgress", (e, call) ->
		$scope.percentage = call
		$scope.$apply()
		return

	$rootScope.$on "uploadSuccess", (e, call) ->
		file = $filter('filter')($scope.uploaded, { uid: call.uid })[0]
		file["thumbnailUrl"] = call.thumbnailUrl
		$scope.$apply()
		return

	$scope.reddit = new PostInfinity $routeParams.id

	$scope.post = new Post
	$scope.uploaded = []
	$scope.percentage = 0
	$scope.tab = $routeParams.tab
	
	
	$scope.$watch (->
		security.current_user
	), (current_user) ->
		$scope.current_user = current_user
		return

	$(".post-text").autosize()

	$scope.$on "post:created", (event, object) ->
		console.log event, object
		$scope.reddit.items.unshift object