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
    $('#invite_hiker_dialog').on 'shown.bs.modal', ->
      enable_hiker_name_input(false)
      $('#hiker_email').on 'change', -> email_input()
      $('#hiker_email').on 'keyup', -> email_input()
      $('#hiker_email').on 'mouseout', -> email_input()

    invite_hiker_dialog_submit_callbacks()

