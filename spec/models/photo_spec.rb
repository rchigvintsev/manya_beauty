require 'rails_helper'

RSpec.describe Photo, :type => :model do
  let(:photo_album) do
    FactoryGirl.create(:photo_album, name: 'Test Photo Album')
  end

  let(:photo_params) do
    {
      title: 'Test Photo',
      description: 'Lorem ipsum dolor sit amet, consectetur adipisicing ' +
                   'elit, sed do eiusmod tempor incididunt ut labore et ' +
                   'dolore magna aliqua.',
      photo_album: photo_album
    }
  end

  before { @photo = FactoryGirl.create(:photo, photo_params) }

  subject { @photo }

  it { should respond_to(:photo_album_id) }
  it { should respond_to(:photo_album) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:photo_file) }
  it { should respond_to(:comments) }

  its(:photo_album) { should eq photo_album }

  it { should be_valid }

  describe "when photo_album_id is not present" do
    before { @photo.photo_album_id = nil }

    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @photo.title = '' }

    it { should_not be_valid }
  end

  describe "when photo_file is not present" do
    before { @photo = Photo.new(photo_params) }

    it { should_not be_valid }
  end

  describe "comments" do
    before do
      FactoryGirl.create(:published_comment, published_at: 1.day.ago.localtime,
          photo: @photo)
      FactoryGirl.create(:published_comment, published_at: Time.now,
          photo: @photo)
    end

    subject(:comments) { @photo.comments }

    its(:length) { should eq 2 }

    it "should be sorted by publication date in descending order" do
      expect(comments.first.published_at).to be > comments.last.published_at
    end
  end
end
