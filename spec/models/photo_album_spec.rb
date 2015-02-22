require 'rails_helper'

RSpec.describe PhotoAlbum, :type => :model do
  let(:category) { FactoryGirl.create(:category, name: 'Lorem ipsum') }

  before do
    @photo_album = category.photo_albums.build(name: 'Test Photo Album',
        description: 'Lorem ipsum dolor sit amet, consectetur adipisicing ' +
                     'elit, sed do eiusmod tempor incididunt ut labore et ' +
                     'dolore magna aliqua.')
  end

  subject { @photo_album }

  it { should respond_to(:category_id) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }

  it { should be_valid }

  describe "when name is not present" do
    before { @photo_album.name = " " }

    it { should_not be_valid }
  end
end
