#encoding: utf-8
require 'capybara'
require 'capybara/poltergeist'
require_relative 'Entry'
require_relative 'Word'
require_relative 'Search'

Capybara.default_driver = :poltergeist
RAE_URL = "http://lema.rae.es/drae/srv/search?val="

def get_search(word_entry)
  include Capybara::DSL
  uri = RAE_URL+URI::encode(word_entry)
  puts uri
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
    # Create the array that contains the entrys objects.
    entrys = Array.new
    # Get the content of the <span class"b"></span> that content a word definition (entry). { |x| entry =
    # Entry.new(x.text); entrys.push(entry)} Take the text and instantiate an Entry class with this text.
    result.all("span.b").each { |x| entry = Entry.new(x.text); entrys.push(entry)}
    #Instantiate a Word class with this word in <p></p> tag and the entrys array.
    word = Word.new(word_result, entrys)
    words.push(word)
  end
  #Instantiate a Search class with this word in <p></p> tag.
  search = Search.new(words, word_entry)
  if search.getWords != []
     puts search.to_s
  elsif  page.body.include?("en el Diccionario. ")
  	puts "The word #{word_entry} isn't registered in the dictionary"
  end

end

def main
  print "Insert a word to search: "

  # Request a word to search and delete /r/n.
  word = gets.chomp

  puts 'The word that you introduced was: ' + word
  get_search word

end

main













