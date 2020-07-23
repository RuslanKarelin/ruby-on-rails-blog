module TagsHelper
  def get_tags
    Tagging.select('COUNT("taggings"."tag_id") as total, "taggings"."tag_id"').group('"taggings"."tag_id"').joins(:tag).group(:name).limit(10)
  end
end
