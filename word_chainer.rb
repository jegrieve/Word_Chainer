require "set"
class WordChainer
    attr_reader :dictionary
    def initialize(dictionary_file_name)
        @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
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
        adj_words
    end

    def same_length?(word, dictionary_word)
        if word.length == dictionary_word.length
            return true
        end
        false
    end

    def run(source, target)
        indexes = {}
        source.split("").each_with_index do |letter1, i1|
            indexes[i1] = letter1 if letter1 == target[i1]
        end

        words = adjacent_words(source)
        possible_words = []
        current_word = []
        words.each do |word,i1|
            indexes.each do |k,v|
                if word[k] != indexes[k]
                else
                    possible_words << word
                end
            end
        end
        word_chain = []
        while 
    #     new_possible_words = []
    #    possible_words.each do |word|
    #         word.each_char.with_index do |letter, i|
    #             if letter == target[i] && indexes[i].nil?
    #                 new_possible_words << word
    #             end
    #         end
    #     end
            # while possible_words.length != 1
        #     attempted_words = []
        #     current_word = []
        # end
        
        p possible_words
    end
    #2. Go through adj words and first check if the word contains all the letter(s) in the hash
    #3. If this word has an additional correct letter, add that letter to hash
    #3. Keep going until source == target or if the possible words is empty we start over from  next word.
    
end

g = WordChainer.new("dictionary.txt")

g.run("math", "barn")