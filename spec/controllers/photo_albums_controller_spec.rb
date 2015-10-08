require 'rails_helper'

RSpec.describe PhotoAlbumsController, :type => :controller do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:admin) }

  before { sign_in user }

  describe "POST create" do
    describe "with valid attributes" do
      it "creates a new photo album" do
        expect {
          post :create, photo_album: FactoryGirl.attributes_for(:photo_album)
        }.to change(PhotoAlbum, :count).by(1)
      end

      it "redirects to the photo albums list" do
        post :create, photo_album: FactoryGirl.attributes_for(:photo_album)
        expect(response).to redirect_to photo_albums_url(locale: I18n.locale)
      end
    end

    describe "with invalid attributes" do
      it "does not save the new photo album" do
        expect {
          post :create, photo_album: FactoryGirl.attributes_for(:invalid_photo_album)
        }.not_to change(PhotoAlbum, :count)
      end

      it "re-renders the new view" do
        post :create, photo_album: FactoryGirl.attributes_for(:invalid_photo_album)
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    before :each do
      @photo_album = FactoryGirl.create(:photo_album, name: 'Alpha')
    end

    describe "with valid attributes" do
      it "locates the requested @photo_album" do
        put :update, id: @photo_album, photo_album: FactoryGirl.attributes_for(:photo_album)
        expect(assigns(:photo_album)).to eq(@photo_album)
      end

      it "changes @photo_album's attributes" do
        put :update, id: @photo_album, photo_album: FactoryGirl.attributes_for(:photo_album,
            name: 'Bravo')
        @photo_album.reload
        expect(@photo_album.name).to eq('Bravo')
      end

      it "redirects to the updated photo album" do
        put :update, id: @photo_album, photo_album: FactoryGirl.attributes_for(:photo_album)
        expect(response).to redirect_to @photo_album
      end
    end

    describe "with invalid attributes" do
      it "locates the requested @photo_album" do
        put :update, id: @photo_album, photo_album: FactoryGirl.attributes_for(:invalid_photo_album)
        expect(assigns(:photo_album)).to eq(@photo_album)
      end

      it "does not change @photo_album's attributes" do
        put :update, id: @photo_album, photo_album: FactoryGirl.attributes_for(:invalid_photo_album)
        @photo_album.reload
        expect(@photo_album.name).to eq('Alpha')
      end

      it "re-renders the edit view" do
        put :update, id: @photo_album, photo_album: FactoryGirl.attributes_for(:invalid_photo_album)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) { @photo_album = FactoryGirl.create(:photo_album) }

    it "deletes the photo album" do
      expect {
        delete :destroy, id: @photo_album
      }.to change(PhotoAlbum, :count).by(-1)
    end

    it "redirects to the photo albums list" do
      delete :destroy, id: @photo_album
      expect(response).to redirect_to photo_albums_url(locale: I18n.locale)
    end
  end
end
