class QuotesController < ApplicationController
  load_and_authorize_resource except: :create
  def show
  end
  def new
  	@quote = @channel.quotes.build
  end
  def create
  	@quote  = @channel.quotes.build quote_params
  	if @quote.save
  		redirect_to root_url, subdomain: @channel.subdomain
  	else
  		render 'new'
  	end
  end
  private
  def quote_params
  	params.require(:quote).permit(:body)
  end
end
