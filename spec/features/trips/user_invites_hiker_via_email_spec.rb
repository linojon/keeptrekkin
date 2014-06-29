require 'rails_helper'

feature 'User adds hiker from other users', js: true do
  def fill_in_email_with(email)
    fill_in 'hiker_email', with: email
    page.execute_script("$('#hiker_email').trigger('keyup');") # shouldn't need this
  end

  let!(:trip)    { create :trip, :with_hiker }
  let!(:hiker)   { trip.hikers.first }
  let!(:other)   { create :hiker}
  let(:invite_prompt) { "Would you like to add a hiker who's not on this site yet?" }

  background do
    sign_in hiker
    visit "/trips/#{trip.to_param}/edit"
    find('#enable_edit_hikers').click
    click_on 'Add hiker'
  end

  scenario 'no search match presents Invite button' do
    expect(page).to have_no_content invite_prompt
    fill_in 's2id_autogen2', with: 'xyzzzz' # aka Search field
    expect(page).to have_content invite_prompt
  end

  context "invite dialog" do
    background do
      fill_in 's2id_autogen2', with: 'xyzzzz' # aka Search field
      click_on 'Invite'
    end     

    scenario 'invite button prompts for email' do
      within "#invite_hiker_dialog" do
        expect(page).to have_selector('input#hiker_email')
      end
    end

    scenario 'only valid email format is accepted' do
      within "#invite_hiker_dialog" do
        fill_in_email_with 'linojon@gmail.com' 
        expect(page).to have_selector '#hiker_name'        
 
        # name input is hidden
        fill_in_email_with 'linojon'
        expect(page).to have_no_selector '#hiker_name'        
        fill_in_email_with 'linojon'
        expect(page).to have_no_selector '#hiker_name'        
        fill_in_email_with 'linojon'
        expect(page).to have_no_selector '#hiker_name'  

        # invite button is disabled
        btn = find('input#invite_hiker_submit')
        expect(btn[:disabled]).to eql 'true'

        fill_in_email_with 'linojon@gmail.com'
        expect(page).to have_selector '#hiker_name'        
      end
    end

    scenario 'valid format email enables Name input and Send button' do
      within "#invite_hiker_dialog" do
        fill_in_email_with 'linojon@gmail.com'
        expect(page).to have_selector('input#hiker_name')
      end
      btn = find('input#invite_hiker_submit')
      expect(btn[:disabled]).to_not eql 'true'
    end

    scenario 'Name input default derived from email address' do
      within "#invite_hiker_dialog" do
        fill_in_email_with 'linojon@gmail.com'
        expect(page).to have_field('hiker_name', with: 'Linojon')
      end
    end

    scenario 'Send button adds user to Trip'
      # adds to select list options
      # adds option as selected

    scenario 'Send doesnt allow duplicate hiker in trip or in list'


    scenario 'Send queues email notice'
  end
end
