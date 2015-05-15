require_relative '../text_utils.rb'

namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    make_categories
    make_photo_albums
    make_photos
    make_comments
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
            description: fake_text)
      end
    end
  end

  def make_photos
    images = []
    Dir.glob('lib/assets/images/*.jpg') do |image|
      images << image
    end

    PhotoAlbum.all.each do |photo_album|
      photos_number = Random.rand(images.length + 1)
      if photos_number > 0
        images.shuffle!
        photos_number.times do |n|
          File.open(images[n]) do |f|
            photo_album.photos.create!(title: fake_name_or_title,
                description: fake_text, photo_file: f)
          end
        end
      end
    end
  end

  def make_comments
    Photo.all.each do |photo|
      comments_number = Random.rand(50)
      comments_number.times do |n|
        published = [true, false].sample
        published_at = published ? Faker::Time.between(1.year.ago, Time.now) : nil
        photo.comments.create!(author: Faker::Name.name,
            text: fake_text, published: published, published_at: published_at)
      end
    end
  end

  def fake_name_or_title
    Faker::Lorem.sentence(1 + Random.rand(3), false, 0)[0..-2]
  end

  def fake_text
    TextUtils::truncate(Faker::Lorem.paragraph(1 + Random.rand(3)))
  end
end
