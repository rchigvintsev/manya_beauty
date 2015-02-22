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
    Category.all.each do |category|
      Random.rand(21).times do |n|
        category.photo_albums.create!(name: fake_name,
            description: Faker::Lorem.paragraph(1 + Random.rand(3)))
      end
    end
  end

  def fake_name
    Faker::Lorem.sentence(1 + Random.rand(3), false, 0)[0..-2]
  end
end
