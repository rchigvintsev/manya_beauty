require 'rails_helper'

RSpec.describe "Dashboard", :type => :request do
  subject { page }

  before(:all) do
    3.times { FactoryGirl.create(:category) }
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

    describe "with invalid credentials" do
      before { click_button I18n.translate('sign_in.form.sign_in') }

      it { should have_content I18n.translate('devise.failure.invalid',
          authentication_keys: 'email') }
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

      # Sidebar
      it { should have_link(I18n.translate('categories'),
          href: categories_path(locale: I18n.locale)) }

      describe "followed by sign out" do
        before { click_link I18n.translate('sign_out') }

        it { should have_selector sign_in_button_selector }
      end
    end
  end

  describe "categories" do
    let(:user) { FactoryGirl.create(:admin) }
    let(:all_categories) { Category.all }

    before do
      visit user_session_path
      sign_in user
      click_link I18n.translate('categories')
    end

    it { should have_selector '.dashboard-table' }

    it "should render all categories" do
      all_categories.each do |category|
        expect(page).to have_content category.name
      end
    end

    describe "controls" do
      it { should have_link I18n.translate('actions.create'),
          href: new_category_path(locale: I18n.locale) }
      it { should have_link I18n.translate('actions.edit'), href: '#' }
      it { should have_link I18n.translate('actions.delete'), href: '#' }

      it { should have_selector "a.btn-edit[disabled='disabled']" }
      it { should have_selector "a.btn-delete[disabled='disabled']" }
    end

    describe "creating new category" do
      before { click_link I18n.translate('actions.create') }

      let(:submit) { I18n.translate('actions.create') }

      it { should have_content I18n.translate('category.creating') }
      it { should have_selector "form[action='#{categories_path(locale: I18n.locale)}']" }

      describe "with invalid information" do
        it "should not create a category" do
          expect { click_button submit }.not_to change(Category, :count)
        end

        describe "after submission" do
          before { click_button submit }

          it { should have_content I18n.translate('category.creating') }
          it { should have_selector 'form .alert.alert-danger' }
        end
      end

      describe "with valid information" do
        before do
          fill_in I18n.translate('activerecord.attributes.category.name'),
              with: 'Test Category'
        end

        it "should create a category" do
          expect { click_button submit }.to change(Category, :count).by(1)
        end

        describe "after saving the category" do
          before { click_button submit }

          it { should have_content I18n.translate('category.flash.actions.create.notice') }
          it { should have_selector '.dashboard-table' }
        end
      end
    end
  end
end
