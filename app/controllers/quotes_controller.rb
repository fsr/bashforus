class QuotesController < ApplicationController
  load_and_authorize_resource except: :create
  before_filter :set_quote, except: [:index, :create, :new]

  def index
    @quotes = @channel.quotes.where(visible:true) + @channel.quotes.where(owner:@current_user)
    @quotes = @quotes.uniq.sort_by{|quote|quote.rating}.reverse
    respond_to do |format|
      format.html
      format.json { render json: @quotes }
      format.atom
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @quote }
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end


  def update
    respond_to do |format|
      if @quote.update quote_params
        format.html { redirect_to root_url, subdomain: @channel.subdomain }
        format.json { render json: @quote, status: :accepted }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quote, status: :unprocessable_entity }
      end
    end
  end

  def new
  	@quote = @channel.quotes.build
    respond_to do |format|
      format.html
    end
  end

  def create
  	@quote  = @channel.quotes.build quote_params
    @quote.owner = current_user
    @quote.visible = true
    respond_to do |format|
      if @quote.save
        format.html { redirect_to root_url, subdomain: @channel.subdomain }
        format.json { render json: @quote, status: :accepted }
      else
        format.html { render action: 'new' }
        format.json { render json: @quote, status: :unprocessable_entity }
      end
    end
  end

  def disable
    respond_to do |format|
      if @quote.update visible: false
        format.html { redirect_to request.referrer }
        format.json { render json: @quote, status: :accepted }
      else
        format.html { redirect_to request.referrer }
        format.json { render json: @quote, status: :unprocessable_entity }
      end
    end
  end

  def enable
    respond_to do |format|
      if @quote.update visible: true
        format.html { redirect_to request.referrer }
        format.json { render json: @quote, status: :accepted }
      else
        format.html { redirect_to request.referrer }
        format.json { render json: @quote, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subdomain = @quote.channel.subdomain
    respond_to do |format|
      if @quote.destroy
        format.html { redirect_to root_url, subdomain: @subdomain }
        format.json { render json: @quote.errors, status: :no_content}
      else
        format.html { redirect_to quote_path @quote }
        format.json { render json: @quote.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  def set_quote
    @quote = Quote.find(params[:id])
  end
  def quote_params
  	params.require(:quote).permit(:body)
  end
end
