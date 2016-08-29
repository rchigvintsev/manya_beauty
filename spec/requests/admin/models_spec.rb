require 'rails_helper'

RSpec.describe 'Admin::Models', :type => :request do
  subject { page }

  let(:user) { FactoryGirl.create(:admin) }

  before do
    3.times { FactoryGirl.create(:model) }

    visit user_session_path
    sign_in user
    visit admin_models_path
  end

  it_should_behave_like 'all admin pages'

  it { should have_selector '.admin-table.models' }

  it 'should render all models' do
    Model.paginate(page: 1).each do |model|
      expect(page).to have_content model.id
      expect(page).to have_content model.name
      expect(page).to have_content model.photo_album.name
    end
  end

  describe 'model table controls' do
    it { should have_link I18n.t('actions.create'), href: new_admin_model_path(locale: I18n.locale) }
    it { should have_link I18n.t('actions.edit'), href: '#' }
    it { should have_link I18n.t('actions.delete'), href: '#' }

    it { should have_selector 'a.btn-edit.hidden' }
    it { should have_selector 'a.btn-delete.hidden' }
  end

  describe 'show model' do
    let(:first_model) { Model.first }

    before { visit admin_model_path(first_model) }

    it { should have_content first_model.name }
    it { should have_content first_model.description }
    it { should have_content first_model.photo_album.name }
    it { should have_link I18n.t('actions.edit'), href: edit_admin_model_path(first_model, locale: I18n.locale) }
    it { should have_link I18n.t('actions.cancel'), href: admin_models_path(locale: I18n.locale) }
  end

  describe 'create model' do
    before { click_link I18n.t('actions.create') }

    let(:submit) { I18n.t('actions.create') }

    it { should have_content I18n.t('model.creating') }
    it { should have_selector "form[action='#{admin_models_path(locale: I18n.locale)}']" }

    describe 'with invalid params' do
      it 'should not create a model' do
        expect { click_button submit }.not_to change(Model, :count)
      end

      describe 'after submission' do
        before { click_button submit }

        it { should have_content I18n.t('model.creating') }
        it { should have_selector 'form .alert.alert-danger' }
      end
    end

    describe 'with valid params' do
      before { fill_in I18n.t('activerecord.attributes.model.name'), with: 'Test Model' }

      it 'should create a model' do
        expect { click_button submit }.to change(Model, :count).by(1)
      end

      describe 'after saving the model' do
        before { click_button submit }

        it { should have_content I18n.t('model.flash.actions.create.notice') }
        it { should have_selector '.admin-table.models' }
      end
    end
  end
end
