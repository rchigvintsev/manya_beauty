require 'rails_helper'

RSpec.describe "StaticPages", :type => :request do
  subject { page }

  shared_examples_for "all static pages" do
    describe "header" do
      it { should have_selector('div.logo > a', text: I18n.translate('brand')) }

      it "should have main menu with three items" do
        expect(find 'ul.main-menu').to have_selector('li', count: 3)
      end
    end

    describe "footer" do
      describe "copyright" do
        it { should have_content "#{I18n.translate('brand')} \u00A9 #{Time.now.year}" }
      end

      describe "locale" do
        it { should have_link 'RU' }
        it { should have_link 'EN' }
      end
    end
  end

  shared_examples_for "page with about info" do
    it { should have_selector "img[src*='avatar.png']" }
    it { should have_content I18n.translate('about.header') }
    it { should have_content I18n.translate('about.content')[0..150] }
  end

  describe "Home page" do
    let!(:favorite_photo) { FactoryGirl.create(:photo, favorite: true) }

    before { visit root_path }

    it_should_behave_like "all static pages"
    it_should_behave_like "page with about info"

    describe "main menu" do
      describe "Home page menu item should be activated" do
        it { should have_selector('li.active', text: I18n.translate('home_page')) }
        it { should_not have_selector('li.active', text: I18n.translate('gallery_page')) }
      end
    end

    describe "OWL Carousel" do
      it { should have_selector('.carousel-container #owl_carousel > .item > .slide',
          count: 3) }

      it { should have_selector('.carousel-container .hero > h1',
          text: I18n.translate('author_name')) }
      it { should have_selector('.carousel-container .hero > h2',
          text: I18n.translate('specialization')) }

      describe "translation" do
        describe "for english locale" do
          before do
            click_link 'EN'
          end

          it { should have_selector('.carousel-container .hero > h1',
              text: I18n.translate('author_name', locale: 'en')) }
          it { should_not have_selector('.carousel-container .hero > h1',
              text: I18n.translate('author_name', locale: 'ru')) }
        end

        describe "for russian locale" do
          before do
            click_link 'RU'
          end

          it { should have_selector('.carousel-container .hero > h1',
              text: I18n.translate('author_name', locale: 'ru')) }
          it { should_not have_selector('.carousel-container .hero > h1',
              text: I18n.translate('author_name', locale: 'en')) }
        end

        describe "for wrong locale" do
          before do
            visit root_path(locale: 'wrong')
          end

          it "should render warning" do
            expect(page).to have_content
                I18n.translate('locale_not_supported', unsupported_locale: 'wrong')
          end
        end
      end
    end

    describe "favorite photos" do
      it { should have_content I18n.translate('photo_album.favorite.name') }
      it { should have_selector "a[style='background-image: url(#{favorite_photo.photo_file_url(:thumb)})']" }
    end
  end

  describe "Gallery page" do
    before(:all) do
      15.times do
        photo_album = FactoryGirl.create(:photo_album)
        7.times do |i|
          photo = FactoryGirl.create(:photo, photo_album: photo_album,
              favorite: (i % 2 == 0))
        end
      end
    end

    after(:all) do
      DatabaseCleaner.clean_with(:truncation)
    end

    before { visit gallery_path }

    it_should_behave_like "all static pages"

    describe "main menu" do
      describe "Gallery page menu item should be activated" do
        it { should have_selector('li.active', text: I18n.translate('gallery_page')) }
        it { should_not have_selector('li.active', text: I18n.translate('home_page')) }
      end
    end

    describe "photo albums" do
      let(:all_photo_albums) { PhotoAlbum.all.unshift FavoritePhotoAlbum.new }

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
                "'#{gallery_photo_album_path(photo_album, locale: I18n.locale)}'] > " +
                "img[src='#{photo_album.photos.first.photo_file_url(:thumb)}']"
          end
        end
      end

      describe "photos" do
        let(:photo_album) { PhotoAlbum.first }

        before { visit gallery_photo_album_path(photo_album) }

        it "should render photo album name" do
          expect(page).to have_content photo_album.name
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

  describe "About page" do
    before { visit about_path }

    it_should_behave_like "all static pages"
    it_should_behave_like "page with about info"

    describe "main menu" do
      describe "About page menu item should be activated" do
        it { should have_selector('li.active', text: I18n.translate('about_page')) }
        it { should_not have_selector('li.active', text: I18n.translate('home_page')) }
      end
    end

    describe "email address" do
      it { should have_link EMAIL, href: "mailto:#{EMAIL}" }
    end
  end
end
