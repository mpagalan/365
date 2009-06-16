# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_365_session',
  :secret      => '85a61638657f57e2ddde79d77d2cfd1bc08f61f04c0fd5dcae1f91011d7e830396b658afa4eaddf07a7b21f085733ec4e395d6934670dd7c87c6903a6e0793a7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
