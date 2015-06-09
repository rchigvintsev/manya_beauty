window.ManyaBeauty or= {}

class window.ManyaBeauty.UrlUtils
  constructor: () ->

  @extendParams: (url, params) ->
    if !url
      return url
    questMarkIdx = url.lastIndexOf '?'
    url + (if questMarkIdx == -1 then '?' else '&') + $.param(params)
