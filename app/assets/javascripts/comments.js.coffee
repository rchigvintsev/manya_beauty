# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  UrlUtils = ManyaBeauty.UrlUtils

  $(document).on 'click', '.dashboard-table.comments td', ->
    $row = $(this).parent()
    $publishBtn = $('.dashboard-table-header .btn-publish')
    $unpublishBtn = $('.dashboard-table-header .btn-unpublish')

    if $row.hasClass 'published'
      $publishBtn.addClass 'hidden'
      $unpublishBtn.removeClass 'hidden'
    else
      $publishBtn.removeClass 'hidden'
      $unpublishBtn.addClass 'hidden'

    id = $row.find('td.id').text()
    if id
      $publishBtn.attr 'href', UrlUtils.append(id + '/publish')
      $unpublishBtn.attr 'href', UrlUtils.append(id + '/unpublish')
