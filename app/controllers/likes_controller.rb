class LikesController < ApplicationController

  load_and_authorize_resource
  before_filter :set_quote

  def create
  	@quote.likes.create user:current_user if @quote.likes.where(user:current_user).empty?
  	redirect_to request.referrer
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end
end
