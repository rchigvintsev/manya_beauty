require 'rails_helper'

RSpec.describe 'Admin::Comments', :type => :request do
  include Admin::CommentsHelper

  subject { page }

  let(:user) { FactoryGirl.create(:admin) }

  before do
    3.times { FactoryGirl.create(:published_comment) }
    3.times { FactoryGirl.create(:draft_comment) }

    visit user_session_path
    sign_in user
    visit admin_comments_path
  end

  it_should_behave_like 'all admin pages'

  it { should have_selector '.admin-table.comments' }

  it 'should render all comments' do
    Comment.paginate(page: 1).each do |comment|
      expect(page).to have_content comment.id
      expect(page).to have_content comment.author
      expect(page).to have_content truncate_text(comment)
      expect(page).to have_content I18n.l(comment.created_at, format: date_time_format)
      if comment.published
        expect(page).to have_content I18n.l(comment.published_at, format: date_time_format)
      end
      expect(page).to have_selector "img[src='#{comment.photo.photo_file_url(:thumb)}']"
    end
  end

  describe 'comment table controls' do
    it { should have_link I18n.t('actions.edit'), href: '#' }
    it { should have_link I18n.t('actions.publish'), href: '#' }
    it { should have_link I18n.t('actions.unpublish'), href: '#' }
    it { should have_link I18n.t('actions.delete'), href: '#' }

    it { should have_selector 'a.btn-edit.hidden' }
    it { should have_selector 'a.btn-publish.hidden' }
    it { should have_selector 'a.btn-unpublish.hidden' }
    it { should have_selector 'a.btn-delete.hidden' }
  end

  describe 'show' do
    shared_examples_for 'comment show page' do
      it { should have_content comment.author }
      it { should have_content comment.text }
      it { should have_content I18n.l(comment.created_at, format: date_time_format) }
      it { should have_selector "img[src='#{comment.photo.photo_file_url(:thumb)}']" }
      it { should have_selector "img[src='#{comment.photo.photo_file_url}']" }

      it { should have_link I18n.t('actions.edit'), href: edit_admin_comment_path(comment, locale: I18n.locale) }
      it { should have_link I18n.t('actions.cancel'), href: admin_comments_path(locale: I18n.locale) }
    end

    describe 'published comment' do
      let(:comment) { Comment.where(published: true).first }
      before { visit admin_comment_path(comment) }

      it_should_behave_like 'comment show page'
      it { should have_content I18n.l(comment.published_at, format: date_time_format) }
    end

    describe 'unpublished comment' do
      let(:comment) { Comment.where(published: false).first }
      before { visit admin_comment_path(comment) }

      it_should_behave_like 'comment show page'
    end
  end
end
