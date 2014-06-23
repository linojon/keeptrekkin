# https://github.com/intridea/omniauth/wiki/Integration-Testing

def facebook_omniauth_hash( name, email )
  OmniAuth::AuthHash.new({
    provider: 'Facebook',
    uid: '123545',
    info: {
      name: name,
      email: email,
      image: 'http://graph.facebook.com/10203290081348033/picture?type=square'
    },
    credentials: {
      token: 'ABCtokenXYZ',
      expires_at: 1407992939
    }
  })
end

OmniAuth.config.test_mode = true

def mock_facebook_omniauth( name: 'Joe Example', email: 'joe@example.com')
  OmniAuth.config.mock_auth[:facebook] = facebook_omniauth_hash( name, email)
end

