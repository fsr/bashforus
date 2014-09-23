class NicknamesController < ApplicationController

  include QuotesHelper

  before_filter :set_nickname, only: [ :show, :claim, :revert ]
  before_filter :filter_quotes, only: :show
  before_filter :collect_tags, only: :show

  def index
  	@nicknames = Quote.source_counts.sort_by do |source|
      source.taggings_count
    end.reverse
  end

  def show
  end

  def claim
    @nickname.claim_to current_user
    redirect_to request.referrer
  end

  def revert
    @nickname.revert
    redirect_to request.referrer
  end

  private

  private
  def set_nickname
    @nickname = Nickname.new params[:id]
  end
  def filter_quotes
    @quotes = Quote.tagged_with(@nickname,on: :sources)
  end
  def collect_tags
    @tags = @quotes.collect do |quote|
      quote.tag_list
    end.flatten.uniq.collect do |tag|
     tag_html('#' + tag)
   end
  end
end
