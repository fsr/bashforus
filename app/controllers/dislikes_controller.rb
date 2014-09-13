class DislikesController < ApplicationController
  before_filter :set_quote
  def create
  	@quote.dislikes.create
  	redirect_to request.referrer
  end
  private
  def set_quote
  	@quote = Quote.find(params[:quote_id])
  end
end
