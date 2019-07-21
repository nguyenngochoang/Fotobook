# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
	$('.admin-edit-btn').click ->
		user_id = $(this).attr('data-id')
		return

	$('.thumbnail').on 'mouseover', ->
		$(this).find('.admin-photonums').stop().fadeIn(500)
		return

	$('.thumbnail').on 'mouseleave', ->
    $(this).find('.admin-photonums').stop().fadeOut 500
		return



	return

