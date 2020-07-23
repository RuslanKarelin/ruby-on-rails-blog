FactoryBot.define do
  factory :category do
    name {'name'}
    add_attribute (:alias) {'first_category'}
  end
end