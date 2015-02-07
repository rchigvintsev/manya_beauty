namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    make_categories
  end

  def make_categories
    10.times do |n|
      words = Faker::Lorem.words(1 + Random.rand(3))
      words[0].capitalize!
      Category.create!(name: words.join(' '))
    end
  end
end
