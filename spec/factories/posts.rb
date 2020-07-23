FactoryBot.define do
  factory :post do
    name {'name'}
    add_attribute (:alias) {'first_post'}
    association :category, strategy: :build
  end
end