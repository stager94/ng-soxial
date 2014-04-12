window.UploaderController = ($scope, $rootScope, $filter, uploadManager) ->
	$scope.destroy = (attachment_id) ->
		uploadManager.destroy attachment_id

	$rootScope.$on "fileAdded", (e, call) ->
		$scope.$parent.uploaded.push call
		$scope.$apply()
		return

	$rootScope.$on "uploadProgress", (e, call) ->
		$scope.$parent.percentage = call
		$scope.$apply()
		return

	$rootScope.$on "uploadSuccess", (e, call) ->
		file = $filter('filter')($scope.$parent.uploaded, { uid: call.uid })[0]
		file["thumbnailUrl"] = call.thumbnailUrl
		file["id"] = call.id
		$scope.$apply()
		return

	$rootScope.$on "destroySuccess", (e, call) ->
		$scope.$parent.uploaded = $scope.$parent.uploaded.filter (item) -> item.id isnt parseInt(call.image_id)
		return

	$scope.percentage = 0