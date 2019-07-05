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

  $('.img').on 'click', ->
    jQuery.noConflict()
    backgroundUrl = $(this).children('img').attr('src')
    backgroundUrl = backgroundUrl.replace('url(', '').replace(')', '').replace(/\"/gi, '')
    $('#modal-body-image').attr 'src', backgroundUrl
    text = $(this).next().find('.row-text').children('p').text()
    title = $(this).next().find('.row-text').children('h5').text()
    $('.modal-title').text title
    $('.modal-footer > p').text text
    jQuery('.modal').modal 'toggle'
    index = arr.indexOf(backgroundUrl)
    return

  $('.next').on 'click', ->
    if index < arr.length - 1
      index = index + 1
      backgroundUrl = arr[index]
      $('#modal-body-image').attr 'src', backgroundUrl
      $selectthis = $('[src=' + '\'' + backgroundUrl + '\'' + ']').parent().next()
      text = $selectthis.find('.row-text').children('p').text()
      title = $selectthis.find('.row-text').children('h5').text()
      $('.modal-title').text title
      $('.modal-footer > p').text text
    return
  $('.prev').on 'click', ->
    if index > 0
      index = index - 1
      backgroundUrl = arr[index]
      $('#modal-body-image').attr 'src', backgroundUrl
      $selectthis = $('[src=' + '\'' + backgroundUrl + '\'' + ']').parent().next()
      text = $selectthis.find('.row-text').children('p').text()
      title = $selectthis.find('.row-text').children('h5').text()
      $('.modal-title').text title
      $('.modal-footer > p').text text
    return
  # end of navigations from this photo to another
  $thisdiv = $('.hidethis:first')
  $(window).scroll ->
    if $(window).scrollTop() == $(document).height() - $(window).height()
      $thisdiv.show()
      $thisdiv = $thisdiv.next()
    return

  $('.follow-button').each ->
    if $(this).text() == '+ Follow'
      $(this).text 'Following'
      $(this).css 'backgroundImage', 'linear-gradient(to right, #fe8c00 51%, #f83600 100%)'
    else
      $(this).text '+ Follow'
      $(this).css 'backgroundImage', ''
      $(this).css 'backgroundColor', '#ffffff'
    return
  $('.follow-button').on 'click', ->
    if $(this).text() == '+ Follow'
      $(this).text 'Following'
      $(this).css 'backgroundImage', 'linear-gradient(to right, #fe8c00 51%, #f83600 100%)'
    else
      $(this).text '+ Follow'
      $(this).css 'backgroundImage', ''
      $(this).css 'backgroundColor', '#ffffff'
    return



  $('.thumbnail').on 'mouseover', ->
    $(this).find('.photonums').stop().fadeIn 500
    return
  $('.thumbnail').on 'mouseleave', ->
    $(this).find('.photonums').stop().fadeOut 500
    return

  $usertab = $('.us.usertab')
  $usertab.on 'click', ->
    $(this).addClass 'font-weight-bolder'
    $(this).removeClass 'text-black-50'
    $usertab.not(this).addClass 'text-black-50'
    $usertab.not(this).removeClass 'font-weight-bolder'
    if $(this).text().indexOf("Album") >= 0
      $('.us.ab').removeClass('d-none')
      $('.us.tab:not(".us.ab")').addClass('d-none')
    else if $(this).text().indexOf("Photos") >= 0
      $('.us.tab:not(".us.photo")').addClass('d-none')
      $('.us.photo').removeClass('d-none')
    else if $(this).text().indexOf("Following") >= 0
      $('.us.tab:not(".us.following")').addClass('d-none')
      $('.us.following').removeClass('d-none')
    else
      $('.us.tab:not(".us.followers")').addClass('d-none')
      $('.us.followers').removeClass('d-none')
      return
    return

  hash_links = gon.hash_links
  picture_obj_id=0
  this_id=0
  data_link=" "
  $userthumbnail = $('.us.thumbnail')
  $userthumbnail.on 'click',->
    this_id = $(this).attr('id')
    data_link = $(this).data('link')
    if typeof(data_link)=='undefined'
      length = hash_links[this_id].length
      $('#us-modal-body-image').attr 'src', hash_links[this_id][picture_obj_id][2]
      $('.modal-title').text hash_links[this_id][picture_obj_id][0]
      $('.modal-footer > p').text hash_links[this_id][picture_obj_id][1]
      jQuery('.us.modal').modal 'toggle'
    else
      $('#us-modal-body-image').attr 'src', data_link
      $('.modal-title').text $(this).find('.us.title').text()
      $('.modal-footer > p').text $(this).find('.us.card-body').text()
      jQuery('.us.modal').modal 'toggle'
      return
    return

  $('.us.modal').on 'hidden.bs.modal', ->
    picture_obj_id=0
    this_id=0
    return

  $('#arrowAnimleft').on 'click', ->
    if picture_obj_id >0
      picture_obj_id = picture_obj_id-1
      $('#us-modal-body-image').attr 'src', hash_links[this_id][picture_obj_id][2]
      $('.modal-title').text hash_links[this_id][picture_obj_id][0]
      $('.modal-footer > p').text hash_links[this_id][picture_obj_id][1]
    return

  $('#arrowAnimright').on 'click', ->
    if picture_obj_id < hash_links[this_id].length-1
      picture_obj_id = picture_obj_id + 1
      $('#us-modal-body-image').attr 'src', hash_links[this_id][picture_obj_id][2]
      $('.modal-title').text hash_links[this_id][picture_obj_id][0]
      $('.modal-footer > p').text hash_links[this_id][picture_obj_id][1]
    return



return



