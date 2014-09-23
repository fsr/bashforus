class MomentsController < ApplicationController
  include QuotesHelper

  def index
    @quotes = @channel.quotes.where(visible:true) + @channel.quotes.where(owner:@current_user)
    @quotes = @quotes.uniq.sort_by{|quote| quote.created_at }.reverse
    respond_to do |format|
      format.html
      format.json { render json: @quotes }
    end
  end
end
