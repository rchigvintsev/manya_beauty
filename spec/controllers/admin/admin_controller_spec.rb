require 'rails_helper'

RSpec.describe Admin::AdminController, :type => :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryGirl.create(:admin) }

  before { sign_in user }

  describe 'GET index' do
  end
end
