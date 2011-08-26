# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_digchi_session',
  :secret      => 'da5ca14d582ef1196dcff89a3ceea81f945b4831a4311c607257493d177b86c88065d31eed2cca83ef7e856ce33f12e7755dcf12af31165d77fad830dca066a3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
