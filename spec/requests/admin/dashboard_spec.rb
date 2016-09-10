require 'rails_helper'

RSpec.describe 'Dashboard', :type => :request do
  subject { page }

  before(:all) do
    9.times do
      model = FactoryGirl.create(:model)
      3.times do
        photo = FactoryGirl.create(:photo, model: model)
        2.times { FactoryGirl.create(:published_comment, photo: photo) }
        FactoryGirl.create(:draft_comment, photo: photo)
      end
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe "sign in page" do
    before { visit admin_dashboard_path }

    it_should_behave_like "all admin pages"

    it { should have_content I18n.translate('sign_in.prompt') }
    it { should have_selector 'form #email_input' }
    it { should have_selector 'form #password_input' }
  end

  describe "authentication" do
    let(:sign_in_button_selector) do
      "input[type=submit][value='#{I18n.translate('sign_in.form.sign_in')}']"
    end

    before { visit user_session_path }

    it_should_behave_like "all admin pages"

    describe "with invalid credentials" do
      before { click_button I18n.translate('sign_in.form.sign_in') }

      it { should have_content I18n.translate('devise.failure.invalid', authentication_keys: 'Email') }
      it { should_not have_link I18n.translate('sign_out'),
          href: destroy_user_session_path(locale: I18n.locale) }
      it { should have_selector sign_in_button_selector }
    end

    describe "with valid credentials" do
      let(:user) { FactoryGirl.create(:admin) }

      before { sign_in user }

      it { should have_link I18n.translate('sign_out'),
          href: destroy_user_session_path(locale: I18n.locale) }
      it { should_not have_selector sign_in_button_selector }

      describe "followed by sign out" do
        before { click_link I18n.translate('sign_out') }

        it { should have_selector sign_in_button_selector }
      end
    end
  end

  describe "dashboard pages" do
    let(:user) { FactoryGirl.create(:admin) }

    before do
      visit user_session_path
      sign_in user
    end

    it_should_behave_like 'all admin pages'

    describe "sidebar" do
      include Admin::CommentsHelper

      let(:sidebar_item_selector) { '.dashboard-sidebar > ul > li > a' }

      it { should have_selector sidebar_item_selector, text: /#{I18n.translate('photo_albums')}/i }
      it { should have_selector sidebar_item_selector, text: /#{I18n.translate('models')}/i }
      it { should have_selector sidebar_item_selector, text: /#{I18n.translate('photos')}/i }
      it { should have_selector sidebar_item_selector, text: /#{I18n.translate('comments')}/i }
      it { should have_selector ".draft-comment-counter", text: /#{draft_comment_count}/i }
    end
  end
end
