attachJqueryFileUploadHandler = ->
  $('#fileupload').fileupload(
    url: '/admin/photos'
  )

$(document).ready attachJqueryFileUploadHandler