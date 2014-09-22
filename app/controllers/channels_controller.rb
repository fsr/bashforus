class ChannelsController < ApplicationController
  load_and_authorize_resource except: :create

  before_filter :set_channel, except: [ :index, :show, :new, :create ] 

  def index
  	@channels = Channel.all
  end

  def new
  	@channel = Channel.new
  end

  def create
  	@channel = Channel.new channel_params
    current_user.add_role :owner, @channel
  	@channel.state = 'unapproved'
  	if @channel.save
      redirect_to root_url
  	else
  	  render 'new'
  	end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @channel.update channel_params
        format.html { redirect_to root_url, subdomain: '' }
        format.json { render json: @channel, status: :accepted }
      else
        format.html { render 'edit' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @channel.destroy
        format.html { redirect_to root_url, subdomain: '' }
        format.json { render json: @channel.errors, status: :no_content}
      else
        format.html { redirect_to root_url, subdomain: '' }
        format.json { render json: @channel.errors, status: :unprocessable_entity}
      end
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
