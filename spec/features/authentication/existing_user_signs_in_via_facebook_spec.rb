require 'rails_helper'

feature 'Existing user signs in via Facebook' do
  let(:hiker) { create :hiker, :with_user }

  background do
    mock_facebook_omniauth name: hiker.name, email: hiker.email
    visit '/'
    click_on 'Sign in via Facebook'
  end

  it "redirects to dashboard" do
    expect(current_url).to include '/dashboard'
  end
end
