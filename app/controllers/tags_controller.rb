class TagsController < ApplicationController
  before_filter :set_quotes

  def index
  	@tags = Quote.tag_counts
  end

  def show
  end

  private
  def set_quotes
  	@quotes = Quote.tagged_with params[:id]
  end
end
