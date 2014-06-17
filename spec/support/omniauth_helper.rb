# https://github.com/intridea/omniauth/wiki/Integration-Testing

def facebook_omniauth_hash
  OmniAuth::AuthHash.new({
    provider: 'Facebook',
    uid: '123545',
    info: {
      name: 'Joe Example',
      email: 'joe@example.com',
      image: 'http://graph.facebook.com/10203290081348033/picture?type=square'
    },
    credentials: {
      token: 'ABCtokenXYZ',
      expires_at: 1407992939
    }
  })
end

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = facebook_omniauth_hash

