$(document).on 'turbolinks:load', ->
  $(window).on 'scroll', ->
    if $('#infinite-scrolling').size() > 0
      more_posts_url = $('.pagination .page-next').attr('href')
      mode = $('#infinite-scrolling').attr("data-mode")
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 200
        $('.pagination').html('<img src="https://i.imgur.com/uMQxKUN.gif" alt="Loading..." title="Loading..." />')
        path = /\w+/.exec(window.location.pathname)
        loadpath = if path == null then "feeds" else path
        Rails.ajax
          type: "GET"
          url: "/load_#{loadpath}"
          # data: "page=#{/\d+/.exec(more_posts_url)}&request[mode]=#{mode}"
          data: new URLSearchParams({
            page: /\d+/.exec(more_posts_url)
            mode: mode
          }).toString()
      return
    return