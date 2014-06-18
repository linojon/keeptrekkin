require 'rails_helper'

feature 'attach hiker to trip' do

  # background
  #   editing a trip
  #   press add hiker

  xscenario "from list of my hiker friends" 
    # check box adds to top list
    # cancel
    # done attaches all selected

  xscenario "search all hikers by name / email"
    # search box
    # loose match names
    # loose match emails
    # click attaches & done (only 1 at a time)
    # cancel

  xscenario "invite new hiker" # trello
    # insearch all, if valid email and no matches 
    # prompt for email, infer/edit name
    # click Add
    # create hiker
    # sends email

  xscenario "from FB friends"
    # check box adds to top list
    # cancel
    # done

  xscenario 'attaching hiker send email "Youve been attached"'

end