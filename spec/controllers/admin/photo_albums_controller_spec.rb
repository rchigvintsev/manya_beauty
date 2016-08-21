require 'rails_helper'

RSpec.describe Admin::PhotoAlbumsController, :type => :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryGirl.create(:admin) }

  before { sign_in user }

  describe 'GET index' do
    let(:photo_album) { FactoryGirl.create(:photo_album) }

    it 'assigns all photo albums as @photo_albums' do
      get :index
      expect(assigns(:photo_albums)).to eq([photo_album])
    end
  end

  describe 'GET show' do
    let(:photo_album) { FactoryGirl.create(:photo_album) }

    it 'assigns the requested photo album as @photo_album' do
      get :show, {id: photo_album.to_param}
      expect(assigns(:photo_album)).to eq(photo_album)
    end
  end

  describe 'GET new' do
    it 'assigns a new photo_album as @photo_album' do
      get :new
      expect(assigns(:photo_album)).to be_a_new(PhotoAlbum)
    end
  end

  describe 'GET edit' do
    let(:photo_album) { FactoryGirl.create(:photo_album) }

    it 'assigns the requested photo album as @photo_album' do
      get :edit, {id: photo_album.to_param}
      expect(assigns(:photo_album)).to eq(photo_album)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new photo album' do
        expect {
          post :create, photo_album: FactoryGirl.attributes_for(:photo_album)
        }.to change(PhotoAlbum, :count).by(1)
      end

      it 'redirects to the photo albums list' do
        post :create, photo_album: FactoryGirl.attributes_for(:photo_album)
        expect(response).to redirect_to admin_photo_albums_url(locale: I18n.locale)
      end
    end

    describe 'with invalid params' do
      it 'does not save a new photo album' do
        expect {
          post :create, photo_album: FactoryGirl.attributes_for(:invalid_photo_album)
        }.not_to change(PhotoAlbum, :count)
      end

      it "re-renders the 'new' template" do
        post :create, photo_album: FactoryGirl.attributes_for(:invalid_photo_album)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    let(:photo_album) { FactoryGirl.create(:photo_album, name: 'Alpha') }

    describe 'with valid params' do
      it 'locates the requested photo_album' do
        put :update, id: photo_album, photo_album: FactoryGirl.attributes_for(:photo_album)
        expect(assigns(:photo_album)).to eq(photo_album)
      end

      it 'updates the requested photo album' do
        put :update, id: photo_album, photo_album: FactoryGirl.attributes_for(:photo_album, name: 'Bravo')
        photo_album.reload
        expect(photo_album.name).to eq('Bravo')
      end

      it 'redirects to the photo album' do
        put :update, id: photo_album, photo_album: FactoryGirl.attributes_for(:photo_album)
        expect(response).to redirect_to admin_photo_album_url(photo_album)
      end
    end

    describe 'with invalid params' do
      it 'locates the requested photo album' do
        put :update, id: photo_album, photo_album: FactoryGirl.attributes_for(:invalid_photo_album)
        expect(assigns(:photo_album)).to eq(photo_album)
      end

      it 'does not change the requested photo album' do
        put :update, id: photo_album, photo_album: FactoryGirl.attributes_for(:invalid_photo_album)
        photo_album.reload
        expect(photo_album.name).to eq('Alpha')
      end

      it "re-renders the 'edit' template" do
        put :update, id: photo_album, photo_album: FactoryGirl.attributes_for(:invalid_photo_album)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:photo_album) { FactoryGirl.create(:photo_album) }

    it 'deletes the requested photo album' do
      expect {
        delete :destroy, id: photo_album
      }.to change(PhotoAlbum, :count).by(-1)
    end

    it 'redirects to the photo albums list' do
      delete :destroy, id: photo_album
      expect(response).to redirect_to admin_photo_albums_url(locale: I18n.locale)
    end
  end
end
