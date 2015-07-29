require 'rails_helper'

RSpec.describe "StaticPages", :type => :request do
  subject { page }

  shared_examples_for "all static pages" do
    describe "header" do
      it { should have_selector 'div.logo > a > img' }

      it "should have main menu with two items" do
        expect(find 'ul.main-menu').to have_selector('li', count: 2)
      end
    end

    describe "footer" do
      describe "copyright" do
        it { should have_content "ManyaBeauty \u00A9 #{Time.now.year}" }
      end

      describe "locale" do
        it { should have_link 'RU' }
        it { should have_link 'EN' }
      end
    end
  end

  describe "Home page" do
    before { visit root_path }

    it_should_behave_like "all static pages"

    describe "main menu" do
      describe "Home page menu item should be activated" do
        it { should have_selector('li.active', text: I18n.translate('home')) }
        it { should_not have_selector('li.active', text: I18n.translate('gallery')) }
      end
    end

    describe "greeting" do
      it { should have_content(I18n.translate('greeting')) }

      describe "translation" do
        describe "for english locale" do
          before do
            click_link 'EN'
          end

          it { should have_content I18n.translate('greeting', locale: 'en') }
          it { should_not have_content I18n.translate('greeting', locale: 'ru') }
        end

        describe "for russian locale" do
          before do
            click_link 'RU'
          end

          it { should have_content I18n.translate('greeting', locale: 'ru') }
          it { should_not have_content I18n.translate('greeting', locale: 'en') }
        end
      end
    end

    describe "jCarousel" do
      it { should have_selector 'div.jcarousel-wrapper > .jcarousel > ul > li > img' }
      it { should have_selector 'div.jcarousel-wrapper > a.jcarousel-prev' }
      it { should have_selector 'div.jcarousel-wrapper > a.jcarousel-next' }
    end

    describe "about" do
      it { should have_selector "img[src*='avatar.png']" }
      it { should have_content I18n.translate('about.header') }
      it { should have_content I18n.translate('about.content') }
    end
  end

  describe "Gallery page" do
    before(:all) do
      3.times do
        category = FactoryGirl.create(:category)
        5.times do
          photo_album = FactoryGirl.create(:photo_album, category: category)
          7.times do
            photo = FactoryGirl.create(:photo, photo_album: photo_album)
          end
        end
      end
    end

    after(:all) do
      DatabaseCleaner.clean_with(:truncation)
    end

    before do
      visit gallery_path
    end

    it_should_behave_like "all static pages"

    describe "main menu" do
      describe "Gallery page menu item should be activated" do
        it { should have_selector('li.active', text: I18n.translate('gallery')) }
        it { should_not have_selector('li.active', text: I18n.translate('home')) }
      end
    end

    describe "categories" do
      let(:all_categories) { Category.all }

      it { should have_content I18n.translate('categories') }

      it "should render all categories" do
        all_categories.each do |category|
          expect(page).to have_link(category.name,
              href: gallery_path(category_id: category.id, locale: I18n.locale))
        end
      end

      it "should render special category to show all photo albums" do
        expect(page).to have_link(I18n.translate('category.all'),
            href: gallery_path(locale: I18n.locale))
      end
    end

    describe "photo albums" do
      let(:all_photo_albums) { PhotoAlbum.all }

      it "should render all photo albums" do
        all_photo_albums.each do |photo_album|
          expect(page).to have_content photo_album.name
          expect(page).to have_content photo_album.description
        end
      end

      describe "covers" do
        it "should render first photo in photo album" do
          all_photo_albums.each do |photo_album|
            expect(page).to have_selector "a[href=" +
                "'#{photo_album_path(photo_album, locale: I18n.locale)}'] > " +
                "img[src='#{photo_album.photos.first.photo_file_url(:thumb)}']"
          end
        end
      end

      describe "photos" do
        let(:photo_album) { PhotoAlbum.first }

        before { visit photo_album_path(photo_album) }

        it "should render photo album name" do
          expect(page).to have_content photo_album.name
        end

        it "should render breadcrumbs" do
          expect(page).to have_selector "ol[class='breadcrumb'] > li", count: 4

          expect(page).to have_selector "ol[class='breadcrumb'] > li > " +
              "a[href='#{root_path(locale: I18n.locale)}']",
              text: I18n.translate('home')
          expect(page).to have_selector "ol[class='breadcrumb'] > li > " +
              "a[href='#{gallery_path(locale: I18n.locale)}']",
              text: I18n.translate('gallery')
          expect(page).to have_selector "ol[class='breadcrumb'] > li > " +
              "a[href='#{gallery_path(category_id: photo_album.category.id, locale: I18n.locale)}']",
              text: photo_album.category.name
          expect(page).to have_selector "ol[class='breadcrumb'] > li.active",
              text: photo_album.name
        end

        it "should render all photos in photo album" do
          photo_album.photos.each do |photo|
            expect(page).to have_selector "a[href='#{photo.photo_file_url}'] > " +
                "img[src='#{photo.photo_file_url(:thumb)}']"
          end
        end
      end
    end
  end
end
