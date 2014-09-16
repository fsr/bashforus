class NicknamesController < ApplicationController
  before_filter :set_nickname, only: :show

  def index
  	@nicknames = Quote.source_counts
  end

  def show
  end

  private
  def set_nickname
  	Nickname.friendly.find(params[:id])
  end
end
