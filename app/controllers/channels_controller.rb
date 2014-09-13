class ChannelsController < ApplicationController

  before_filter :set_channel, except: [ :index, :show, :new, :create ] 

  def index
  	@channels = Channel.all
  end

  def show
  	@quotes = @channel.quotes.sort_by{|quote|quote.rating}
  end

  def new
  	@channel = Channel.new
  end

  def create
  	@channel = Channel.new channel_params
  	@channel.state = 'unapproved'
  	if @channel.save
      redirect_to root_url
  	else
  	  render 'new'
  	end
  end

  def approve
  	@channel.approve
  	redirect_to root_url
  end

  def activate
  	@channel.activate
  	redirect_to root_url
  end

  def deactivate
  	@channel.deactivate
  	redirect_to root_url
  end

  private

  def channel_params
  	params.require(:channel).permit(:name,:subdomain)
  end

  def set_channel
  	@channel = Channel.find params[:id] 
  end
end
