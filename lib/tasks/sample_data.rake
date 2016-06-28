require_relative '../text_utils.rb'

namespace :db do
  desc 'Fill database with sample data'

  task populate: :environment do
    make_photo_albums
    make_models
    make_photos
    make_comments
  end

  def make_photo_albums
    print 'Creating photo albums'

    10.times do
      PhotoAlbum.create!(name: fake_name_or_title, description: fake_text)
      print '.'
    end
    puts "\n#{PhotoAlbum.all.size} photo albums have been created"
  end

  def make_models
    print 'Creating models'

    PhotoAlbum.all.each do |photo_album|
      models_number = Random.rand(21)
      models_number.times do
        photo_album.models.create!(name: fake_name_or_title, description: fake_text)
        print '.'
      end
    end
    puts "\n#{Model.all.size} models have been created"
  end

  def make_photos
    print 'Creating photos'

    images = []
    Dir.glob('lib/assets/images/*.jpg') do |image|
      images << image
    end

    Model.all.each do |model|
      photos_number = Random.rand(images.length + 1)
      if photos_number > 0
        images.shuffle!
        photos_number.times do |n|
          File.open(images[n]) do |f|
            model.photos.create!(title: fake_name_or_title, description: fake_text, photo_file: f)
            print '.'
          end
        end
      end
    end

    puts "\n#{Photo.all.size} photos have been created"
  end

  def make_comments
    print 'Creating comments'

    Photo.all.each do |photo|
      comments_number = Random.rand(50)
      comments_number.times do |n|
        published = [true, false].sample
        published_at = published ? Faker::Time.between(1.year.ago, Time.now) : nil
        photo.comments.create!(author: Faker::Name.name, text: fake_text,
                               published: published, published_at: published_at)
        print '.'
      end
    end

    puts "\n#{Comment.all.size} comments have been created"
  end

  def fake_name_or_title
    Faker::Lorem.sentence(1 + Random.rand(3), false, 0)[0..-2]
  end

  def fake_text
    TextUtils::truncate(Faker::Lorem.paragraph(1 + Random.rand(3)))
  end
end
