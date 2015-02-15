require 'rails_helper'

RSpec.describe Category, :type => :model do
  before { @category = Category.new(name: 'Test Category') }

  subject { @category }

  it { should respond_to :name }
  it { should respond_to :photo_albums }

  it { should be_valid }

  describe "when name is not present" do
    before { @category.name = " " }

    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      category_with_same_name = @category.dup
      category_with_same_name.save
    end

    it { should_not be_valid }
  end
end
