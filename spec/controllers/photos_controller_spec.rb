require 'rails_helper'

RSpec.describe PhotosController, :type => :controller do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:admin) }
  let(:photo_album) { FactoryGirl.create(:photo_album) }
  let(:model) { FactoryGirl.create(:model, photo_album: photo_album) }
  let(:photo_params) do
    {
      title: 'Test Photo',
      photo_file: fixture_file_upload('files/dirt-bike-690770.jpg', 'image/jpg'),
      model_id: model.id
    }
  end
  let(:invalid_photo_params) {{ title: 'Test Photo' }}

  before { sign_in user }

  describe "POST create" do
    describe "with valid attributes" do
      it "creates a new photo" do
        expect {
          post :create, photo: photo_params
        }.to change(Photo, :count).by(1)
      end

      it "redirects to the photos list" do
        post :create, photo: photo_params
        expect(response).to redirect_to photos_url(locale: I18n.locale)
      end
    end

    describe "with invalid attributes" do
      it "does not save the new photo" do
        expect {
          post :create, photo: invalid_photo_params
        }.not_to change(Photo, :count)
      end

      it "re-renders the new view" do
        post :create, photo: invalid_photo_params
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    before(:each) { @photo = FactoryGirl.create(:photo, title: 'Alpha') }

    describe "with valid attributes" do
      it "locates the requested @photo" do
        put :update, id: @photo, photo: FactoryGirl.attributes_for(:photo)
        expect(assigns(:photo)).to eq(@photo)
      end

      it "changes @photo's attributes" do
        put :update, id: @photo, photo: FactoryGirl.attributes_for(:photo,
            title: 'Bravo')
        @photo.reload
        expect(@photo.title).to eq('Bravo')
      end

      it "redirects to the updated photo" do
        put :update, id: @photo, photo: FactoryGirl.attributes_for(:photo)
        expect(response).to redirect_to @photo
      end
    end

    describe "with invalid attributes" do
      it "locates the requested @photo" do
        put :update, id: @photo, photo: FactoryGirl.attributes_for(:invalid_photo)
        expect(assigns(:photo)).to eq(@photo)
      end

      it "does not change @photo's attributes" do
        put :update, id: @photo, photo: FactoryGirl.attributes_for(:invalid_photo)
        @photo.reload
        expect(@photo.title).to eq('Alpha')
      end

      it "re-renders the edit view" do
        put :update, id: @photo, photo: FactoryGirl.attributes_for(:invalid_photo)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) { @photo = FactoryGirl.create(:photo) }

    it "deletes the photo" do
      expect {
        delete :destroy, id: @photo
      }.to change(Photo, :count).by(-1)
    end

    it "redirects to the photos list" do
      delete :destroy, id: @photo
      expect(response).to redirect_to photos_url(locale: I18n.locale)
    end
  end
end
