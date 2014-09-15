class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :get_channel

  private
  def get_channel
  	channels = Channel.where(subdomain: request.subdomain)
  	if channels.count > 0
  	  @channel = channels.first
  	elsif request.subdomain != ''
  	  redirect_to root_url
  	end  		
  end
end
