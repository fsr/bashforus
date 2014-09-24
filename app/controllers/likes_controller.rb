class LikesController < ApplicationController

  load_and_authorize_resource except: :destroy
  before_filter :set_quote

  def create
    if @quote.likes.where(user:current_user).empty?
      @quote.dislikes.where(user:current_user).each{|dl|dl.destroy}
  	  @quote.likes.create user:current_user
    end
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js   { render 'quotes/like' }
    end
  end

  def destroy
    @quote.likes.where(user:current_user).each{|l|l.destroy}
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js   { render 'quotes/like' }
    end
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end
end
