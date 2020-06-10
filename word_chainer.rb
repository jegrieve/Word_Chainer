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
        indexes = fill_indexes(source, target)
        possible_root_words = root_words(source, indexes)
        #make sure array doesn't return back empty
        current_word = possible_root_words.shift 

        while current_word != target

            method(current_word) #--> keep going until finds word

            while current_word != target
               current_word = search(current_word, indexes)
            end
            
            #make sure array is not empty(ie current word has at least 2 items)
            #otherwise loop is over, theres no word that can equal the target
            current_word = possible_root_words.shift 
        end


    end

    def fill_indexes(source, target) #fill indexes hash
        indexes = {}
        source.split("").each_with_index do |letter1, i1|
            indexes[i1] = letter1 if letter1 == target[i1]
        end
        indexes
    end

    def root_words(source, indexes) #returns array of root words
        words = adjacent_words(source)
        possible_words = []
        words.each do |word,i1|
            indexes.each do |k,v|
                if word[k] != indexes[k]
                else
                    possible_words << word
                end
            end
        end
        possible_words        
    end


end

g = WordChainer.new("dictionary.txt")

g.run("math", "barn")