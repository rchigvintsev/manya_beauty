require_relative '../lib/text_utils.rb'

FactoryGirl.define do
  factory :photo_album do
    sequence(:name) { |n| "Photo album #{n}" }
    description TextUtils::truncate(Faker::Lorem.paragraph(1 + Random.rand(3)))
  end

  factory :invalid_photo_album, parent: :photo_album do
    name nil
  end

  factory :model do
    sequence(:name) { |n| "Model #{n}" }
    description TextUtils::truncate(Faker::Lorem.paragraph(1 + Random.rand(3)))
    favorite false
    photo_album
  end

  factory :invalid_model, parent: :model do
    name nil
  end

  factory :photo do
    sequence(:title) { |n| "Title #{n}" }
    description TextUtils::truncate(Faker::Lorem.paragraph(1 + Random.rand(3)))
    photo_file File.open(Dir.glob('spec/fixtures/files/*.jpg')[0])
    model
  end

  factory :invalid_photo, parent: :photo do
    title nil
  end

  factory :comment do
    author Faker::Name.name
    text TextUtils::truncate(Faker::Lorem.paragraph(1 + Random.rand(3)))
    photo

    factory :published_comment do
      published true
      published_at Faker::Time.between(1.year.ago, Time.now)
    end

    factory :draft_comment do
      published false
    end
  end

  factory :invalid_comment, parent: :comment do
    text nil
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
