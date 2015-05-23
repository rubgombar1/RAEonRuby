class Word
  def initialize(word, entrys)
    @word = word
    @entrys = entrys
  end

  def to_s
    "Word: #{@word} "+ "\n" + "The entrys are: " + "\n" + @entrys.map { |a| a.to_s + "\n"}.join
  end
end