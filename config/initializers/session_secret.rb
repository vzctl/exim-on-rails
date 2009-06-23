secret_file = File.join(RAILS_ROOT, "config/session.secret")
if File.exist?(secret_file)
  secret = File.read(secret_file)
else
  secret = ActiveSupport::SecureRandom.base64(30)
  File.open(secret_file, 'w') { |f| f.write(secret) }
end
ActionController::Base.session = {
  :session_key => '_e',
  :secret => secret
}
