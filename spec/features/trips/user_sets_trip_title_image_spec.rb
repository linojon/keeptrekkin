require 'rails_helper'

feature 'User adds photos to trip', js: true, areyousure: true do
  scenario 'can select title image from photos gallery'
  scenario 'sets title image input and shows img'
  scenario 'saves title image reference when saved'
end