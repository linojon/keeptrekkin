require 'rails_helper'

feature 'User adds photos to trip', js: true, areyousure: true do
  scenario 'new trip, no photos'
  scenario 'new trip, additional photos'
  scenario 'uploads photo as temporary and shows thumbnail'
  scenario 'can remove unsaved photo'
  scenario 'saves photos when saved'
  scenario 'saved photos belong to trip and current user'

  context 'edit existing' do
    scenario 'can remove existing photo'
    scenario 'can add new photo'
    scenario 'saves'
    scenario 'doesnt save added photos when cancel'
    scenario 'removed files are deleted from database'
  end

end
