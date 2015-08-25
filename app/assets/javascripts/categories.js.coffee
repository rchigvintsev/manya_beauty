# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  UrlUtils = ManyaBeauty.UrlUtils

  $(document).on 'click', 'table.categories tr', ->
    $this = $(this)
    $this.siblings('.active').removeClass 'active'
    $this.addClass 'active'

    $('.table-header .btn-edit, .table-header .btn-delete').removeAttr 'disabled'

    id = $this.find('td.hidden.id').text()
    if id
      $('.table-header .btn-edit').attr 'href', UrlUtils.append(id + '/edit')
      $('.table-header .btn-delete').attr 'href', UrlUtils.append(id)
