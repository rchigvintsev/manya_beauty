require 'rails_helper'

RSpec.describe "Dashboard", :type => :request do
  subject { page }

  before(:all) do
    3.times do
      category = FactoryGirl.create(:category)
      3.times do
        photo_album = FactoryGirl.create(:photo_album, category: category)
        3.times do
          photo = FactoryGirl.create(:photo, photo_album: photo_album)
          2.times { FactoryGirl.create(:published_comment, photo: photo) }
          FactoryGirl.create(:draft_comment, photo: photo)
        end
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

  describe "dashboard pages" do
    let(:user) { FactoryGirl.create(:admin) }

    before do
      visit user_session_path
      sign_in user
    end

    describe "categories" do
      let(:all_categories) { Category.all }

      before { click_link I18n.translate('categories') }

      it { should have_selector '.dashboard-table.categories' }

      it "should render all categories" do
        all_categories.each do |category|
          expect(page).to have_content category.id
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
            it { should have_selector '.dashboard-table.categories' }
          end
        end
      end
    end

    describe "photo albums" do
      let(:all_photo_albums) { PhotoAlbum.all }

      before { click_link I18n.translate('photo_albums') }

      it { should have_selector '.dashboard-table.photo-albums' }

      it "should render all photo albums" do
        PhotoAlbum.paginate(page: 1).each do |photo_album|
          expect(page).to have_content photo_album.id
          expect(page).to have_content photo_album.name
        end
      end

      describe "controls" do
        it { should have_link I18n.translate('actions.create'),
            href: new_photo_album_path(locale: I18n.locale) }
        it { should have_link I18n.translate('actions.edit'), href: '#' }
        it { should have_link I18n.translate('actions.delete'), href: '#' }

        it { should have_selector "a.btn-edit[disabled='disabled']" }
        it { should have_selector "a.btn-delete[disabled='disabled']" }
      end

      describe "creating new photo album" do
        before { click_link I18n.translate('actions.create') }

        let(:submit) { I18n.translate('actions.create') }

        it { should have_content I18n.translate('photo_album.creating') }
        it { should have_selector "form[action='#{photo_albums_path(locale: I18n.locale)}']" }

        describe "with invalid information" do
          it "should not create a photo album" do
            expect { click_button submit }.not_to change(PhotoAlbum, :count)
          end

          describe "after submission" do
            before { click_button submit }

            it { should have_content I18n.translate('photo_album.creating') }
            it { should have_selector 'form .alert.alert-danger' }
          end
        end

        describe "with valid information" do
          before do
            fill_in I18n.translate('activerecord.attributes.photo_album.name'),
                with: 'Test Photo Album'
          end

          it "should create a photo album" do
            expect { click_button submit }.to change(PhotoAlbum, :count).by(1)
          end

          describe "after saving the photo album" do
            before { click_button submit }

            it { should have_content I18n.translate('photo_album.flash.actions.create.notice') }
            it { should have_selector '.dashboard-table.photo-albums' }
          end
        end
      end
    end

    describe "photos" do
      before { click_link I18n.translate('photos') }

      it { should have_selector '.dashboard-table.photos' }

      it "should render all photos" do
        Photo.paginate(page: 1).each do |photo|
          expect(page).to have_content photo.id
          expect(page).to have_content photo.title
          expect(page).to have_selector "img[src='#{photo.photo_file_url(:thumb)}']"
        end
      end

      describe "controls" do
        it { should have_link I18n.translate('actions.create'),
            href: new_photo_path(locale: I18n.locale) }
        it { should have_link I18n.translate('actions.edit'), href: '#' }
        it { should have_link I18n.translate('actions.delete'), href: '#' }

        it { should have_selector "a.btn-edit[disabled='disabled']" }
        it { should have_selector "a.btn-delete[disabled='disabled']" }
      end

      describe "creating new photo" do
        before { click_link I18n.translate('actions.create') }

        let(:submit) { I18n.translate('actions.create') }

        it { should have_content I18n.translate('photo.creating') }
        it { should have_selector "form[action='#{photos_path(locale: I18n.locale)}']" }

        describe "with invalid information" do
          it "should not create a photo" do
            expect { click_button submit }.not_to change(Photo, :count)
          end

          describe "after submission" do
            before { click_button submit }

            it { should have_content I18n.translate('photo.creating') }
            it { should have_selector 'form .alert.alert-danger' }
          end
        end

        describe "with valid information" do
          before do
            fill_in I18n.translate('activerecord.attributes.photo.title'),
                with: 'Test Photo'
            attach_file I18n.translate('activerecord.attributes.photo.photo_file'),
                Rails.root + 'spec/fixtures/files/dirt-bike-690770.jpg'
          end

          it "should create a photo" do
            expect { click_button submit }.to change(Photo, :count).by(1)
          end

          describe "after saving the photo" do
            before { click_button submit }

            it { should have_content I18n.translate('photo.flash.actions.create.notice') }
            it { should have_selector '.dashboard-table.photos' }
          end
        end
      end
    end

    describe "comments" do
      include CommentsHelper

      before { click_link I18n.translate('comments') }

      it { should have_selector '.dashboard-table.comments' }

      it "should render all comments" do
        Comment.order('created_at DESC').paginate(page: 1).each do |comment|
          expect(page).to have_content comment.id
          expect(page).to have_content comment.author
          expect(page).to have_content truncate_text(comment)
          expect(page).to have_content I18n.localize(comment.created_at,
              format: date_time_format)
          if not comment.published_at.nil?
            expect(page).to have_content I18n.localize(comment.published_at,
                format: date_time_format)
          end
          expect(page).to have_selector "img[src='#{comment.photo.photo_file_url(:thumb)}']"
        end
      end

      describe "controls" do
        it { should have_link I18n.translate('actions.edit'), href: '#' }
        it { should have_link I18n.translate('actions.publish'), href: '#' }
        it { should have_link I18n.translate('actions.unpublish'), href: '#' }
        it { should have_link I18n.translate('actions.delete'), href: '#' }

        it { should have_selector "a.btn-edit[disabled='disabled']" }
        it { should have_selector "a.btn-publish[disabled='disabled']" }
        it { should have_selector "a.btn-unpublish[disabled='disabled']" }
        it { should have_selector "a.btn-delete[disabled='disabled']" }
      end
    end
  end
end
