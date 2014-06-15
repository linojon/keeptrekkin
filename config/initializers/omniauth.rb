OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1489744201259276', '68facb1eab521a448418394b7becc06a'
end