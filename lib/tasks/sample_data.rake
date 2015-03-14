namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    make_categories
    make_photo_albums
    make_photos
  end

  def make_categories
    10.times do |n|
      Category.create!(name: fake_name_or_title)
    end
  end

  def make_photo_albums
    Category.all.each do |category|
      Random.rand(21).times do |n|
        category.photo_albums.create!(name: fake_name_or_title,
            description: fake_description)
      end
    end
  end

  def make_photos
    images = []
    Dir.glob('lib/assets/images/*.jpg') do |image|
      images << image
    end

    PhotoAlbum.all.each do |photo_album|
      Random.rand(images.length + 1).times do |n|
        File.open(images[n]) do |f|
          photo_album.photos.create!(title: fake_name_or_title,
              description: fake_description, photo_file: f)
        end
      end
    end
  end

  def fake_name_or_title
    Faker::Lorem.sentence(1 + Random.rand(3), false, 0)[0..-2]
  end

  def fake_description
    Faker::Lorem.paragraph(1 + Random.rand(3))
  end
end
