FactoryGirl.define do
  factory :book do
    name Faker::Book.unique.title
    sequence(:isbn) { |n| "123-456-789-#{n}" }
  end
end
