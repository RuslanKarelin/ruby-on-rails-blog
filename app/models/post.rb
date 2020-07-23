class Post < ActiveRecord::Base
  include ModelShare

  before_validation :add_category

  validates :name, :alias, :category_id, :category_ids, presence: true
  validates :alias, uniqueness: true

  scope :published, -> {where(published: true)}

  belongs_to :category, touch: true
  has_one :image, as: :imageable, dependent: :destroy
  has_many :widget_pages, as: :widgetable, dependent: :destroy
  has_and_belongs_to_many :categories
  has_many :comments, :as => :commentable, dependent: :destroy
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: proc {|attributes| attributes[:name].nil?}

  def all_tags
    self.tags.map(&:name).join(', ')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create
    end
  end

  private

  def add_category
    self.category_ids = (self.categories.pluck(:id) << self.category_id).uniq
  end
end
