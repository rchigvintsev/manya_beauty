# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  UrlUtils = ManyaBeauty.UrlUtils

  $(document).on 'click', '.dashboard-table td', ->
    $row = $(this).parent()
    $row.siblings('.active').removeClass 'active'
    $row.addClass 'active'

    $('.dashboard-table-header .btn-edit, .dashboard-table-header .btn-delete').removeClass 'hidden'

    id = $row.find('td.id').text()
    if id
      $('.dashboard-table-header .btn-edit').attr 'href', UrlUtils.append(id + '/edit')
      $('.dashboard-table-header .btn-delete').attr 'href', UrlUtils.append(id)
