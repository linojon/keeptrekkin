
def sign_in( hiker: nil )
  hiker ||= create( :hiker, :with_user )
  mock_facebook_omniauth name: hiker.name, email: hiker.email
  visit '/auth/facebook'
  hiker
end
