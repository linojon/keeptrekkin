# https://github.com/intridea/omniauth/wiki/Integration-Testing

def facebook_omniauth_hash( name:'Joe Example', email:'joe@example.com' )
  OmniAuth::AuthHash.new({
    provider: 'facebook',
    uid: '12345',
    info: {
      name: name,
      email: email,
      image: '/assets/profile-small.jpg' #'http://graph.facebook.com/10203290081348033/picture?type=square'
    },
    credentials: {
      token: 'ABCtokenXYZ',
      expires_at: 1407992939
    }
  })
end

OmniAuth.config.test_mode = true

def mock_facebook_omniauth( name: 'Joe Example', email: 'joe@example.com')
  OmniAuth.config.mock_auth[:facebook] = facebook_omniauth_hash( name:name, email:email)
end

