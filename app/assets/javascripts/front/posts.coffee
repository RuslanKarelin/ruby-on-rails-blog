$ ->
  $(".reply").on "click", (event) ->
    event.preventDefault()
    $('.post-reply [name="parent_id"]').val($(this).attr('data-id'))
    $('body,html').animate({'scrollTop': $('.post-reply').offset().top - 80 + 'px'})

  $("body").on "click", ".comment_destroy", (event) ->
    $(event.target).closest('.media').fadeOut()

  $(".post-reply").bind "ajax:success", (event, data, status, xhr) ->
    $(".post-reply [name='body'], .post-reply [name='parent_id']").val('')
    $('.post-comments').html(data)

  $("form#comment_form").on "ajax:success", (event, data, status, xhr) ->
    $('.post-comments').html(data)