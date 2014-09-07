
enable_multiselect = (name, enable) ->
  $('#trip_'+name+'_select').select2('enable', enable)
  if enable 
    $('#add_'+name).show() 
    $('#enable_edit_'+name).hide()
    $('#s2id_trip_'+name+'_select .select2-search-field').show()
  else 
    $('#add_'+name).hide()
    $('#enable_edit_'+name).show()
    $('#s2id_trip_'+name+'_select .select2-search-field').hide()


format_mtn = (state) ->
  return "<div class='selection_item'>" + state.text + "</div>";

format_hiker = (state) ->
  return "<div class='selection_item'><img class='chip', src='" + asset_path('jsl65.jpg') + "'/>" + state.text + '</div>';



# -------------------

$ ->

  # (only on edit trip page)
  if $('#trip_mtns_select').length != 0
    $('#trip_mtns_select').select2(
      formatResult: format_mtn
      formatSelection: format_mtn
      escapeMarkup: (m) -> return m
    )

    $('#trip_hikers_select').select2(
      # formatResult: format_hiker
      # formatSelection: format_hiker
      escapeMarkup: (m) -> return m
      formatNoMatches: (term) -> 
        "<p class='padded'>Name not found. Would you like to add a hiker who's not on this site yet?" +
        "<br><a class='btn btn-primary btn-xs pull-right' href='#' onclick='return window.trip_invite_hiker();'>Add Hiker</a></p>"
    )
    
    $('#enable_edit_mtns').click -> enable_multiselect('mtns', true) && false
    $('#enable_edit_hikers').click -> enable_multiselect('hikers', true) && false


    $('#add_mtns').click   -> $('#trip_mtns_select').select2('open') && false
    $('#add_hikers').click -> $('#trip_hikers_select').select2('open') && false

    # todo: integrate this search icon into vertical multiselect custom input
    $('#s2id_trip_hikers_select') # only for hikers select
      .find(".select2-search-field label").after("&nbsp; <span class='glyphicon glyphicon-search'></span>")
    $('#s2id_autogen2').attr('placeholder', 'enter hiker to find or add...').attr('style','width:200px')


    $('.input-group.date').datepicker(
      format: "yyyy-mm-dd" # date format must match the database date format
      todayHighlight: true
      todayBtn: 'linked'
      autoclose: true
    )

    # Initial state 
    # disable mountains if not empty
    is_empty =  ($('#trip_mtns_select').val() == null || $('#trip_mtns_select').val().length == 0)
    enable_multiselect('mtns', is_empty)
    # disable hikers if not new
    is_new_record = $('form#edit_trip_form').hasClass('new_record')
    enable_multiselect('hikers', is_new_record)

    $('#trip_photos.attachinary-input').attachinary()

    # froala editor - wysiwyg
    $('#trip_journal').editable
      inlineMode: false
      borderColor: '#ccc'
      spellcheck: true
      contentChangedCallback: ->
        $('#edit_trip_form').addClass('dirty')

      # The available buttons are: "bold", "italic", "underline", "strikeThrough", "fontSize", "color", 'blockStyle' "formatBlock", "align", "insertOrderedList", "insertUnorderedList", "outdent", "indent", "selectAll", "createLink", "insertImage", "insertVideo", "undo", "redo", "html", "save". 'insertHorizontalRule'
      # buttons: ['bold', 'italic', 'underline', 'fontSize', 'color', 'sep', 'formatBlock', 'align', 'insertOrderedList', 'insertUnorderedList', 'outdent', 'indent', 'sep', 'createLink', 'insertHorizontalRule', 'html', 'sep', 'undo', 'redo']
      buttons: ['bold', 'italic', 'color', 'sep', 'formatBlock', 'align', 'insertOrderedList', 'insertUnorderedList', 'sep', 'createLink', 'insertHorizontalRule', 'html', 'sep', 'undo', 'redo']

      # imageUploadUrl: $('#invite_hiker_form').attr('action') + '/image' # maybe must save to enable the journal
      # #imageUploadParams:
      # # one idea is to have the callback add the image to a hidden field (images[]) 
      # # if we work with/like attachinary, when wysiwyg inserts image, the file gets uploaded to cloudinart

    $('#edit_trip_form').areYouSure()


    # submit
    $('#edit_trip_form input[type=submit]').click ->
      hiker_ids = $('#trip_hikers_select').val()
      if hiker_ids == null || hiker_ids.length == 0
        $('#deleting_trip_dialog').modal('show')
        false
      else if jQuery.inArray( gon.current_hiker_id.toString(), hiker_ids) == -1
        $('#remove_self_dialog').modal('show')
        false
    # submit it when ok
    $('#remove_self_dialog .cancel, #deleting_trip_dialog .cancel').click -> 
      # add me back in
      hiker_ids = $('#trip_hikers_select').val()
      hiker_ids.push gon.current_hiker_id.toString()
      $('#trip_hikers_select').select2('val', hiker_ids)
      $('#remove_self_dialog').modal('hide')
      false

    $('#remove_self_dialog .confirm, #deleting_trip_dialog .confirm').click -> 
      $('#edit_trip_form').append("<input type='hidden' name='delete' value='true' />")
      $('#edit_trip_form').submit()

        

    $('#remove_title_image').click ->
      $('input#trip_title_image_input').val('')
      $('#title_image').html("<img class='img-thumbnail' data-src='holder.js/300x200/text:Title Image'>")
      Holder.run({use_canvas:true})
      $('#remove_title_image').hide()


  #end
