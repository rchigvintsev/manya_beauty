require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  let(:photo) { FactoryGirl.create(:photo) }
  let(:comment_params) {{
    author: 'Test Author',
    text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, ' +
          'sed do eiusmod tempor incididunt ut labore et dolore magna ' +
          'aliqua.'
  }}

  describe "creating a comment with Ajax" do
    it "should increment the Comment count" do
      expect do
        xhr :post, :create, photo_id: photo.id, comment: comment_params
      end.to change(Comment, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, photo_id: photo.id, comment: comment_params
      expect(response).to be_success
    end
  end
end
