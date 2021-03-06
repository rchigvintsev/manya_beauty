require 'rails_helper'

RSpec.describe PhotoAlbum, :type => :model do
  before do
    @photo_album = PhotoAlbum.new(name: 'Test Photo Album',
        description: 'Lorem ipsum dolor sit amet, consectetur adipisicing ' +
                     'elit, sed do eiusmod tempor incididunt ut labore et ' +
                     'dolore magna aliqua.')
  end

  subject { @photo_album }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:models) }
  it { should respond_to(:has_at_least_one_photo) }

  it { should be_valid }

  it 'should not have any photo' do
    expect(@photo_album.has_at_least_one_photo).to be_falsey
  end

  describe 'with blank name' do
    before { @photo_album.name = '' }

    it { should_not be_valid }
  end

  describe 'model associations' do
    before { @photo_album.save! }

    let!(:model) do
      model = FactoryGirl.create :model, photo_album: @photo_album
      FactoryGirl.create :photo, model: model
      model
    end

    it 'should have at least one photo' do
      expect(@photo_album.has_at_least_one_photo).to be_truthy
    end

    it 'should have associated models' do
      expect(@photo_album.models.to_a).to eq [model]
    end

    it 'should destroy associated models' do
      associated_models = @photo_album.models.to_a
      @photo_album.destroy
      expect(associated_models).not_to be_empty
      associated_models.each { |m| expect(Model.where(id: m.id)).to be_empty }
    end
  end
end
