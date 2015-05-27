#encoding: utf-8
require 'capybara'
require 'capybara/poltergeist'
include Capybara::DSL

Capybara.default_driver = :poltergeist
RAE_URL = "http://lema.rae.es/drae/srv/search?val="

class SearchService
	def get_search(word_entry)
	  uri = RAE_URL+URI::encode(word_entry)
	  # HTTP Get request for the word.
	  visit uri
	  # Get the HTML code into <body></body> tag.
	  results = all("body div")

	  search = Search.new()
	  search.word_search = word_entry
	  search.save()
	  results.each do |result|
	    # Get the content of the <span class"f"></span> that content a word
	    word_result = result.all("span.f").map { |x| if x.text != '.'; x.text end}.join " "
	    word_result.gsub! "  ", " "
	    word_result.gsub! " ,", ","
	    word_result.gsub!(/ ([0-9])/, "\\1")
	    word = Word.new()
	    word.word = word_result
	    word.search = search
	    word.save()
	    # Get the content of the <span class"b"></span> that content a word definition (entry). { |x| entry =
	    # Entry.new(x.text); entrys.push(entry)} Take the text and instantiate an Entry class with this text.
	    result.all("span.b").each { |x| entry = Entry.new(); entry.word = word; entry.definition= x.text;entry.save()}
	    #Instantiate a Word class with this word in <p></p> tag and the entrys array.
	  end
	  #Instantiate a Search class with this word in <p></p> tag.
	  words = Word.find_by(search_id = search.id)
	  if words != []
	     
	  elsif  page.body.include?("en el Diccionario. ")
	  	puts "The word #{word_entry} isn't registered in the dictionary"
	  end
	  return search
	end
end













