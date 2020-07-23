module ModelShare
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  included do

    attr_accessor :show_page_header, :banner

    before_validation :generate_alias

    def generate_alias
      self.alias = self.name.to_slug.transliterate(:russian).normalize.to_s if self.alias.blank?
    end

    self.per_page = 10
  end
end