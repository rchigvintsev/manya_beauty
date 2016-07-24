require 'rails_helper'

RSpec.describe FavoritePhotoAlbum, :type => :model do
  before { @favorite_photo_album = FavoritePhotoAlbum.new }

  subject { @favorite_photo_album }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:models) }
  it { should respond_to(:has_at_least_one_photo) }

  its(:name) { should eq I18n.translate('photo_album.favorite.name') }
  its(:description) { should eq I18n.translate('photo_album.favorite.description') }

  describe 'model associations' do
    let!(:favorite_model) { FactoryGirl.create :model, favorite: true }

    it "should have associated model with 'favorite' attribute set to true" do
      expect(@favorite_photo_album.models.to_a).to eq [favorite_model]
    end
  end
end
