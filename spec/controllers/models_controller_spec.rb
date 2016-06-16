require 'rails_helper'

RSpec.describe ModelsController, :type => :controller do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:admin) }
  let(:photo_album) { FactoryGirl.create(:photo_album) }

  let(:valid_attributes) { {
      name: 'Test Model',
      photo_album_id: photo_album.id
  } }

  let(:invalid_attributes) { {
      name: nil,
      photo_album_id: nil
  } }

  before { sign_in user }

  describe 'GET index' do
    let(:model) { FactoryGirl.create(:model) }

    it 'assigns all models as @models' do
      get :index
      expect(assigns(:models)).to eq([model])
    end
  end

  describe 'GET show' do
    let(:model) { FactoryGirl.create(:model) }

    it 'assigns the requested model as @model' do
      get :show, {id: model.to_param}
      expect(assigns(:model)).to eq(model)
    end
  end

  describe 'GET new' do
    it 'assigns a new model as @model' do
      get :new
      expect(assigns(:model)).to be_a_new(Model)
    end
  end

  describe 'GET edit' do
    let(:model) { FactoryGirl.create(:model) }

    it 'assigns the requested model as @model' do
      get :edit, {id: model.to_param}
      expect(assigns(:model)).to eq(model)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Model' do
        expect {
          post :create, {model: valid_attributes}
        }.to change(Model, :count).by(1)
      end

      it 'assigns a newly created model as @model' do
        post :create, {model: valid_attributes}
        expect(assigns(:model)).to be_a(Model)
        expect(assigns(:model)).to be_persisted
      end

      it 'redirects to the models list' do
        post :create, {model: valid_attributes}
        expect(response).to redirect_to(models_url(locale: I18n.locale))
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved model as @model' do
        post :create, {model: invalid_attributes}
        expect(assigns(:model)).to be_a_new(Model)
      end

      it "re-renders the 'new' template" do
        post :create, {model: invalid_attributes}
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    before(:each) { @model = FactoryGirl.create(:model) }

    describe 'with valid params' do
      let(:new_photo_album) { FactoryGirl.create(:photo_album) }

      let(:new_attributes) { {
          name: 'New Name',
          description: 'New description',
          photo_album_id: new_photo_album.id
      } }

      it 'updates the requested model' do
        put :update, {id: @model.to_param, model: new_attributes}
        @model.reload
        expect(@model.name).to eq('New Name')
        expect(@model.description).to eq('New description')
        expect(@model.photo_album).to eq(new_photo_album)
      end

      it 'assigns the requested model as @model' do
        put :update, {id: @model.to_param, model: valid_attributes}
        expect(assigns(:model)).to eq(@model)
      end

      it 'redirects to the model' do
        put :update, {id: @model.to_param, model: valid_attributes}
        expect(response).to redirect_to(@model)
      end
    end

    describe 'with invalid params' do
      it 'assigns the model as @model' do
        put :update, {id: @model.to_param, model: invalid_attributes}
        expect(assigns(:model)).to eq(@model)
      end

      it "re-renders the 'edit' template" do
        put :update, {id: @model.to_param, model: invalid_attributes}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) { @model = FactoryGirl.create(:model) }

    it 'destroys the requested model' do
      expect {
        delete :destroy, {id: @model.to_param}
      }.to change(Model, :count).by(-1)
    end

    it 'redirects to the models list' do
      delete :destroy, {id: @model.to_param}
      expect(response).to redirect_to(models_url(locale: I18n.locale))
    end
  end
end
