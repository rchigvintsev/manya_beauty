require 'rails_helper'

RSpec.describe 'Admin::Admin', :type => :request do
  subject { page }

  describe 'sign in page' do
    before { visit admin_root_path }

    it_should_behave_like 'all admin pages'

    it { should have_content I18n.t('sign_in.prompt') }
    it { should have_selector 'form #email_input' }
    it { should have_selector 'form #password_input' }
  end

  describe 'authentication' do
    let(:sign_in_button) do
      "input[type=submit][value='#{I18n.t('sign_in.form.sign_in')}']"
    end

    before { visit user_session_path }

    it_should_behave_like 'all admin pages'

    describe 'with invalid credentials' do
      before { click_button I18n.t('sign_in.form.sign_in') }

      it { should have_content I18n.t('devise.failure.invalid', authentication_keys: 'Email') }
      it { should_not have_link I18n.t('sign_out'), href: destroy_user_session_path(locale: I18n.locale) }
      it { should have_selector sign_in_button }
    end

    describe 'with valid credentials' do
      let(:user) { FactoryGirl.create(:admin) }

      before { sign_in user }

      it { should have_link I18n.t('sign_out'), href: destroy_user_session_path(locale: I18n.locale) }
      it { should_not have_selector sign_in_button }

      describe 'followed by sign out' do
        before { click_link I18n.t('sign_out') }

        it { should have_selector sign_in_button }
      end
    end
  end

  describe 'admin pages' do
    let(:user) { FactoryGirl.create(:admin) }

    before do
      visit user_session_path
      sign_in user
    end

    it_should_behave_like 'all admin pages'

    describe 'sidebar' do
      include Admin::CommentsHelper

      let(:sidebar_item) { '.admin-sidebar > ul > li > a' }

      it { should have_selector sidebar_item, text: /#{I18n.t('photo_albums')}/i }
      it { should have_selector sidebar_item, text: /#{I18n.t('models')}/i }
      it { should have_selector sidebar_item, text: /#{I18n.t('photos')}/i }
      it { should have_selector sidebar_item, text: /#{I18n.t('comments')}/i }
      it { should have_selector '.draft-comment-counter', text: /#{draft_comment_count}/i }
    end
  end
end
