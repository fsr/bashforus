require 'xmpp4r'
include Jabber

module XmppClient

  extend self

  attr_accessor :jabber_id
  attr_accessor :password
  attr_accessor :jid
  attr_accessor :client
  attr_accessor :xmpp_debug
  attr_accessor :id

  def configure
  	yield self
  	parameters
  end
  def parameters 
  	h = {}
  	keys.each { |k| h[k.to_sym] = XmppClient.instance_variable_get("@#{k}") }
  	return h
  end
  alias_method :params, :parameters

  def keys
	XmppClient.instance_methods.select do |m|
	  m =~ /=$/
	end.map do |m|
	  m[0..-2]
	end
  end

  def connect
	Rails.logger.info "Connecting to server"
  	Jabber::debug = @xmpp_debug
  	@client = Client.new(JID.new(@jabber_id))
  	@client.connect
  	@client.auth(@password)
  	@client.send(Jabber::Presence.new)
  	@id    ||= 1
  end

  def notification resource={}
  	unless @id
  		connect
  	end
  	receiver = JID.new resource[:user]
  	body     = resource[:message]
  	subject  = resource[:title]
  	type     = :normal
  	@id = id = @id+1
  	message  = Message.new receiver, body
  	message.set_type type
  	message.set_id id.to_s
  	message.set_subject subject
  	Rails.logger.debug "XMPP Notification: #{message.to_s}"
  	Rails.logger.debug @client.inspect
  	begin
		@client.send(message)
	rescue IOError
		connect
		@client.send(message)
	end
  end
end