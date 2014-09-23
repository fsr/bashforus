class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :get_channel
  after_filter :store_location

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_url, alert: exception.message
  end
  
  def after_sign_in_path_for(resource)
    url_to = session['user_return_to']
    session.delete 'user_return_to'
    logger.debug "url to: #{url_to}"
    url_to || root_path
  end

  def after_sign_out_path_for(resource)
    url_to = session['user_return_to']
    session.delete 'user_return_to'
    logger.debug "url to: #{url_to}"
    url_to || root_path
  end

  private

  def store_location
    return if params[:controller] =~ /^devise\//
    logger.debug "Storing location #{request.url}"
    session['user_return_to'] = request.url
  end

  def get_channel
  	channels = Channel.where(subdomain: request.subdomain)
  	if channels.count > 0
  	  @channel = channels.first
  	elsif request.subdomain != ''
  	  redirect_to root_url(subdomain:'')
  	end
  end
end
