class SearchController < ApplicationController
   def search
  	search_word = params[:q]
	service = SearchService.new
	@search = service.get_search(search_word)
  	render :search 
  end

  def index
     render :search
  end
end
