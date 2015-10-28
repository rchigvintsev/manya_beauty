require 'rails_helper'

RSpec.describe FavoritePhotoAlbum, :type => :model do
  before { @favorite_photo_album = FavoritePhotoAlbum.new }

  subject { @favorite_photo_album }

  it { should respond_to(:category) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:cover_photo) }
  it { should respond_to(:photos) }

  its(:category) { should be_nil }
  its(:name) { should eq I18n.translate('photo_album.favorite.name') }
  its(:description) { should eq I18n.translate('photo_album.favorite.description') }

  describe "photo associations" do
    let!(:photo) { FactoryGirl.create :photo }
    let!(:favorite_photo) { FactoryGirl.create :photo, favorite: true }

    it "should have associated photos with 'favorite' attribute set to true" do
      expect(@favorite_photo_album.photos.to_a).to eq [favorite_photo]
    end
  end
end
