# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nkanalyst_session',
  :secret      => '14731bf7af600ecd2d2187ecc6a5a0dad8fd51d9cbe0d9d91d76c28ed7f11754668bfbc2b1b7815ac2d81671ed5875919ba1afe611725ee60e4c86be82c20bcd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
