App.factory "uploadManager", ($rootScope) ->
  add: (file) ->
    file.files[0].uid = @guid()
    $rootScope.$broadcast "fileAdded", file.files[0]
    file.submit().then ((response) ->
      result = {
        uid: file.files[0].uid,
        thumbnailUrl: angular.fromJson(response).thumbnailUrl
      }
      $rootScope.$broadcast "uploadSuccess", result

    )
    return

  guid: ->
    s4 = ->
      Math.floor((1 + Math.random()) * 0x10000).toString(16).substring 1
    s4() + s4() + "-" + s4() + "-" + s4() + "-" + s4() + "-" + s4() + s4() + s4()

  setProgress: (percentage) ->
    $rootScope.$broadcast "uploadProgress", percentage
    return
