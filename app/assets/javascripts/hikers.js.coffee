$ ->
  $('.profile_image_thumb a[data-profile-image]').click (event) ->
    event.preventDefault()
    fileId  = $(event.target).data('profile-image')
    fileUrl = $(event.target).data('profile-image-url')
    $('input#hiker_profile_image_input').val(fileId)
    $('#profile_image').html("<img src='" + fileUrl + "' width='300' height='200' />")

  $('#use_facebook_image').click (event) ->
    $('input#hiker_profile_image_input').val('')
    $('#profile_image').html("<img class='img-thumbnail' data-src='holder.js/300x200/text:Profile Image'>")
    Holder.run({use_canvas:true})

  $('.chart').easyPieChart()