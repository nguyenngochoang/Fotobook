# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'turbolinks:load', ->

  $('.pa').on 'click', ->
    if $('.pa').hasClass 'active'
      $('.pa').removeClass 'active'
    if $(this).text() == "Album"
      $('.ab').removeClass('d-none')
      $('.single').addClass('d-none')
    else
      $('.ab').addClass('d-none')
      $('.single').removeClass('d-none')

    $(this).addClass 'active'

  # heart animation for love bttuon
  $('.HeartAnimation').click (e) ->
    $(this).toggleClass 'animate'
    # stopHere();
    return
  #end of heart animation
  # auto fade navbar
  lastScrollTop = 0
  $navbar = $('.navbar')
  $(window).scroll (event) ->
    st = $(this).scrollTop()
    if st > lastScrollTop
      # scroll down
      $navbar.stop().fadeOut()
    else
      # scroll up
      $navbar.stop().fadeIn()
    lastScrollTop = st
    return
  #end of auto fade navbar
  # navigations from this photo to another
  index = 0
  backgroundUrl = ""
  arr = []
  #array to load all images of feeds
  $('.innerImg').each ->
    arr.push $(this).attr('src')
    return


  $thisdiv = $('.hidethis:first')
  $(window).scroll ->
    if $(window).scrollTop() == $(document).height() - $(window).height()
      $thisdiv.show()
      $thisdiv = $thisdiv.next()
    return

  $('.userdiv').on 'click','.follow-button', (e)->
    if $(this).text() == '+ Follow'
      $(this).text 'Following'
      $(this).css 'backgroundImage', 'linear-gradient(to right, #fe8c00 51%, #f83600 100%)'
      followees_id=$(this).attr 'id'
      Rails.ajax
        type: "GET"
        url: "/follow_action"
        data: "data[param]="+id.toString()+"&data[mode]=follow&data[followees_id]="+followees_id.toString()
        dataType: 'script'
        success: () ->
          false
    else
      $(this).text '+ Follow'
      $(this).css 'backgroundImage', 'none'
      $(this).css 'backgroundColor', '#ffffff'
      followers_id=$(this).attr 'id'
      Rails.ajax
        type: "GET"
        url: "/follow_action"
        data: "data[mode]=unfollow&data[followers_id]="+followers_id.toString()
        dataType: 'script'
        success: () ->
          false
    return

  $('.profile-content').on 'click','.follow-button', (e)->
    if $(this).text() == '+ Follow'
      $(this).text 'Following'
      $(this).css 'backgroundImage', 'linear-gradient(to right, #fe8c00 51%, #f83600 100%)'
      followees_id=$(this).attr 'id'
      Rails.ajax
        type: "GET"
        url: "/follow_action"
        data: "data[mode]=follow&data[followees_id]="+followees_id.toString()
        dataType: 'script'
        success: () ->
          false
    else
      $(this).text '+ Follow'
      $(this).css 'backgroundImage', 'none'
      $(this).css 'backgroundColor', '#ffffff'
      followers_id=$(this).attr 'id'
      Rails.ajax
        type: "GET"
        url: "/follow_action"
        data: "data[param]="+id.toString()+"&data[mode]=unfollow&data[followers_id]="+followers_id.toString()
        dataType: 'script'
        success: () ->
          false
    return

  $('.carousel').carousel ->
    interval: false
    return

  $(document).on 'click','.carousel-control-next', ->
    $('.modal-title').text $('.carousel-item.active').data 'title'
    $('.modal-footer').text $('.carousel-item.active').data 'description'
    return

  $('.profile-content').on 'mouseover','.thumbnail', ->
    $(this).find('.photonums').stop().fadeIn 500
    return
  $('.profile-content').on 'mouseleave','.thumbnail', ->
    $(this).find('.photonums').stop().fadeOut 500
    return
  id = $('.us.rounded-circle').attr('data-id')
  $usertab =$('.us.usertab')
  $usertab.on 'click', ->
    $(this).addClass 'font-weight-bolder'
    $(this).removeClass 'text-black-50'
    $usertab.not(this).addClass 'text-black-50'
    $usertab.not(this).removeClass 'font-weight-bolder'
    if $(this).text().indexOf("Albums") >= 0
      Rails.ajax
        type: "GET"
        url: "/task"
        data: "data[param]="+id.toString()+"&data[mode]=albums"
        dataType: 'script'
        success: () ->
          false
    else if $(this).text().indexOf("Photos") >= 0
      Rails.ajax
        type: "GET"
        url: "/task"
        data: "data[param]="+id.toString()+"&data[mode]=photos"
        dataType: 'script'
        success: () ->
          false
    else if $(this).text().indexOf("Followings") >=0
      Rails.ajax
        type: "GET"
        url: "/follow"
        data: "data[param]="+id.toString()+"&data[mode]=followings"
        dataType: 'script'
        success: () ->
          false
    else
       Rails.ajax
        type: "GET"
        url: "/follow"
        data: "data[param]="+id.toString()+"&data[mode]=followers"
        dataType: 'script'
        success: () ->
          false
    return
  $('.profile-content').on 'click','.us.thumbnail',->
    gallery_id = $(this).attr("id")
    console.log(gallery_id)
    mode="";
    if $(this).attr("class").indexOf("photo") >= 0
      mode="photos"
    else
      mode="albums"

    Rails.ajax
      type: "GET"
      url: "/currentgallery"
      data: "data[param]="+id.toString()+"&data[mode]="+mode+"&data[gallery_id]="+gallery_id.toString()
      dataType: 'script'
      success: () ->
          false
    jQuery('.us.modal').modal 'toggle'
    return

  $('.us.ava-change.text-center').on 'click',->
    $('#uploadava-btn').click();
    return

  $('#basic').validate({
    rules: {
      "user[first_name]":{
        required: true,
        maxlength: 25
      }
      "user[last_name]":{
        required: true,
        maxlength: 25
      }
      "user[email]": {
        required: true,
        email: true,
        maxlength:255
      }
      "user[avatar]":{
        accept: "image/*",
        extension: "jpg|png|jpeg"
      }
    },

    errorPlacement: (error, element)->
      error.appendTo( element.parent("div").parent("div").next("div").find("span"));

  })

  $('#password').validate({
    rules: {
      "user[password]":{
        required: true,
        maxlength: 64,
        minlength:6
      }
      "user[password_confirm]":{
        required: true,
        maxlength: 64,
        minlength:6,
        equalTo: "#newpassword"
      }
    },
    messages:{
      "user[password_confirm]":{
        equalTo: "Password does not match!"
      }
    },
    errorPlacement: (error, element)->
      error.appendTo( element.parent("div").parent("div").next("div").find("span"));

  })

  $('submit-btn').on 'click',(e)->
    e.preventDefault()
    if $(this).attr('id')=="basic-submit"
      $('#basic').submit()
    else
      $('#password').submit()
    return

  $('#uploadava-btn').on 'change', (e)->
    input = e.target;
    extension=input.files[0].type
    validExtension = ['image/jpg','image/png','image/jpeg']
    if (input.files && input.files[0])
      if validExtension.includes(extension)
        file = input.files[0];
        reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = (e)->
          $('.ava-edit').attr('src',reader.result)
      else
        alert("Unsupported file type")
      return
    return
#  -------------------------------- this part is for upload photo field ----------------------------
  $('.photo-upload-preview').addClass('dragging').removeClass 'dragging'
  $('.photo-upload-preview').on('dragover', ->
    $('.photo-upload-preview').addClass 'dragging'
    return
  ).on('dragleave', ->
    $('.photo-upload-preview').removeClass 'dragging'
    return
  ).on 'drop', (e) ->
    $('.photo-upload-preview').removeClass 'dragging hasImage'
    if e.originalEvent
      file = e.originalEvent.dataTransfer.files[0]
      console.log file
      reader = new FileReader
      #attach event handlers here...
      reader.readAsDataURL file

      reader.onload = (e) ->
        console.log reader.result
        $('.photo-upload-preview').css('background-image', 'url(' + reader.result + ')').addClass 'hasImage'
        return

    return
  window.addEventListener 'dragover', ((e) ->
    e = e or event
    e.preventDefault()
    return
  ), false
  window.addEventListener 'drop', ((e) ->
    e = e or event
    e.preventDefault()
    return
  ), false

  $('#newphoto').validate({
    rules: {
      "photo[attached_image]":{
        accept: "image/*",
        extension: "jpg|png|jpeg"
      }
      "photo[title]" :{
        required:true,
        maxlength:140,
      }
      "photo[description]" :{
        required:true,
        maxlength:300,
      }
      "photo[sharing_mode]" :{
        required:true,
      }
    },
    messages: {
      "photo[attached_image]":{
        accept: "Please attaches only image please!",
        extension: "We just support jpg,png,jpeg format."
      }
      "photo[title]":{
        required:'Please give me a title :(',
        maxlength:"140 characters are allowed",
      }
      "photo[description]":{
        required:"Please give me a description..",
        maxlength:"300 characters are allowed",
      }
      "photo[sharing_mode]" :{
        required:"Pick a mode please..."
      }
    },
    errorPlacement: (error, element) ->
      if element.attr("name") == "photo[attached_image]"
       $('#add-symbol').text(error.text())
       $('#add-symbol').css('font-size','14px')
       $('#add-symbol').addClass('font-weight-bolder')
       $('#add-symbol').css('width','100%')
       $('#add-symbol').css('color', 'rgba(255, 0, 0, 0.5)')
      else
        error.appendTo(element.parent("div").next("div").find("span"))
  })

  $('.dashes.text-center').on 'click', (e) ->
    $('#uploadphoto-btn').click();
    return

  $('#uploadphoto-btn').on 'change', (e)->
    input = e.target;
    extension=input.files[0].type
    validExtension = ['image/jpg','image/png','image/jpeg']
    if (input.files && input.files[0])
      if validExtension.includes(extension)
        file = input.files[0];
        reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = (e) ->
          console.log input.files[0].type
          $('.photo-upload-preview').css('background-image', 'url(' + reader.result + ')').addClass 'hasImage'
      else
        alert("Unsupported file type")
        $('.photo-upload-preview').css('backgroundImage', 'none')
        $('.dashes').css('border','5px dashed rgba(255, 0, 0, .5)')
        $('.photo-upload-preview').css('box-shadow','0 5px 8px rgba(red, 0.35)')
        $('#add-symbol').css('color','red')

    return

#  -------------------------------- end of upload photo field ----------------------------

return



