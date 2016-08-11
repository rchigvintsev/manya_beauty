require 'rails_helper'

RSpec.describe 'PhotoAlbums', :type => :request do
  subject { page }

  let(:user) { FactoryGirl.create(:admin) }

  before do
    3.times { FactoryGirl.create(:photo_album) }

    visit user_session_path
    sign_in user
    visit admin_photo_albums_path
  end

  it_should_behave_like 'all admin pages'

  it { should have_selector '.admin-table.photo-albums' }

  it 'should render all photo albums' do
    PhotoAlbum.paginate(page: 1).each do |photo_album|
      expect(page).to have_content photo_album.id
      expect(page).to have_content photo_album.name
    end
  end

  describe 'photo album table controls' do
    it { should have_link I18n.t('actions.create'), href: new_admin_photo_album_path(locale: I18n.locale) }
    it { should have_link I18n.t('actions.edit'), href: '#' }
    it { should have_link I18n.t('actions.delete'), href: '#' }

    it { should have_selector 'a.btn-edit.hidden' }
    it { should have_selector 'a.btn-delete.hidden' }
  end

  describe 'show photo album' do
    let(:first_photo_album) { PhotoAlbum.first }

    before { visit admin_photo_album_path(first_photo_album) }

    it { should have_content first_photo_album.name }
    it { should have_content first_photo_album.description }
    it { should have_link I18n.t('actions.edit'),
                          href: edit_admin_photo_album_path(first_photo_album, locale: I18n.locale) }
    it { should have_link I18n.t('actions.cancel'),
                          href: admin_photo_albums_path(locale: I18n.locale) }
  end

  describe 'create photo album' do
    let(:submit) { I18n.t('actions.create') }

    before { click_link I18n.t('actions.create') }

    it { should have_content I18n.t('photo_album.creating') }
    it { should have_selector "form[action='#{admin_photo_albums_path(locale: I18n.locale)}']" }

    describe 'with invalid information' do
      it 'should not create photo album' do
        expect { click_button submit }.not_to change(PhotoAlbum, :count)
      end

      describe 'after submission' do
        before { click_button submit }

        it { should have_content I18n.t('photo_album.creating') }
        it { should have_selector 'form .alert.alert-danger' }
      end
    end

    describe 'with valid information' do
      before { fill_in I18n.t('activerecord.attributes.photo_album.name'), with: 'Test Photo Album' }

      it 'should create photo album' do
        expect { click_button submit }.to change(PhotoAlbum, :count).by(1)
      end

      describe 'after submission' do
        before { click_button submit }

        it { should have_content I18n.t('photo_album.flash.actions.create.notice') }
        it { should have_selector '.admin-table.photo-albums' }
      end
    end
  end
end
