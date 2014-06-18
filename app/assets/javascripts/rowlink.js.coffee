# note, turbolinks interferes with this
$ ->
  $('table .rowlink tr').click ->
    window.location = $(this).data('link')
