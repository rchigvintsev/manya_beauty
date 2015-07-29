# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

setupCarousel = ->
  jcarousel = $('.jcarousel').jcarousel {wrap: 'circular'}
  jcarousel.jcarouselAutoscroll {
    interval: 3000,
    target: '+=1',
    autostart: true
  }

  $('.jcarousel-prev, .jcarousel-next').click ->
    $(this).blur()

  $('.jcarousel-prev').jcarouselControl { target: '-=1' }
  $('.jcarousel-next').jcarouselControl { target: '+=1' }

reloadCarousel = ->
  $jcarousel = $('.jcarousel')
  if $jcarousel.length != 0
    $jcarousel.jcarousel('reload').jcarouselAutoscroll 'start'

$document = $(document)

$document.on 'page:update', ->
  setupCarousel()

$document.on 'page:restore', ->
  reloadCarousel()
