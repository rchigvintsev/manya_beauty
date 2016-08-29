require 'rails_helper'

RSpec.describe Admin::PhotosController, :type => :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryGirl.create(:admin) }
  let(:model) { FactoryGirl.create(:model) }

  let(:valid_attributes) do
    {
        title: 'Test Photo',
        photo_file: fixture_file_upload('files/dirt-bike-690770.jpg', 'image/jpg'),
        model_id: model.id
    }
  end

  let(:invalid_attributes) { {title: nil, model: nil, photo_file: nil} }

  before { sign_in user }

  describe 'GET index' do
    let(:photo) { FactoryGirl.create(:photo) }

    it 'assigns all photos as @photos' do
      get :index
      expect(assigns(:photos)).to eq([photo])
    end
  end

  describe 'GET show' do
    let(:photo) { FactoryGirl.create(:photo) }

    it 'assigns the requested photo as @photo' do
      get :show, {id: photo.to_param}
      expect(assigns(:photo)).to eq(photo)
    end
  end

  describe 'GET new' do
    it 'assigns a new photo as @photo' do
      get :new
      expect(assigns(:photo)).to be_a_new(Photo)
    end
  end

  describe 'GET edit' do
    let(:photo) { FactoryGirl.create(:photo) }

    it 'assigns the requested photo as @photo' do
      get :edit, {id: photo.to_param}
      expect(assigns(:photo)).to eq(photo)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new photo' do
        expect {
          post :create, {photo: valid_attributes}
        }.to change(Photo, :count).by(1)
      end

      it 'assigns a newly created photo as @photo' do
        post :create, {photo: valid_attributes}
        expect(assigns(:photo)).to be_a(Photo)
        expect(assigns(:photo)).to be_persisted
      end

      it 'redirects to the photos list' do
        post :create, {photo: valid_attributes}
        expect(response).to redirect_to(admin_photos_url(locale: I18n.locale))
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved photo as @photo' do
        post :create, {photo: invalid_attributes}
        expect(assigns(:photo)).to be_a_new(Photo)
      end

      it "re-renders the 'new' template" do
        post :create, photo: invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    before(:each) { @photo = FactoryGirl.create(:photo) }

    describe 'with valid params' do
      let(:new_model) { FactoryGirl.create(:model) }

      let(:new_attributes) do
        {
            title: 'New Title',
            description: 'New description',
            model_id: new_model.id
        }
      end

      it 'updates the requested photo' do
        put :update, {id: @photo.to_param, photo: new_attributes}
        @photo.reload
        expect(@photo.title).to eq('New Title')
        expect(@photo.description).to eq('New description')
        expect(@photo.model).to eq(new_model)
      end

      it 'assigns the requested photo as @photo' do
        put :update, {id: @photo.to_param, photo: valid_attributes}
        expect(assigns(:photo)).to eq(@photo)
      end

      it 'redirects to the photo' do
        put :update, {id: @photo.to_param, photo: valid_attributes}
        expect(response).to redirect_to(admin_photo_url(@photo))
      end
    end

    describe 'with invalid params' do
      it 'assigns the photo as @photo' do
        put :update, {id: @photo.to_param, photo: invalid_attributes}
        expect(assigns(:photo)).to eq(@photo)
      end

      it "re-renders the 'edit' template" do
        put :update, {id: @photo.to_param, photo: invalid_attributes}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) { @photo = FactoryGirl.create(:photo) }

    it 'destroys the requested photo' do
      expect {
        delete :destroy, {id: @photo.to_param}
      }.to change(Photo, :count).by(-1)
    end

    it 'redirects to the photos list' do
      delete :destroy, {id: @photo.to_param}
      expect(response).to redirect_to(admin_photos_url(locale: I18n.locale))
    end
  end
end
