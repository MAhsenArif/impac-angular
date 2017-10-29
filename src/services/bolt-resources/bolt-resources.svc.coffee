angular
.module('impac.services.bolt-resources', [])
.service('BoltResources', ($http, ImpacMainSvc) ->

  authHeaders = ->
    ssoSession = ImpacMainSvc.getSsoSessionId()
    if _.isEmpty(ssoSession) then {} else { 'Authorization': 'Basic ' + btoa(ssoSession) }

  buildUrl = (pathArray, paramsHash) ->
    url = pathArray.join('/')
    params = decodeURIComponent( $.param(paramsHash) )
    [url, params].join('?')

  @index = (boltPath, resourcesName, params) ->
    url = buildUrl([boltPath, resourcesName], params)
    $http.get(url, { headers: authHeaders() })

  @update = (boltPath, resourcesName, resourceId, attributes) ->
    url = [boltPath, resourcesName, resourceId].join('/')
    body =
      data:
        id: resourceId
        type: resourcesName
        attributes: attributes
    $http.put(url, body, { headers: authHeaders() })

  return
)
