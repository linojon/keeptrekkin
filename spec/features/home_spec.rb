require 'rails_helper'

describe 'home page' do
  context 'public' do
    before :each do
      visit '/'
    end

    describe 'navbar' do
      it "displays the site name" do
        expect(page).to have_selector("nav a.navbar-brand", text: "My 4000 Footers")
      end
    end

  end
end