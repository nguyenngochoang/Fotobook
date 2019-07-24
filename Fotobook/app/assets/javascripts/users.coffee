$(document).on 'turbolinks:load', ->

  # auto fade navbar
  lastScrollTop = 0
  $navbar = $('.navbar')
  $(window).scroll (event) ->
    st = $(this).scrollTop()
    if st > lastScrollTop
      $navbar.stop().fadeOut()  # scroll down
    else
      $navbar.stop().fadeIn()   # scroll up
    lastScrollTop = st
    return
  #end of auto fade navbar

  # navigations from this photo to another
  $thisdiv = $('.hidethis:first')
  $(window).scroll ->
    if $(window).scrollTop() == $(document).height() - $(window).height()
      $thisdiv.show()
      $thisdiv = $thisdiv.next()
    return

  user_id = $('.useravatar').attr('data-id')
  $('.userdiv').on 'click','.follow-button', (e)->
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

  $('.profile-content').on 'click','.follow-button', (e)->
    if $(this).text() == '+ Follow'
      $(this).text 'Following'
      $(this).css 'backgroundImage', 'linear-gradient(to right, #fe8c00 51%, #f83600 100%)'
      followees_id = $(this).attr 'id'
      Rails.ajax
        type: "POST"
        url: "/follows"
        # data: "data[followees_id]="+followees_id.toString()
        data : new URLSearchParams({
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
        # data: "data[param]="+user_id.toString()+"&data[followers_id]="+followers_id.toString()
        data : new URLSearchParams({
          followers_id: followers_id
        })
        dataType: 'script'
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

  $usertab = $('.us.usertab')
  $usertab.on 'click', ->
    $(this).addClass 'font-weight-bolder'
    $(this).removeClass 'text-black-50'
    $usertab.not(this).addClass 'text-black-50'
    $usertab.not(this).removeClass 'font-weight-bolder'
    if $(this).text().indexOf("Albums") >= 0
      Rails.ajax
        type: "GET"
        url: '/albums'
        # data: "data[param]="+user_id.toString()
        data : new URLSearchParams({
          user_id: user_id
        })
        dataType: 'script'
        success: () ->
          console.log 'ok'
    else if $(this).text().indexOf("Photos") >= 0
      Rails.ajax
        type: "GET"
        url: "/photos"
        # data: "data[param]="+user_id.toString()
        data : new URLSearchParams({
          user_id: user_id
        })
        dataType: 'script'

    else if $(this).text().indexOf("Followings") >=0
      Rails.ajax
        type: "GET"
        url: "/follows"
        # data: "data[param]="+user_id.toString()+"&data[mode]=followings"
        data : new URLSearchParams({
          user_id: user_id
          mode: 'followings'
        })
        dataType: 'script'
    else
       Rails.ajax
        type: "GET"
        url: "/follows"
        # data: "data[param]="+user_id.toString()+"&data[mode]=followers"
        data : new URLSearchParams({
          user_id: user_id
          mode: 'followers'
        })
        dataType: 'script'
    return
  $('.profile-content').on 'click', '.us.thumbnail img', ->
    gallery_id = $(this).parent("div").attr("id")
    console.log(gallery_id)
    mode="";
    if $(this).parent("div").attr("class").indexOf("photo") >= 0
      mode = "photos"
    else
      mode = "albums"

    Rails.ajax
      type: "GET"
      url: "/currentgallery"
      # data: "data[mode]="+mode+"&data[gallery_id]="+gallery_id.toString()
      data : new URLSearchParams({
        mode: mode
        gallery_id: gallery_id
      }).toString()
      dataType: 'script'
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

  $('submit-btn').on 'click', (e)->
    e.preventDefault()
    if $(this).attr('id') == "basic-submit"
      $('#basic').submit()
    else if $(this).attr('id') == "password-sumbit"
      $('#password').submit()
    else if $(this).attr('id') == "photo-sumbit"
      $('#newphoto').submit()
    else
      $('#newalbum').submit()
    return

  $('#uploadava-btn').on 'change', (e)->
    input = e.target;
    extension = input.files[0].type
    validExtension = ['image/jpg','image/png','image/jpeg']
    if (input.files && input.files[0])
      if validExtension.includes(extension)
        file = input.files[0];
        console.log file.size
        if file.size > 5242880
          alert("File size must under 5MB")
        else
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
    $('.photo-upload-preview').removeClass 'dragging has-image'
    if e.originalEvent
      file = e.originalEvent.dataTransfer.files[0]
      console.log file
      reader = new FileReader
      #attach event handlers here...
      reader.readAsDataURL file
      reader.onload = (e) ->
        console.log reader.result
        $('.photo-upload-preview').css('background-image', 'url(' + reader.result + ')').addClass 'has-image'
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
        extension: "jpg|png|jpeg|gif",
        required: ->
          if $('.photo-upload-preview').hasClass('has-image')
            return false
          else
            return true
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
        required:true
      }
    },
    messages: {
      "photo[attached_image]":{
        accept: "Please attaches only image please!",
        extension: "We just support jpg,png,jpeg format.",
        required: "No photo was chosen..",
        filesize: "File size must be under 5MB"
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
        $('#add-symbol').css('font-size', '14px')
        $('#add-symbol').addClass('font-weight-bolder')
        $('#add-symbol').css('width', '100%')
        $('#add-symbol').css('color', 'rgba(255, 0, 0, 0.5)')
      else
        error.appendTo(element.parent("div").next("div").find("span"))
  })

  $('#newalbum').validate({
    rules: {
      "album[attached_image][]":{
        accept: "image/*",
        extension: "jpg|png|jpeg|gif",
        required: ->
          if $('.photo-upload-preview').hasClass('has-images')
            return false
          else
            return true
      }
      "album[name]" :{
        required:true,
        maxlength:140,
      }
      "album[description]" :{
        required:true,
        maxlength:300,
      }
      "album[sharing_mode]" :{
        required:true
      }
    },
    messages: {
      "album[attached_image][]":{
        accept: "Please attaches only image please!",
        extension: "We just support jpg, png, jpeg format.",
        required: "No photo was chosen..",
        filesize: "File size must be under 5MB"
      }
      "album[title]":{
        required:'Please give me a title :(',
        maxlength:"140 characters are allowed",
      }
      "album[description]":{
        required:"Please give me a description..",
        maxlength:"300 characters are allowed",
      }
      "album[sharing_mode]" :{
        required:"Pick a mode please..."
      }
    },
    errorPlacement: (error, element) ->
      if element.attr("name") == "photo[attached_image]"
        $('#add-symbol').text(error.text())
        $('#add-symbol').css('font-size', '14px')
        $('#add-symbol').addClass('font-weight-bolder')
        $('#add-symbol').css('width', '100%')
        $('#add-symbol').css('color', 'rgba(255, 0, 0, 0.5)')
      else
        error.appendTo(element.parent("div").next("div").find("span"))
  })

  $('.dashes.text-center').on 'click', (e) ->
    $('#uploadphoto-btn').click();
    return

  $('#uploadphoto-btn').on 'change', (e)->
    input = e.target
    validExtension = ['image/jpg', 'image/png', 'image/jpeg']
    reader = new FileReader()
    files = input.files

    if files.length == 1
      if files[0].size <= 5242880
        extension = input.files[0].type
        if (input.files && input.files[0])
          if validExtension.includes(extension)
              reader.readAsDataURL(files[0])
              reader.onload = (e) ->
                $('#cancel-symbol').removeClass('invisible')
                $('.photo-upload-preview').css('background-image', 'url(' + reader.result + ')').addClass 'has-image'
          else
            alert("Unsupported file type")
            $('.photo-upload-preview').css('background-image', 'none')
            $('.dashes').css('border','5px dashed rgba(255, 0, 0, .5)')
            $('.photo-upload-preview').css('box-shadow','0 5px 8px rgba(red, 0.35)')
            $('#add-symbol').css('color', 'red')
      else
        $(this).parent("div").next("div").find("span").text("File size must be under 5MB")
    else
      readFile = (index) ->
        if index >= files.length
          $(".upload-row").after("<button type=\"button\" class=\"btn btn-danger reset-btn my-4\">Reset</button>")
          return
        else
          get_file = files[index];
          if get_file.size <= 5242880
            reader.onload = (e) ->
              check_type = get_file.type
              if validExtension.includes(check_type)
                $(".preview-row").append("
                  <div class=\"photo-upload-preview mt-2\">
                    <img src=\""+reader.result+"\" class=\"h-100 img-fluid  \">
                  </div>")

              readFile(index+1)
            reader.readAsDataURL(get_file);
          else
            $(this).parent("div").next("div").find("span").text("File size must be under 5MB")
            return
      readFile(0)

  $('#cancel-symbol').click ->
    if $(this).parent().hasClass('photo-upload-preview')
      $('.photo-upload-preview').css('backgroundImage', 'none').removeClass 'has-image'
      $('#uploadphoto-btn').val('')
      $('.dashes').css('border', '5px dashed rgba(black, 0, 0, .5)')
      $('.photo-upload-preview').css('box-shadow','0 5px 8px rgba(black, 0.35)')
      $('#add-symbol').css('color', 'black')
      $(this).addClass('invisible')
  $(window).on 'popstate', ->
    location.reload(true)


  $('.feeds-container').on 'click', '.inner-img' ,->
    gallery_id = $(this).parent("div").attr("data-id")
    id = $(this).parent("div").attr("data-param")
    console.log(gallery_id)
    mode="";
    if $(this).parent("div").attr("class").indexOf("photo") >= 0
      mode="photos"
    else
      mode="albums"
    Rails.ajax
      type: "GET"
      url: "/homegallery"
      data: new URLSearchParams({
        id: id
        mode: mode
        gallery_id: gallery_id
      }).toString()
      dataType: 'script'
    jQuery('.us.modal').modal 'toggle'
    return
  $('.btn-group').on 'click',".pa", ->
    $(".pa").not(this).removeClass("active")
    $(this).addClass("active")
    if $(this).text().indexOf("Album") >= 0
      console.log("ALBUM!")
      Rails.ajax
        type: "GET"
        url: "/switch_photo_album"
        # data: byebug"show[mode]=album"
        data:new URLSearchParams({mode: 'album'}).toString()
        dataType: 'script'
    else if $(this).text().indexOf("Photo") >= 0
      console.log("PHOTO!")
      Rails.ajax
        type: "GET"
        url: "/switch_photo_album"
        # data: "show[mode]=photo"
        data:new URLSearchParams({mode: 'photo'}).toString()
        dataType: 'script'
  # heart animation for love bttuon
  $('.feeds-container').on 'click','.heart-animation', (e) ->
    gallery_id = $(this).parent("div").attr("data-id")
    id = $(this).parent("div").attr("data-param")
    if $(this).parent("div").hasClass('photo')
      if $(this).hasClass 'liked' #unlike post
        $(this).removeClass("liked")
        $(this).removeClass 'animate'
        Rails.ajax
          type: "PATCH"
          url: "/photo_like/"+gallery_id.toString()
          data: new URLSearchParams({
            liker_id: id
            act: 'unlike'
          }).toString()
          dataType: 'script'
      else #like post
        $(this).addClass 'animate'
        $(this).addClass 'liked'
        console.log 'ok'
        Rails.ajax
          type: "PATCH"
          url: "/photo_like/"+gallery_id.toString()
          # data: "likes[liker_id]="+id.toString()+"&likes[mode]=photo"+"&likes[action]=like"
          data: new URLSearchParams({
            liker_id: id
            act: 'like'
          }).toString()
          dataType: 'script'
    else #album like and unlike
      if $(this).hasClass 'liked' #unlike post
        $(this).removeClass("liked")
        $(this).removeClass 'animate'
        Rails.ajax
          type: "PATCH"
          url: "/album_like/"+gallery_id.toString()
          # data: "likes[liker_id]="+id.toString()+"&likes[action]=unlike"
          data: new URLSearchParams({
            liker_id: id
            act: 'unlike'
          }).toString()
          dataType: 'script'
      else #like post
        $(this).addClass 'animate'
        $(this).addClass 'liked'
        console.log 'ok'
        Rails.ajax
          type: "PATCH"
          url: "/album_like/"+gallery_id.toString()
          # data: "likes[liker_id]="+id.toString()+"&likes[action]=like"
          data: new URLSearchParams({
            liker_id: id
            act: 'like'
          }).toString()
          dataType: 'script'

    return
  #end of heart animation
  $('.cancel-symbol-thumbnail').on 'click', ->
    $get_parent = $(this).parent("div").parent("div")
    img_id = $get_parent.attr('id')
    console.log img_id
    album_id = $get_parent.parent("div").attr('id')
    console.log album_id
    Rails.ajax
      type: "PATCH"
      url: "/remove_img/"
      # data: "remove[img_id]="+img_id.toString()+"&remove[album_id]="+album_id.toString()
      data: new URLSearchParams({
        img_id: img_id
        album_id: album_id
      }).toString()
      dataType: 'script'
    $get_parent.remove()

  $('#newalbum').on 'click', '.reset-btn', ->
    $('#uploadphoto-btn').val('');
    $('.preview-row').html('')
    $(this).remove()


#  -------------------------------- end of upload photo field ----------------------------
return



