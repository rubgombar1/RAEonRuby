require 'capybara'
require 'capybara/poltergeist'
include Capybara::DSL
class Entry
  def initialize(definition)
    @definition = definition
  end

  def getDefinition
  	return @definition
  end
end

class Search
  def initialize(words, word_search)
    @words = words
    @word_search = word_search
  end
  def getWordSearch
  	return @word_search
  end

  def getWords()
  	return @words
  end
end

class Word
  def initialize(word, entries)
    @word = word
    @entries = entries
  end
  def getWord
  	return @word
  end

  def getEntries
  	return @entries
  end
end

Capybara.default_driver = :poltergeist
RAE_URL = "http://lema.rae.es/drae/srv/search?val="

class SearchService
	def get_search(word_entry)
 
  uri = RAE_URL+URI::encode(word_entry)
  # HTTP Get request for the word.
  visit uri
  # Get the HTML code into <body></body> tag.
  results = all("body div")
  # Create the array that contains the words objects.
  words = Array.new

  results.each do |result|
    # Get the content of the <span class"f"></span> that content a word
    word_result = result.all("span.f").map { |x| if x.text != '.'; x.text end}.join " "
    word_result.gsub! "  ", " "
    word_result.gsub! " ,", ","
    word_result.gsub!(/ ([0-9])/, "\\1")
    # Create the array that contains the entries objects.
    entries = Array.new
    # Get the content of the <span class"b"></span> that content a word definition (entry). { |x| entry =
    # Entry.new(x.text); entries.push(entry)} Take the text and instantiate an Entry class with this text.
    result.all("span.b").each { |x| entry = Entry.new(x.text); entries.push(entry)}
    #Instantiate a Word class with this word in <p></p> tag and the entries array.
    word = Word.new(word_result, entries)
    words.push(word)
  end
  #Instantiate a Search class with this word in <p></p> tag.
  search = Search.new(words, word_entry)
  if search.getWords != []
     return search
  elsif  page.body.include?("en el Diccionario. ")
  	  return "The word #{word_entry} isn't registered in the dictionary"
  end

end	
end
