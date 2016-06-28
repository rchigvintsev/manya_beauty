$ ->
  $('#links').justifiedGallery { captions: false }

  $links = $('#links > a')

  $links.click (e) ->
    self = this

    options = {
      index: this,
      event: e.originalEvent,
      emulateTouchEvents: false,
      toggleSlideshowOnSpace: false,
      toggleControlsOnReturn: false,
      closeClass: 'close-slideshow',

      onopened: ->
        # Without this line of code the opened slide cannot be scrolled down
        # immediately by the mouse wheel.
        $(this.slides[this.index]).find('.modal').mousewheel ->

      onslide: (index, slide) ->
        descriptionText = $(this.list[index]).attr('data-description')
        $description = $(slide).find('.description')
        $description.empty()
        if descriptionText
          $description.text(descriptionText)

      onslidecomplete: (index, slide) ->
        UrlUtils = ManyaBeauty.UrlUtils

        $slide = $(slide)
        $link = $(this.list[index])

        photoId = $link.attr 'data-photo-id'

        $slide.attr 'data-photo-id', photoId

        $form = $slide.find '#comment_form'

        action = $form.attr 'action'
        $form.attr 'action', UrlUtils.extendParams(action, { photo_id: photoId })

        $form.on 'ajax:beforeSend', (evt, xhr, settings) ->
          $this = $(this)
          $this.find('.alert-success').remove()
          $this.find(':submit').button('loading')

        $form.on 'ajax:complete', (evt, xhr, status) ->
          $(this).find(':submit').button('reset')

        $form.on 'ajax:error', (evt, xhr, status, error) ->
          try
            $(this).renderFormErrors 'comment', $.parseJSON(xhr.responseText)
          catch err
            console.error err

        $form.on 'ajax:success', (evt, data, status, xhr) ->
          $this = $(this)
          $this.clearFormFields()
          $this.clearFormErrors()
          $this.find('.alert-success').removeClass 'hidden'

        $form.find(':input').not(':button, :submit, :reset, :hidden').keydown (e) ->
          if e.which == 37 or e.which == 39
            e.stopPropagation()
          return true

        $form.find(':submit').removeAttr 'disabled'

        $.ajax {
          url: $link.attr('data-comments-href'),
          type: 'GET',
          headers: {
            Accept: "*/*;q=0.5, text/javascript, application/javascript,
                     application/ecmascript, application/x-ecmascript"
          }
        }
    }

    blueimp.Gallery $links, options
