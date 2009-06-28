# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_socialbrokerage_session',
  :secret      => '30595c48eacf7cf9c59fedb3a95b6e2e2f2281dadc2657df54fbf0105895894a7f54b884058786126a6355a20e53496737679c4a0925845e68800e499c3f74aa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
