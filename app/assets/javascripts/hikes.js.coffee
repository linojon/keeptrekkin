
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
  return "<div class='selection_item'><img class='chip', src='/assets/jsl65.jpg'/>" + state.text + '</div>';


$ ->

  $('#enable_edit_mtns').click -> enable_multiselect('mtns', true) && false
  $('#enable_edit_hikers').click -> enable_multiselect('hikers', true) && false


  $('#add_mtns').click   -> $('#trip_mtns_select').select2('open') && false
  $('#add_hikers').click -> $('#trip_hikers_select').select2('open') && false

  $('#trip_mtns_select').select2(
    formatResult: format_mtn
    formatSelection: format_mtn
    escapeMarkup: (m) -> return m
  )

  $('#trip_hikers_select').select2(
    formatResult: format_hiker
    formatSelection: format_hiker
    escapeMarkup: (m) -> return m
    formatNoMatches: (term) -> "No matches found<br><a class='btn btn-primary'>Invite</a>"
  )
  
  $('.input-group.date').datepicker(
    format: "yyyy-mm-dd" # date format must match the database date format
    todayHighlight: true
    todayBtn: 'linked'
    autoclose: true
  )

  # todo: only if editing
  enable_multiselect('mtns', false)
  enable_multiselect('hikers', false)


