XmppClient.configure do |config|
  config.jabber_id  = CONFIG['jabber_id']
  config.password   = PRIVATE['jabber_password']
  config.xmpp_debug = false
end
XmppClient.connect