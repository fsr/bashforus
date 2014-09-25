class SearchRequestsController < ApplicationController

  def new
  	@search_request = SearchRequest.new
  end

  def show
  	searchable_models = [ Quote, User ]
    @query = Sunspot.search searchable_models do |query|
    	query.keywords search_request_params[:query]
    end
  end

  private

  def search_request_params
  	params.require(:search_request).permit(:query)
  end

end
