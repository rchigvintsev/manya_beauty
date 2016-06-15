require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe 'PhotoUploader', :type => :uploader do
  include CarrierWave::Test::Matchers

  before do
    photo_album = PhotoAlbum.new(name: 'Test Photo Album')
    model = photo_album.models.build(name: 'Test Model')
    photo = model.photos.build(title: 'Test Photo')

    PhotoUploader.enable_processing = true
    @uploader = PhotoUploader.new(photo, :photo_file)

    File.open(Dir.glob('spec/fixtures/files/*.jpg')[0]) do |f|
      @uploader.store!(f)
    end
  end

  after do
    PhotoUploader.enable_processing = false
    @uploader.remove!
  end

  describe 'the thumb version' do
    it 'should scale down an image to fit within 320 by 213 pixels' do
      expect(@uploader.thumb).to be_no_larger_than(320, 213)
    end
  end
end
