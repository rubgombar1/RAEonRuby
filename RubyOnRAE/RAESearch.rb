require 'net/http'

RAE_URL = "http://lema.rae.es/drae/srv/search?val="

def main
  print "Insert a word to search: "

  # Request a word to search and delete /r/n
  word = gets.chomp

  puts 'The word that you introduced was: ' + word

  # Create a URI to performs the HTTP GET request.
  uri = URI(RAE_URL+URI::encode(word))
  puts Net::HTTP.get(uri)
end

main


