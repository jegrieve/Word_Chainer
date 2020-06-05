require "set"
class WordChainer
    attr_accessor :dictionary
    def initialize(dictionary_file_name)
        @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
        #Faster lookup in dictionary .include?
    end

    def adjacent_words(word)

    end
end

g = WordChainer.new("dictionary.txt")
p g.dictionary