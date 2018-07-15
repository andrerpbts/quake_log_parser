Devise.setup do |config|
  config.secret_key = 'cd84fcc2801e69c60d014f8e18edce197ed7261969ed85e90cba074390c35fb98654a7d4650c48bb9180ce2ec3bd377a3eddc3166c2d6eb166f1d8e3dbe529ef'
  config.mailer_sender = 'andrerpbts@gmail.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
