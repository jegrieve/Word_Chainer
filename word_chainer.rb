require "set"
class WordChainer
    attr_accessor :dictionary
    def initialize(dictionary_file_name, source)
        @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
        @current_words = [source]
        @all_seen_words = [source]
    end

    def adjacent_words(word)
        letters = word.split("")
        adj_words = []
        @dictionary.each do |ele|
            if same_length?(word, ele)
                count = word.length - 1
                ele.each_char.with_index do |letter, i|
                    if letter == word[i]
                        count -= 1
                    end
                end
                adj_words << ele if count == 0
            end
        end
        puts adj_words
    end

    def same_length?(word, dictionary_word)
        if word.length == dictionary_word.length
            return true
        end
        false
    end

    def run(source, target)

    end
end

g = WordChainer.new("dictionary.txt")
g.adjacent_words("cat")