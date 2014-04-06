App.factory "tokenHandler", ->
  tokenHandler = {}
  token = "none"
  tokenHandler.set = (newToken) ->
    token = newToken
    return

  tokenHandler.get = ->
    token

  
  # wrap given actions of a resource to send auth token with every
  # request
  tokenHandler.wrapActions = (resource, actions) ->
    
    # copy original resource
    wrappedResource = resource
    i = 0

    while i < actions.length
      tokenWrapper wrappedResource, actions[i]
      i++
    
    # return modified copy of resource
    wrappedResource

  
  # wraps resource action to send request with auth token
  tokenWrapper = (resource, action) ->
    
    # copy original action
    resource["_" + action] = resource[action]
    
    # create new action wrapping the original and sending token
    resource[action] = (data, success, error) ->
      resource["_" + action] angular.extend({}, data or {},
        auth_token: tokenHandler.get()
      ), success, error

    return

  tokenHandler
