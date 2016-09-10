require 'rails_helper'

RSpec.describe Admin::CommentsController, :type => :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryGirl.create(:admin) }

  let(:valid_attributes) { {text: 'Test text'} }
  let(:invalid_attributes) { {text: nil} }

  before { sign_in user }

  describe 'GET index' do
    let(:comment) { FactoryGirl.create(:comment) }

    it 'assigns all comments as @comments' do
      get :index
      expect(assigns(:comments)).to eq([comment])
    end
  end

  describe 'GET show' do
    let(:comment) { FactoryGirl.create(:comment) }

    it 'assigns the requested comment as @comment' do
      get :show, {id: comment.to_param}
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe 'GET edit' do
    let(:comment) { FactoryGirl.create(:comment) }

    it 'assigns the requested comment as @comment' do
      get :edit, {id: comment.to_param}
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe 'PUT update' do
    before(:each) { @comment = FactoryGirl.create(:comment) }

    describe 'with valid params' do
      let(:new_comment) { FactoryGirl.create(:comment) }
      let(:new_attributes) { {text: 'New text'} }

      it 'updates the requested comment' do
        put :update, {id: @comment.to_param, comment: new_attributes}
        @comment.reload
        expect(@comment.text).to eq('New text')
        expect(@comment.edited_by_admin).to be_truthy
      end

      it 'assigns the requested comment as @comment' do
        put :update, {id: @comment.to_param, comment: valid_attributes}
        expect(assigns(:comment)).to eq(@comment)
      end

      it 'redirects to the comment' do
        put :update, {id: @comment.to_param, comment: valid_attributes}
        expect(response).to redirect_to(admin_comment_url(@comment))
      end
    end

    describe 'with invalid params' do
      it 'assigns the comment as @comment' do
        put :update, {id: @comment.to_param, comment: invalid_attributes}
        expect(assigns(:comment)).to eq(@comment)
      end

      it "re-renders the 'edit' template" do
        put :update, {id: @comment.to_param, comment: invalid_attributes}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'POST publish' do
    describe 'draft comment' do
      before(:each) { @draft_comment = FactoryGirl.create(:draft_comment) }

      it 'assigns the requested comment as @draft_comment' do
        post :publish, id: @draft_comment
        expect(assigns(:comment)).to eq(@draft_comment)
      end

      it 'changes publication flag' do
        post :publish, id: @draft_comment
        @draft_comment.reload
        expect(@draft_comment.published).to eq(true)
      end

      it 'sets publication date/time' do
        post :publish, id: @draft_comment
        @draft_comment.reload
        expect(@draft_comment.published_at).not_to be_nil
      end

      it 'redirects to the comments list' do
        post :publish, id: @draft_comment
        expect(response).to redirect_to admin_comments_url(locale: I18n.locale)
      end
    end

    describe 'published comment' do
      before(:each) { @published_comment = FactoryGirl.create(:published_comment) }

      it 'assigns the requested comment as @published_comment' do
        post :publish, id: @published_comment
        expect(assigns(:comment)).to eq(@published_comment)
      end

      it 'does not change publication date/time' do
        post :publish, id: @published_comment
        @published_comment.reload
        expect(@published_comment.published_at).to eq(@published_comment.published_at)
      end

      it 'redirects to the comments list' do
        post :publish, id: @published_comment
        expect(response).to redirect_to admin_comments_url(locale: I18n.locale)
      end

      it 'shows warning' do
        post :publish, id: @published_comment
        expect(flash[:warn]).to be_present
      end
    end
  end

  describe 'POST unpublish' do
    describe 'published comment' do
      before(:each) { @published_comment = FactoryGirl.create(:published_comment) }

      it 'assigns the requested comment as @published_comment' do
        post :unpublish, id: @published_comment
        expect(assigns(:comment)).to eq(@published_comment)
      end

      it 'changes publication flag' do
        post :unpublish, id: @published_comment
        @published_comment.reload
        expect(@published_comment.published).to eq(false)
      end

      it 'resets publication date/time' do
        post :unpublish, id: @published_comment
        @published_comment.reload
        expect(@published_comment.published_at).to be_nil
      end

      it 'redirects to the comments list' do
        post :unpublish, id: @published_comment
        expect(response).to redirect_to admin_comments_url(locale: I18n.locale)
      end
    end

    describe 'draft comment' do
      before(:each) { @draft_comment = FactoryGirl.create(:draft_comment) }

      it 'assigns the requested comment as @draft_comment' do
        post :unpublish, id: @draft_comment
        expect(assigns(:comment)).to eq(@draft_comment)
      end

      it 'redirects to the comments list' do
        post :unpublish, id: @draft_comment
        expect(response).to redirect_to admin_comments_url(locale: I18n.locale)
      end

      it 'shows warning' do
        post :unpublish, id: @draft_comment
        expect(flash[:warn]).to be_present
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) { @comment = FactoryGirl.create(:comment) }

    it 'destroys the requested comment' do
      expect {
        delete :destroy, id: @comment
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to the comments list' do
      delete :destroy, id: @comment
      expect(response).to redirect_to admin_comments_url(locale: I18n.locale)
    end
  end
end
