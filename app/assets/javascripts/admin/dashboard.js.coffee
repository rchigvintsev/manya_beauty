# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  UrlUtils = ManyaBeauty.UrlUtils

  $(document).on 'click', '.admin-table td', ->
    $row = $(this).parent()
    $row.siblings('.active').removeClass 'active'
    $row.addClass 'active'

    $('.admin-table-header .btn-edit, .admin-table-header .btn-delete').removeClass 'hidden'

    id = $row.find('td.id').text()
    if id
      $('.admin-table-header .btn-edit').attr 'href', UrlUtils.append(id + '/edit')
      $('.admin-table-header .btn-delete').attr 'href', UrlUtils.append(id)
