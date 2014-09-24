class DislikesController < ApplicationController

  load_and_authorize_resource except: :destroy
  before_filter :set_quote

  def create
    if @quote.dislikes.where(user:current_user).empty?
      @quote.likes.where(user:current_user).each{|l|l.destroy}
      @quote.dislikes.create user:current_user
    end
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js   { render 'quotes/dislike' }
    end
  end

  def destroy
    @quote.dislikes.where(user:current_user).each{|l|l.destroy}
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js   { render 'quotes/dislike' }
    end
  end

  private

  def set_quote
  	@quote = Quote.find(params[:id])
  end
end
