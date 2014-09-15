class TagsController < ApplicationController
  before_filter :set_quotes

  def index
  	@tags = ActsAsTaggableOn::Tag.all
  end

  def show
  end

  private
  def set_quotes
  	@quotes = Quote.tagged_with params[:id]
  end
end
