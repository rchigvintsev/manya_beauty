# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

setupPreviewListener = ->
  clearThumbnail = ->
    $('.photo-preview .thumbnail').find('img, canvas').remove()

  displayPreview = ->
    $('.photo-preview').removeClass 'hidden'

  showErrorMessage = (selector) ->
    clearThumbnail()
    $('.photo-preview .thumbnail').find(selector).removeClass 'hidden'
    displayPreview()

  loadPreview = (e) ->
    target = e.dataTransfer or e.target
    file = target && target.files && target.files[0]
    options = { maxWidth: 240 }
    if file
      loadImage.parseMetaData file, (data) ->
        if data.exif
          options.orientation = data.exif.get('Orientation')
        if not loadImage(file, (img) ->
          if not (img.src or img instanceof HTMLCanvasElement)
            showErrorMessage('.uploading-failure')
          else
            clearThumbnail()
            $('.photo-preview .thumbnail').append(img)
            displayPreview()
        , options)
          showErrorMessage('.api-not-supported')

  $('.photo-file-field').off('change', loadPreview).on('change', loadPreview)


$ -> setupPreviewListener()
$(document).on 'page:load', setupPreviewListener
