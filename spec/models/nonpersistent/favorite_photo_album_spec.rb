require 'rails_helper'

RSpec.describe FavoritePhotoAlbum, :type => :model do
  before { @favorite_photo_album = FavoritePhotoAlbum.new }

  subject { @favorite_photo_album }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:models) }

  its(:name) { should eq I18n.translate('photo_album.favorite.name') }
  its(:description) { should eq I18n.translate('photo_album.favorite.description') }

  describe 'model associations' do
    let!(:model) { FactoryGirl.create :model }

    before do
      2.times {FactoryGirl.create :photo, favorite: true, model: model}
    end

    it "should have associated models that contain photos where 'favorite' attribute set to true" do
      expect(@favorite_photo_album.models.to_a).to eq [model]
    end
  end
end
