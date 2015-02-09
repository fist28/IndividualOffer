jQuery ->
  $(document).ready ->
    $('input[id^=offer_product_offers_attributes_], select[id^=offer_product_offers_attributes_]').on 'input', ->
      tr = $(this).parent().parent()
      url = tr.data('url')

      if $(this).hasClass('value')
        change_value = $(this).val()
        change_kind = tr.find('select.kind :selected').val()
      else
        change_value = tr.find('input.value').val()
        change_kind = $(this).val()

      $.ajax
        url: url
        type: 'POST'
        dataType: 'json'
        data :
          authenticity_token: document.getElementsByName('csrf-token')[0]. getAttribute("content")
          change_value: change_value
          change_kind: change_kind
        success: (data, status, response) ->
          tr.find('span.new_netto').text(data['new_netto'])
          tr.find('span.new_brutto').text(data['new_brutto'])
        error: ->
          tr.find('span.new_netto').text('-')
          tr.find('span.new_brutto').text('-')



