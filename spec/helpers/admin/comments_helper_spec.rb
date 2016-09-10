require 'rails_helper'

RSpec.describe Admin::CommentsHelper, :type => :helper do
  describe '#truncate_text' do
    let(:comment) { FactoryGirl.create(:comment, text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ' +
                                                       'sed do eiusmod tempor incididunt ut labore et dolore ' +
                                                       'magna aliqua.') }

    it 'should truncate comment text up to 75 characters length' do
      expect(helper.truncate_text(comment).length).not_to be > 75
    end
  end

  describe '#draft_comment_count' do
    before { 3.times { FactoryGirl.create(:draft_comment) } }

    it 'should return number of draft comments' do
      expect(helper.draft_comment_count).to eq 3
    end
  end
end
