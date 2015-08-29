require_relative '../lib/text_utils.rb'

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
  end

  factory :invalid_category, parent: :category do
    name nil
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

  factory :comment do
    author Faker::Name.name
    text TextUtils::truncate(Faker::Lorem.paragraph(1 + Random.rand(3)))

    factory :published_comment do
      published true
      published_at Faker::Time.between(1.year.ago, Time.now)
    end

    factory :draft_comment do
      published false
    end
  end

  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password
    is_admin false

    factory :admin do
      is_admin true
    end
  end
end
