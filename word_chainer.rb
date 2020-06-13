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
        return empty_words if possible_root_words.empty?
        current_word = possible_root_words.shift
        return empty_word if current_word == nil
        word_chain = [source]
        unique = [source]
        while current_word != target
            current_word = depth_search(current_word, indexes, target, unique)
            unique << current_word
            
            if current_word != nil
                word_chain << current_word
                
                indexes = fill_indexes(current_word, target)
                if current_word == target
                    p word_chain
                    return word_chain
                end
            else
                return empty_word if possible_root_words.empty?
                current_word = possible_root_words.shift
                word_chain = [source]
                unique = [source]
            end
        end
    end

    def depth_search(current_word, indexes, target, unique)
        words = adjacent_words(current_word)

        words.each do |word|
            if valid?(word, indexes) && unique?(word, unique)
                return word
            end
        end
        nil
    end

    def valid?(word, hash)
        hash.each do |k,v|
            return false if hash[k] != word[k]
        end
        true
    end

    def unique?(word, array)
        !array.include?(word)
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

    def empty_words
        puts "no root words"
    end

    def empty_word
        puts "no possible word chain"
    end


end

g = WordChainer.new("dictionary.txt")

g.run("duck", "ruby")