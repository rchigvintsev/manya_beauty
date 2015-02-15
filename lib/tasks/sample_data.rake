namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    make_categories
    make_photo_albums
  end

  def make_categories
    10.times do |n|
      Category.create!(name: fake_name)
    end
  end

  def make_photo_albums
    for category in Category.all do
      album_number = Random.rand(21)
      album_number.times do |n|
        category.photo_albums.create!(name: fake_name,
            description: Faker::Lorem.paragraph(1 + Random.rand(3)))
      end
    end
  end

  def fake_name
    words = Faker::Lorem.words(1 + Random.rand(3))
    words[0].capitalize!
    words.join(' ')
  end
end
