
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

# -------------------
# ADD HIKER DIALOG

capitalize = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)

# ref http://stackoverflow.com/questions/46155/validate-email-address-in-javascript
validate_email = (email) -> 
  re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  re.test(email)

prefill_name_from_email = ->
  if $('#hiker_name').val() == ''
    name = $('#hiker_email').val()
    name = name.split(/[\s\.@_]+/)[0] 
    $('#hiker_name').val( capitalize(name) )

enable_hiker_name_input = (enable) ->
  if enable
    $('#invite_hiker_name_input').show()
    $('#invite_hiker_submit').attr('disabled', false)
  else
    $('#invite_hiker_name_input').hide()
    $('#invite_hiker_submit').attr('disabled', true)
  #end

email_input = ->
  email = $('#hiker_email').val()
  if validate_email(email)
    enable_hiker_name_input(true)
    prefill_name_from_email()
  else
    enable_hiker_name_input(false)
  #end

invite_hiker_dialog_submit_callbacks = ->
  $('#invite_hiker_form').on('ajax:success', (e, hiker, status, xhr) ->
      $('#invite_hiker_dialog').modal('hide')
      $('#trip_hikers_select optgroup[label="My Hikers"]').append('<option selected="selected" value="' + hiker.id + '">' + hiker.name + '</option>')
      vals = $('#trip_hikers_select').select2('val')
      vals[vals.length] = hiker.id
      $('#trip_hikers_select').select2('val', vals)
    ).on "ajax:error", (e, xhr, status, error) ->
      $('#invite_hiker_dialog').modal('hide')
      alert 'ERROR'

# $(document).on 'click', '#trip_invite_btn', ->
window.trip_invite_hiker = ->
  $('#trip_hikers_select').select2('close')
  $('#invite_hiker_dialog').modal('show')
  # alert 'Invite pressed'


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
      formatResult: format_hiker
      formatSelection: format_hiker
      escapeMarkup: (m) -> return m
      formatNoMatches: (term) -> 
        "<p class='padded'> Would you like to add a hiker who's not on this site yet?" +
        "<br><a class='btn btn-primary btn-xs pull-right' href='#' onclick='return window.trip_invite_hiker();'>Add Hiker</a></p>"
    )
    
    $('#enable_edit_mtns').click -> enable_multiselect('mtns', true) && false
    $('#enable_edit_hikers').click -> enable_multiselect('hikers', true) && false


    $('#add_mtns').click   -> $('#trip_mtns_select').select2('open') && false
    $('#add_hikers').click -> $('#trip_hikers_select').select2('open') && false

    # todo: integrate this search icon into vertical multiselect custom input
    $('#s2id_trip_hikers_select') # only for hikers select
      .find(".select2-search-field label").after("&nbsp; <span class='glyphicon glyphicon-search'></span>")

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

    # $('#edit_trip_form').areYouSure()

    # -------------------
    # ADD HIKER DIALOG

    $('#invite_hiker_dialog').on 'shown.bs.modal', ->
      enable_hiker_name_input(false)
      $('#hiker_email').on 'change', -> email_input()
      $('#hiker_email').on 'keyup', -> email_input()
      $('#hiker_email').on 'mouseout', -> email_input()

    invite_hiker_dialog_submit_callbacks()
  #end
