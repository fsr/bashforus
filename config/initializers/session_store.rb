# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_bashforus_session', domain: :all, tld_length: CONFIG['domain'].count('.')
