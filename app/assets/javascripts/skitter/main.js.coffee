attachSkitterHandler = ->
  $('.box_skitter').skitter(
    controls: false,
    controls_position: 'center',
    dots: true,
    numbers: false,
    numbers_align: 'center',
    theme: 'minimalist',
    with_animations: ['hideBars', 'downBars', 'upBars', 'fade', 'fadeFour', 'blind', 'directionRight'],
  )

$(document).ready attachSkitterHandler
$(document).on 'page:load', attachSkitterHandler
  