jQuery ->
  $('a[rel="show_comments"]').click ->
    $(this).parent('p').find('img.loader').show
    $('div#modal div.modal-body').html("<p><img src='/assets/loader.gif' /> <b> Loading, please wait...</b></p>")
    _this = $(this)
    $.ajax
      type: 'GET',
      url: '/album/'+$(this).data('id')+'/fetch_comments',
      dataType: 'json',
      success: (data) ->
        $('#progress-search').hide()
        inner_html = "<div class='comments'>"
        list_length = data.length-1
        for i in [0..list_length]
          inner_html += "<div class='comment'><p class='author'>" + data[i].username + "</p>"
          inner_html += "<p class='created_at'>" + data[i].created_at + "</p>"
          inner_html += "<p class='text'>" + data[i].text + "</p></div>"
        inner_html += '</div>'
        $('div#modal div.modal-body').html(inner_html)
        _this.parent('p').find('img.loader').hide()
      error: ->
        _this.parent('p').find('img.loader').hide
        alert('Oops, error has occurred!')