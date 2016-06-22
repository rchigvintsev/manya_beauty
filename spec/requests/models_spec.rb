require 'rails_helper'

RSpec.describe 'Models', :type => :request do
  subject { page }

  let(:user) { FactoryGirl.create(:admin) }

  before do
    visit user_session_path
    sign_in user
  end

  before(:all) { 9.times { FactoryGirl.create(:model) } }
  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  describe 'GET /models' do
    before { click_link I18n.translate('models') }

    it { should have_selector '.dashboard-table.models' }

    it 'should render all models' do
      Model.paginate(page: 1).each do |model|
        expect(page).to have_content model.id
        expect(page).to have_content model.name
        expect(page).to have_content model.photo_album.name
      end
    end

    describe 'controls' do
      it { should have_link I18n.translate('actions.create'), href: new_model_path(locale: I18n.locale) }
      it { should have_link I18n.translate('actions.edit'), href: '#' }
      it { should have_link I18n.translate('actions.delete'), href: '#' }

      it { should have_selector 'a.btn-edit.hidden' }
      it { should have_selector 'a.btn-delete.hidden' }
    end

    describe 'creating new model' do
      before { click_link I18n.translate('actions.create') }

      let(:submit) { I18n.translate('actions.create') }

      it { should have_content I18n.translate('model.creating') }
      it { should have_selector "form[action='#{models_path(locale: I18n.locale)}']" }

      describe 'with invalid params' do
        it 'should not create a model' do
          expect { click_button submit }.not_to change(Model, :count)
        end

        describe 'after submission' do
          before { click_button submit }

          it { should have_content I18n.translate('model.creating') }
          it { should have_selector 'form .alert.alert-danger' }
        end
      end

      describe 'with valid params' do
        before { fill_in I18n.translate('activerecord.attributes.model.name'), with: 'Test Model' }

        it 'should create a model' do
          expect { click_button submit }.to change(Model, :count).by(1)
        end

        describe 'after saving the model' do
          before { click_button submit }

          it { should have_content I18n.translate('model.flash.actions.create.notice') }
          it { should have_selector '.dashboard-table.models' }
        end
      end
    end
  end
end
