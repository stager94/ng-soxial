App.factory "uploadManager", ($rootScope, $http) ->
  add: (file) ->
    file.files[0].uid = @guid()
    $rootScope.$broadcast "fileAdded", file.files[0]
    file.submit().then ((response) ->
      result = {
        uid: file.files[0].uid,
        id: angular.fromJson(response).id
        thumbnailUrl: angular.fromJson(response).thumbnailUrl
      }
      $rootScope.$broadcast "uploadSuccess", result

    )
    return

  destroy: (file_id) ->
    $http.post("/api/v1/attachments/" + file_id + "/destroy").success ((response) ->
      $rootScope.$broadcast "destroySuccess", response
    )

  guid: ->
    s4 = ->
      Math.floor((1 + Math.random()) * 0x10000).toString(16).substring 1
    s4() + s4() + "-" + s4() + "-" + s4() + "-" + s4() + "-" + s4() + s4() + s4()

  setProgress: (percentage) ->
    $rootScope.$broadcast "uploadProgress", percentage
    return
