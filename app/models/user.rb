class User < ActiveRecord::Base
  before_create :create_role
  before_create :create_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :users_roles
  has_many :roles, through: :users_roles
  has_many :posts
  has_many :comments
  has_one :profile, dependent: :destroy

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all

  accepts_nested_attributes_for :profile, allow_destroy: true
  accepts_nested_attributes_for :roles, allow_destroy: true


  def is_cms_user?
    has_role? ['admin', 'manager']
  end

  def is_admin?
    has_role? 'admin'
  end

  def is_author?
    has_role? 'author'
  end

  def current_profile?(profile)
    self.profile.id == profile.id
  end

  private

  def create_role
    self.roles << Role.find_by_name(:user) unless self.roles.present?
  end

  def create_profile
    self.build_profile unless self.profile.present?
  end

  def has_role? role_i
    roles = (role_i.kind_of? Array) ? role_i : [role_i]
    has = false
    roles.each do |role|
      role = role.to_s if role.is_a? Symbol
      if self.roles.pluck(:name).include?(role)
        has = true
        break
      end
    end
    has
  end
end
