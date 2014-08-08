$ ->
  $('.profile_image_thumb a[data-profile-image]').click (event) ->
    event.preventDefault()
    fileId  = $(event.target).data('profile-image')
    fileUrl = $(event.target).data('profile-image-url')
    $('input#hiker_profile_image_input').val(fileId)
    $('#profile_image').html("<img src='" + fileUrl + "' width='300' height='200' />")
