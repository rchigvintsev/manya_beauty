$ ->
  $('.thumbnail > #owl_carousel').each (i, owl) ->
    $owl = $(owl)

    items = $owl.find('.item')

    if items.length > 1
      $owl.owlCarousel({
        navigation : false,
        pagination: false,
        singleItem : true,
        transitionStyle : 'fade',
        autoPlay: 2000
      })

      carousel = $owl.data('owlCarousel')
      carousel.stop()

      carousel.$elem.on 'mouseenter', (e) ->
        if carousel.hoverStatus != 'play'
          carousel.next()
          carousel.play()

      carousel.$elem.on 'mouseleave', (e) ->
        carousel.stop()
