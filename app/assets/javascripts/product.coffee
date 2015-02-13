ready = ->
  if $("select[name='product[unit]'] option:selected")[0].value != 'package'
    $('[id$=_container_unit]').hide()
  $("select[name='product[unit]']").change (e) ->
    selected = e.target.value.toLowerCase()
    $('[id$=_container_unit]').hide()
    $('#'+selected+'_container_unit').show()


$(document).ready(ready)
$(document).on('page:load', ready)