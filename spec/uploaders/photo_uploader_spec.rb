require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe "PhotoUploader", :type => :uploader do
  include CarrierWave::Test::Matchers

  before do
    photo = FactoryGirl.create(:photo)

    PhotoUploader.enable_processing = true
    @uploader = PhotoUploader.new(photo)

    images = []
    Dir.glob('spec/fixtures/files/*.jpg') do |image|
      images << image
    end

    File.open(images[Random.rand(images.length)]) do |f|
      @uploader.store!(f)
    end
  end

  after do
    PhotoUploader.enable_processing = false
    @uploader.remove!
  end

  describe "the thumb version" do
    it "should scale down an image to fit within 320 by 213 pixels" do
      expect(@uploader.thumb).to be_no_larger_than(320, 213)
    end
  end
end
