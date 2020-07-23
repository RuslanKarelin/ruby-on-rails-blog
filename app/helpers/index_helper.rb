module IndexHelper
  def posts_in_header
    PostsRepository.for_header_on_main
  end
end
