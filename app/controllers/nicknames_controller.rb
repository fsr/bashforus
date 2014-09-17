class NicknamesController < ApplicationController
  include QuotesHelper
  before_filter :set_nickname, only: :show
  before_filter :filter_quotes, only: :show
  before_filter :collect_tags, only: :show

  def index
  	@nicknames = Quote.source_counts
  end

  def show
  end

  private

  private
  def set_nickname
    @nickname = params[:id]
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
