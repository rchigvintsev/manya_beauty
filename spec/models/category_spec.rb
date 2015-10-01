require 'rails_helper'

RSpec.describe Category, :type => :model do
  before { @category = Category.new(name: 'Test Category') }

  subject { @category }

  it { should respond_to :name }
  it { should respond_to :photo_albums }

  it { should be_valid }

  describe "with blank name" do
    before { @category.name = '' }

    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      category_with_same_name = @category.dup
      category_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "photo album associations" do
    before { @category.save! }

    let!(:photo_album) { FactoryGirl.create :photo_album, category: @category }

    it "should have associated photo albums" do
      expect(@category.photo_albums.to_a).to eq [photo_album]
    end

    it "should destroy photo album associations" do
      associated_photo_albums = @category.photo_albums.to_a
      @category.destroy
      expect(associated_photo_albums).not_to be_empty
      associated_photo_albums.each do |pa|
        expect(PhotoAlbum.find(pa.id).category).to be_nil
      end
    end
  end
end
