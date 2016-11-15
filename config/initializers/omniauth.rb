OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '325789364444538', '7ee805f2cda630f4cdd224b4b6e6a95e'
end

