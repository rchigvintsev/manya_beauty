require 'rails_helper'

RSpec.describe "StaticPages", :type => :request do
  subject { page }

  describe "main menu" do
    it "should add 'active' CSS class to current page menu item" do
      visit root_path
      should have_selector('li.active', text: I18n.translate('home'))
      should_not have_selector('li.active', text: I18n.translate('about'))

      visit about_path
      should have_selector('li.active', text: I18n.translate('about'))
      should_not have_selector('li.active', text: I18n.translate('home'))
    end
  end

  describe "Home page" do
    before { visit root_path }

    describe "greeting" do
      it { should have_content(I18n.translate('greeting')) }
    end

    describe "jCarousel" do
      it { should have_selector('div.jcarousel-wrapper > .jcarousel > ul > li > img') }
      it { should have_selector('div.jcarousel-wrapper > a.jcarousel-prev') }
      it { should have_selector('div.jcarousel-wrapper > a.jcarousel-next') }
    end
  end
end
