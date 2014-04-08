App.service "fileUpload", [
  "$http"
  ($http) ->
    @uploadFileToUrl = (file, uploadUrl) ->
      fd = new FormData()
      fd.append "user[avatar]", file
      $http.post(uploadUrl, fd,
        transformRequest: angular.identity
        headers:
          "Content-Type": `undefined`
      ).success(->
      ).error ->

      return
]