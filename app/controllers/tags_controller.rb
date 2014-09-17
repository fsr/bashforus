class TagsController < ApplicationController
  include QuotesHelper
  before_filter :set_tag, only: :show
  before_filter :filter_quotes, only: :show
  before_filter :collect_sources, only: :show

  def index
  	@tags = Quote.tag_counts.sort_by do |tag|
      tag.taggings_count
    end.reverse
  end

  def show
  end

  private
  def set_tag
    @tag = params[:id]
  end
  def filter_quotes
    @quotes = Quote.tagged_with(@tag,on: :tags)
  end
  def collect_sources
    @sources = @quotes.collect do |quote|
      quote.source_list
    end.flatten.uniq.collect do |source|
     nickname_html(source + '>')
   end
  end
end
