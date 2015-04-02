require_relative '../lib/text_utils.rb'

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
  end

  factory :photo_album do
    sequence(:name) { |n| "Photo album #{n}" }
    description TextUtils::truncate(Faker::Lorem.paragraph(1 + Random.rand(3)))
    category
  end

  factory :photo do
    sequence(:title) { |n| "Title #{n}" }
    description TextUtils::truncate(Faker::Lorem.paragraph(1 + Random.rand(3)))
    photo_file File.open(Dir.glob('spec/fixtures/files/*.jpg')[0])
    photo_album
  end
end
