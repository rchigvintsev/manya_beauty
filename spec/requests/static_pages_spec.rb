require 'rails_helper'

RSpec.describe "StaticPages", :type => :request do
  subject { page }

  describe "Home page" do
    before { visit root_path }
  end
end
