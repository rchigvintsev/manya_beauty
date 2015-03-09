require 'rails_helper'

RSpec.describe Photo, :type => :model do
  let(:category) { FactoryGirl.create(:category, name: 'Lorem ipsum') }
  let(:photo_album) do
    FactoryGirl.create(:photo_album, name: 'Dolor sit amet', category: category)
  end

  before do
    @photo = photo_album.photos.build(title: 'Test Photo',
        description: 'Lorem ipsum dolor sit amet, consectetur adipisicing ' +
                     'elit, sed do eiusmod tempor incididunt ut labore et ' +
                     'dolore magna aliqua.',
        file_name: 'test.jpg')
  end

  subject { @photo }

  it { should respond_to(:photo_album_id) }
  it { should respond_to(:photo_album) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:file_name) }

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

  describe "with blank file_name" do
    before { @photo.file_name = '' }

    it { should_not be_valid }
  end
end
