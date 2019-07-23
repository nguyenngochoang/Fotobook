# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.feeds-container').on 'click', '.follow-button', (e)->
      console.log 'ok'
      user_id = $(this).parent('div').attr('data-id')
      if $(this).text() == '+ Follow'
        $(this).text 'Following'
        $(this).css 'background-image', 'linear-gradient(to right, #fe8c00 51%, #f83600 100%)'
        followees_id = $(this).attr 'id'
        Rails.ajax
          type: "POST"
          url: "/follows"
          # data: "data[param]="+user_id.toString()+"&data[mode]=follow&data[followees_id]="+followees_id.toString()
          data : new URLSearchParams({
            user_id: user_id
            mode: 'follow'
            followees_id: followees_id
          })
          dataType: 'script'
      else
        $(this).text '+ Follow'
        $(this).css 'backgroundImage', 'none'
        $(this).css 'backgroundColor', '#ffffff'
        followers_id = $(this).attr 'id'
        Rails.ajax
          type: "DELETE"
          url: "/follows/"+user_id.toString()
          # data: "data[param]="+user_id.toString()+"&data[mode]=unfollow&data[followers_id]="+followers_id.toString()
          data : new URLSearchParams({
            user_id: user_id
            mode: 'unfollow'
            followers_id: followers_id
          })
          dataType: 'script'
      return
  $('.btn-group').on 'click', ".discover-pa", ->
    $(".discover-pa").not(this).removeClass("active")
    $(this).addClass("active")
    if $(this).text().indexOf("Album") >= 0
      console.log("ALBUM!")
      Rails.ajax
        type: "GET"
        url: "/switch_photo_album_discover"
        # data: "show[mode]=album"
        data : new URLSearchParams({
          mode: 'album'
        })
        dataType: 'script'
    else if $(this).text().indexOf("Photo") >= 0
      console.log("PHOTO!")
      Rails.ajax
        type: "GET"
        url: "/switch_photo_album_discover"
        # data: "show[mode]=photo"
        data : new URLSearchParams({
          mode: 'photo'
        })
        dataType: 'script'