require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryGirl.create(:admin) }

  before { sign_in user }

  describe "PUT update" do
    before(:each) { @comment = FactoryGirl.create(:comment, text: 'Alpha') }

    describe "with valid attributes" do
      it "locates the requested @comment" do
        put :update, id: @comment, comment: FactoryGirl.attributes_for(:comment)
        expect(assigns(:comment)).to eq(@comment)
      end

      it "changes @comment's attributes" do
        put :update, id: @comment, comment: FactoryGirl.attributes_for(:comment,
            text: 'Bravo')
        @comment.reload
        expect(@comment.text).to eq('Bravo')
      end

      it "changes 'edited_by_admin' flag" do
        put :update, id: @comment, comment: FactoryGirl.attributes_for(:comment)
        @comment.reload
        expect(@comment.edited_by_admin).to be_truthy
      end

      it "redirects to the updated comment" do
        put :update, id: @comment, comment: FactoryGirl.attributes_for(:comment)
        expect(response).to redirect_to @comment
      end
    end

    describe "with invalid attributes" do
      it "locates the requested @comment" do
        put :update, id: @comment,
            comment: FactoryGirl.attributes_for(:invalid_comment)
        expect(assigns(:comment)).to eq(@comment)
      end

      it "does not change @comment's attributes" do
        put :update, id: @comment,
            comment: FactoryGirl.attributes_for(:invalid_comment)
        @comment.reload
        expect(@comment.text).to eq('Alpha')
      end

      it "does not change 'edited_by_admin' flag" do
        put :update, id: @comment,
            comment: FactoryGirl.attributes_for(:invalid_comment)
        @comment.reload
        expect(@comment.edited_by_admin).to be_falsey
      end

      it "re-renders the edit view" do
        put :update, id: @comment,
            comment: FactoryGirl.attributes_for(:invalid_comment)
        expect(response).to render_template :edit
      end
    end
  end

  describe "POST publish" do
    describe "draft comment" do
      before(:each) { @draft_comment = FactoryGirl.create(:draft_comment) }

      it "locates the requested @draft_comment" do
        post :publish, id: @draft_comment
        expect(assigns(:comment)).to eq(@draft_comment)
      end

      it "changes @draft_comment's publication flag" do
        post :publish, id: @draft_comment
        @draft_comment.reload
        expect(@draft_comment.published).to eq(true)
      end

      it "sets @draft_comment's publication date/time" do
        post :publish, id: @draft_comment
        @draft_comment.reload
        expect(@draft_comment.published_at).not_to be_nil
      end

      it "redirects to the comments list" do
        post :publish, id: @draft_comment
        expect(response).to redirect_to comments_url(locale: I18n.locale)
      end
    end

    describe "published comment" do
      before :each do
        @published_comment = FactoryGirl.create(:published_comment)
        @published_at = @published_comment.published_at
      end

      it "locates the requested @published_comment" do
        post :publish, id: @published_comment
        expect(assigns(:comment)).to eq(@published_comment)
      end

      it "does not change @published_comment's publication date/time" do
        post :publish, id: @published_comment
        @published_comment.reload
        expect(@published_comment.published_at).to eq(@published_at)
      end

      it "redirects to the comments list" do
        post :publish, id: @published_comment
        expect(response).to redirect_to comments_url(locale: I18n.locale)
      end

      it "shows warning" do
        post :publish, id: @published_comment
        expect(flash[:warn]).to be_present
      end
    end
  end

  describe "POST unpublish" do
    describe "published comment" do
      before(:each) do
        @published_comment = FactoryGirl.create(:published_comment)
      end

      it "locates the requested @published_comment" do
        post :unpublish, id: @published_comment
        expect(assigns(:comment)).to eq(@published_comment)
      end

      it "changes @published_comment's publication flag" do
        post :unpublish, id: @published_comment
        @published_comment.reload
        expect(@published_comment.published).to eq(false)
      end

      it "resets @published_comment's publication date/time" do
        post :unpublish, id: @published_comment
        @published_comment.reload
        expect(@published_comment.published_at).to be_nil
      end

      it "redirects to the comments list" do
        post :unpublish, id: @published_comment
        expect(response).to redirect_to comments_url(locale: I18n.locale)
      end
    end

    describe "draft comment" do
      before(:each) { @draft_comment = FactoryGirl.create(:draft_comment) }

      it "locates the requested @draft_comment" do
        post :unpublish, id: @draft_comment
        expect(assigns(:comment)).to eq(@draft_comment)
      end

      it "redirects to the comments list" do
        post :unpublish, id: @draft_comment
        expect(response).to redirect_to comments_url(locale: I18n.locale)
      end

      it "shows warning" do
        post :unpublish, id: @draft_comment
        expect(flash[:warn]).to be_present
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) { @comment = FactoryGirl.create(:comment) }

    it "deletes the comment" do
      expect {
        delete :destroy, id: @comment
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the comments list" do
      delete :destroy, id: @comment
      expect(response).to redirect_to comments_url(locale: I18n.locale)
    end
  end
end
