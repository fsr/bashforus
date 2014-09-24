class MomentsController < ApplicationController
  include QuotesHelper

  def index
    authorize! :read, @channel
    case
    when current_user.present?
      if current_user.has_role? :admin
        @quotes = @channel.quotes
      else
        @quotes = @channel.quotes.visible_or_owned_by(current_user.id)
      end
    else
      @quotes = @channel.quotes.visible
    end
    respond_to do |format|
      format.html {
        @quotes = @quotes.group_by{ |q| q.created_at.beginning_of_month }
      }
      format.json { render json: @quotes }
    end
  end
end
