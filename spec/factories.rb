FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
  end

  factory :photo_album do
    sequence(:name) { |n| "Photo album #{n}" }
    description Faker::Lorem.paragraph(1 + Random.rand(3))
    category
  end
end
