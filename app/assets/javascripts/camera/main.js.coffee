attachCameraHandler = ->
  if $('.camera-wrap').length
    $('.camera-wrap').camera(
      playPause: false,
    )

$(document).ready attachCameraHandler