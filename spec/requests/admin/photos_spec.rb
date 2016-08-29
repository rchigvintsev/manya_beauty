require 'rails_helper'

RSpec.describe 'Admin::Photos', :type => :request do
  subject { page }

  let(:user) { FactoryGirl.create(:admin) }

  before do
    3.times { FactoryGirl.create(:photo) }

    visit user_session_path
    sign_in user
    visit admin_photos_path
  end

  it_should_behave_like 'all admin pages'

  it { should have_selector '.admin-table.photos' }

  it 'should render all photos' do
    Photo.paginate(page: 1).each do |photo|
      expect(page).to have_content photo.id
      expect(page).to have_content photo.title
      expect(page).to have_content photo.photo_file
      expect(page).to have_selector "img[src='#{photo.photo_file_url(:thumb)}']"
      expect(page).to have_content photo.model.name
    end
  end

  describe 'photo table controls' do
    it { should have_link I18n.t('actions.create'), href: new_admin_photo_path(locale: I18n.locale) }
    it { should have_link I18n.t('actions.edit'), href: '#' }
    it { should have_link I18n.t('actions.delete'), href: '#' }

    it { should have_selector 'a.btn-edit.hidden' }
    it { should have_selector 'a.btn-delete.hidden' }
  end

  describe 'show photo' do
    let(:first_photo) { Photo.first }

    before { visit admin_photo_path(first_photo) }

    it { should have_content first_photo.title }
    it { should have_content first_photo.description }
    it { should have_content first_photo.photo_file }
    it { should have_selector "img[src='#{first_photo.photo_file_url(:thumb)}']" }
    it { should have_content first_photo.model.name }
    it { should have_link I18n.t('actions.edit'), href: edit_admin_photo_path(first_photo, locale: I18n.locale) }
    it { should have_link I18n.t('actions.cancel'), href: admin_photos_path(locale: I18n.locale) }
  end

  describe 'create photo' do
    before { click_link I18n.t('actions.create') }

    let(:submit) { I18n.t('actions.create') }

    it { should have_content I18n.t('photo.creating') }
    it { should have_selector "form[action='#{admin_photos_path(locale: I18n.locale)}']" }

    describe 'with invalid params' do
      it 'should not create a photo' do
        expect { click_button submit }.not_to change(Photo, :count)
      end

      describe 'after submission' do
        before { click_button submit }

        it { should have_content I18n.t('photo.creating') }
        it { should have_selector 'form .alert.alert-danger' }
      end
    end

    describe 'with valid params' do
      before do
        fill_in I18n.t('activerecord.attributes.photo.title'), with: 'Test Photo'
        attach_file I18n.t('activerecord.attributes.photo.photo_file'),
                    Rails.root + 'spec/fixtures/files/dirt-bike-690770.jpg'
      end

      it 'should create a photo' do
        expect { click_button submit }.to change(Photo, :count).by(1)
      end

      describe 'after saving the photo' do
        before { click_button submit }

        it { should have_content I18n.t('photo.flash.actions.create.notice') }
        it { should have_selector '.admin-table.photos' }
      end
    end
  end
end
