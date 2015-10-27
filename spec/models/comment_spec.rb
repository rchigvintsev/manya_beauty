require 'rails_helper'

RSpec.describe Comment, :type => :model do
  let(:photo) { FactoryGirl.create(:photo, title: 'Test Photo') }

  before do
    @comment = photo.comments.build(author: 'Test Author',
        text: 'Lorem ipsum dolor sit amet, consectetur adipisicing ' +
              'elit, sed do eiusmod tempor incididunt ut labore et ' +
              'dolore magna aliqua.')
  end

  subject { @comment }

  it { should respond_to(:photo_id) }
  it { should respond_to(:author) }
  it { should respond_to(:text) }
  it { should respond_to(:published) }
  it { should respond_to(:published_at) }
  it { should respond_to(:edited_by_admin) }

  its(:photo) { should eq photo }

  it { should be_valid }

  describe "when photo_id is not present" do
    before { @comment.photo_id = nil }

    it { should_not be_valid }
  end

  describe "with blank author" do
    before { @comment.author = '' }

    it { should_not be_valid }
  end

  describe "with blank text" do
    before { @comment.text = '' }

    it { should_not be_valid }
  end
end
