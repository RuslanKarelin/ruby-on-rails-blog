json.current_page @page
json.total_pages @model.total_pages
json.next_page_link @link
json.posts do
  json.array! @model do |post|
    json.post render partial: '/posts/post_v3', locals: {post: post}
  end
end