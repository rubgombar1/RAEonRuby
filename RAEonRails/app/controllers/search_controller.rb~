class SearchController < ApplicationController
   def search
  	search_word = params[:q]
	service = SearchService.new
	@search = Search.find_by word_search: search_word
	if @search == nil 
	    @search = service.get_search(search_word)
	end
	
  	render :search 
  end

  def index
     render :search
  end
end
