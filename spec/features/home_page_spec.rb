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
      xit 'has link to mountains'
      xit 'has link to trips'
    end
  end

  context 'signed in' do
    describe 'navbar' do
      describe 'user settings' do
        xit 'has user chip'
        xit 'has profile link'
        xit 'has sign out link'
      end
      describe 'notifications' do
        xit 'has notifications icon'
      end
    end
  end

end