String::capitalize = ->
  this.charAt(0).toUpperCase() + this.slice(1)

$.fn.clearFormErrors = () ->
  this.find('.form-group').removeClass 'has-error'
  this.find('span.help-block').remove()

$.fn.clearFormFields = () ->
  this.find(':input').not(':button, :submit, :reset, :hidden').val('')
      .removeAttr('checked').removeAttr('selected')

$.fn.renderFormErrors = (modelName, errors) ->
  this.clearFormErrors()

  form = this

  $.each errors, (fieldName, messages) ->
    field = form.find('input, select, textarea').filter ->
      name = $(this).attr 'name'
      if name
        name.match new RegExp("#{modelName}\\[#{fieldName}\\(?")
    field.closest('.form-group').addClass 'has-error'
    field.parent().append("<span class='help-block text-left'>
        #{$.map(messages, (m) -> m.capitalize()).join '<br/>'}
        </span>")
