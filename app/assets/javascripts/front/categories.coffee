$(".loadmore > a").on "ajax:success", (event, data, status, xhr) ->
  $(event.target).attr('href', data.next_page_link)
  if data.current_page == data.total_pages
    $(event.target).hide(0)

  if data.posts
    for post in data.posts
      $('.more_posts').append(post.post)


