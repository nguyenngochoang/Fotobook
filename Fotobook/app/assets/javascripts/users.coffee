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
  $('.follow-button').on 'click', ->
    if $(this).text() == '+ Follow'
      $(this).text 'Following'
      $(this).css 'backgroundImage', 'linear-gradient(to right, #fe8c00 51%, #f83600 100%)'
    else
      $(this).text '+ Follow'
      $(this).css 'backgroundImage', ''
      $(this).css 'backgroundColor', '#ffffff'
    return



  $('.albumThumbnail').on 'mouseover', ->
    $(this).find('.photonums').stop().fadeIn 500
    return
  $('.albumThumbnail').on 'mouseleave', ->
    $(this).find('.photonums').stop().fadeOut 500
    return

  $usertab = $('.us.usertab')
  $usertab.on 'click', ->
    $(this).addClass 'font-weight-bolder'
    $(this).removeClass 'text-black-50'
    $notthis = $usertab.not(this)
    if $(this).text().indexOf("Album") >= 0
      $('.us.ab').removeClass('d-none')
      $('.us.photo').addClass('d-none')
    else if $(this).text().indexOf("Photos") >= 0
      $('.us.ab').addClass('d-none')
      $('.us.photo').removeClass('d-none')
      return
    if $notthis.hasClass 'font-weight-bolder'
      $notthis.removeClass 'font-weight-bolder'
      $notthis.addClass 'text-black-50'
      return
    return



return



