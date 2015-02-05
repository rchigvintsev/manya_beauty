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
    before { visit gallery_path }

    describe "main menu" do
      describe "Gallery page menu item should be activated" do
        it { should have_selector('li.active', text: I18n.translate('gallery')) }
        it { should_not have_selector('li.active', text: I18n.translate('home')) }
      end
    end
  end
end
