require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:admin) }

  before { sign_in user }

  describe "POST create" do
    describe "with valid attributes" do
      it "creates a new category" do
        expect {
          post :create, category: FactoryGirl.attributes_for(:category)
        }.to change(Category, :count).by(1)
      end

      it "redirects to the categories list" do
        post :create, category: FactoryGirl.attributes_for(:category)
        expect(response).to redirect_to categories_url(locale: I18n.locale)
      end
    end

    describe "with invalid attributes" do
      it "does not save the new category" do
        expect {
          post :create, category: FactoryGirl.attributes_for(:invalid_category)
        }.not_to change(Category, :count)
      end

      it "re-renders the new view" do
        post :create, category: FactoryGirl.attributes_for(:invalid_category)
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    before :each do
      @category = FactoryGirl.create(:category, name: 'Alpha')
    end

    describe "with valid attributes" do
      it "locates the requested @category" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category)
        expect(assigns(:category)).to eq(@category)
      end

      it "changes @category's attributes" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category,
            name: 'Bravo')
        @category.reload
        expect(@category.name).to eq('Bravo')
      end

      it "redirects to the updated category" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category)
        expect(response).to redirect_to @category
      end
    end

    describe "with invalid attributes" do
      it "locates the requested @category" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:invalid_category)
        expect(assigns(:category)).to eq(@category)
      end

      it "does not change @category's attributes" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:invalid_category)
        @category.reload
        expect(@category.name).to eq('Alpha')
      end

      it "re-renders the edit view" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:invalid_category)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) { @category = FactoryGirl.create(:category) }

    it "deletes the category" do
      expect {
        delete :destroy, id: @category
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      delete :destroy, id: @category
      expect(response).to redirect_to categories_url(locale: I18n.locale)
    end
  end
end
