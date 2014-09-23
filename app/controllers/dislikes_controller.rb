class DislikesController < ApplicationController

  load_and_authorize_resource except: :destroy
  before_filter :set_quote

  def create
    if @quote.dislikes.where(user:current_user).empty?
      @quote.likes.where(user:current_user).each{|l|l.destroy}
      @quote.dislikes.create user:current_user
    end
  	redirect_to request.referrer
  end

  def destroy
    @quote.dislikes.where(user:current_user).each{|l|l.destroy}
    redirect_to request.referrer
  end

  private

  def set_quote
  	@quote = Quote.find(params[:id])
  end
end
