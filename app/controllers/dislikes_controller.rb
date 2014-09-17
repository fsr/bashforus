class DislikesController < ApplicationController
  before_filter :set_quote
  load_and_authorize_resource
  def create
  	@quote.dislikes.create user:current_user if @quote.dislikes.where(user:current_user).empty?
  	redirect_to request.referrer
  end
  private
  def set_quote
  	@quote = Quote.find(params[:quote_id])
  end
end
