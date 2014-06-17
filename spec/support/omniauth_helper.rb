# https://github.com/intridea/omniauth/wiki/Integration-Testing
OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
  provider: 'Facebook',
  uid: '123545',
  info: {
    name: 'Joe Example'
  },
  credentials: {
    token: 'ABCtokenXYZ',
    expires_at: 1407992939
  }
})

