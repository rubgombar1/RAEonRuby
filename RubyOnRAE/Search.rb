class Search
  def initialize(words, word_search)
    @words = words
    @word_search = word_search
  end
  def to_s
    "For the word #{@word_search}, the results of the search are the followings:" + "\n" + @words.map { |word| word.to_s }.join
  end
end