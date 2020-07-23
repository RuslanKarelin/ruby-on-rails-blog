# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in admin.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".show_form").on "click", (event) ->
    event.preventDefault()
    form_box = $(this).next(".form_box")
    if (form_box.css('display') == 'none')
      form_box.slideDown()
    else
      form_box.slideUp()

  $(".add_post").on "click", (event) ->
    event.preventDefault()
    form_box = $(this).next(".form_box")
    if (form_box.css('display') == 'none')
      form_box.slideDown()
    else
      form_box.slideUp()