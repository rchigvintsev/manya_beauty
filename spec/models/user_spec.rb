require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:is_admin) }

  it { should be_valid }

  describe "with blank email" do
    before { @user.email = '' }

    it { should_not be_valid }
  end

  describe "when is_admin attribute is nil" do
    before { @user.is_admin = nil }

    it { should_not be_valid }
  end
end
