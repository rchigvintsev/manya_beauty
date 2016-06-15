require 'rails_helper'

RSpec.describe Model, :type => :model do
  let(:photo_album) { FactoryGirl.create(:photo_album, name: 'Test Photo Album') }

  before do
    @model = Model.new(name: 'Test Model', description: 'Lorem ipsum dolor sit amet, ' +
        'consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et ' +
        'dolore magna aliqua.', photo_album: photo_album)
  end

  subject { @model }

  it { should respond_to(:photo_album_id) }
  it { should respond_to(:photo_album) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:photos) }

  its(:photo_album) { should eq photo_album }

  it { should be_valid }

  describe 'when photo_album_id is not present' do
    before { @model.photo_album_id = nil }

    it { should_not be_valid }
  end

  describe 'with blank name' do
    before { @model.name = '' }

    it { should_not be_valid }
  end

  describe 'photo associations' do
    before { @model.save! }

    let!(:photo) { FactoryGirl.create :photo, model: @model }

    it 'should have associated photos' do
      expect(@model.photos.to_a).to eq [photo]
    end

    it 'should destroy associated photos' do
      associated_photos = @model.photos.to_a
      @model.destroy
      expect(associated_photos).not_to be_empty
      associated_photos.each { |p| expect(Photo.where(id: p.id)).to be_empty }
    end
  end
end
