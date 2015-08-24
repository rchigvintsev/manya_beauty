window.ManyaBeauty or= {}

class window.ManyaBeauty.UrlUtils
  constructor: () ->

  @extendParams: (url, params) ->
    if !url
      return url
    questMarkIdx = url.lastIndexOf '?'
    url + (if questMarkIdx == -1 then '?' else '&') + $.param(params)

  @append: (path) ->
    location = window.location
    if !path
      return location.pathname + location.search + location.hash
    if path.slice(0, 1) != '/'
      path = '/' + path
    location.pathname + path + location.search + location.hash
