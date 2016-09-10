$ ->
  UrlUtils = ManyaBeauty.UrlUtils

  $(document).on 'click', '.admin-table.comments td', ->
    $row = $(this).parent()
    $publishBtn = $('.admin-table-header .btn-publish')
    $unpublishBtn = $('.admin-table-header .btn-unpublish')

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
