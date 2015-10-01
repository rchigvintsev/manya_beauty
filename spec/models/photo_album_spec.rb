require 'rails_helper'

RSpec.describe PhotoAlbum, :type => :model do
  let(:category) { FactoryGirl.create(:category, name: 'Test Category') }

  before do
    @photo_album = category.photo_albums.build(name: 'Test Photo Album',
        description: 'Lorem ipsum dolor sit amet, consectetur adipisicing ' +
                     'elit, sed do eiusmod tempor incididunt ut labore et ' +
                     'dolore magna aliqua.')
  end

  subject { @photo_album }

  it { should respond_to(:category_id) }
  it { should respond_to(:category) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:cover_photo) }
  it { should respond_to(:photos) }

  its(:category) { should eq category }

  it { should be_valid }

  describe "with blank name" do
    before { @photo_album.name = '' }

    it { should_not be_valid }
  end

  describe "photo associations" do
    before { @photo_album.save! }

    let!(:photo) { FactoryGirl.create :photo, photo_album: @photo_album }

    it "should have associated photos" do
      expect(@photo_album.photos.to_a).to eq [photo]
    end

    it "should destroy associated photos" do
      associated_photos = @photo_album.photos.to_a
      @photo_album.destroy
      expect(associated_photos).not_to be_empty
      associated_photos.each { |p| expect(Photo.where(id: p.id)).to be_empty }
    end
  end
end
