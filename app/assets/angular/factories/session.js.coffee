App.factory "Session", [
  "$resource"
  ($resource) ->
    return $resource("/api/v1/sessions", {},
      login:
        method: "POST"
        isArray: true
    )
]