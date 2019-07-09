# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->

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

  # $('.img').on 'click', ->
  #   jQuery.noConflict()
  #   backgroundUrl = $(this).children('img').attr('src')
  #   backgroundUrl = backgroundUrl.replace('url(', '').replace(')', '').replace(/\"/gi, '')
  #   $('#modal-body-image').attr 'src', backgroundUrl
  #   text = $(this).next().find('.row-text').children('p').text()
  #   title = $(this).next().find('.row-text').children('h5').text()
  #   $('.modal-title').text title
  #   $('.modal-footer > p').text text
  #   jQuery('.modal').modal 'toggle'
  #   index = arr.indexOf(backgroundUrl)
  #   return

  # $('.next').on 'click', ->
  #   if index < arr.length - 1
  #     index = index + 1
  #     backgroundUrl = arr[index]
  #     $('#modal-body-image').attr 'src', backgroundUrl
  #     $selectthis = $('[src=' + '\'' + backgroundUrl + '\'' + ']').parent().next()
  #     text = $selectthis.find('.row-text').children('p').text()
  #     title = $selectthis.find('.row-text').children('h5').text()
  #     $('.modal-title').text title
  #     $('.modal-footer > p').text text
  #   return
  # $('.prev').on 'click', ->
  #   if index > 0
  #     index = index - 1
  #     backgroundUrl = arr[index]
  #     $('#modal-body-image').attr 'src', backgroundUrl
  #     $selectthis = $('[src=' + '\'' + backgroundUrl + '\'' + ']').parent().next()
  #     text = $selectthis.find('.row-text').children('p').text()
  #     title = $selectthis.find('.row-text').children('h5').text()
  #     $('.modal-title').text title
  #     $('.modal-footer > p').text text
  #   return
  # end of navigations from this photo to another
  $thisdiv = $('.hidethis:first')
  $(window).scroll ->
    if $(window).scrollTop() == $(document).height() - $(window).height()
      $thisdiv.show()
      $thisdiv = $thisdiv.next()
    return

  $('.mid').on 'click','.follow-button', (e)->
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



