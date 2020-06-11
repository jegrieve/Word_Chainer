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
        word_chain = [source]
        while current_word != target

            if current_word != nil
            current_word = depth_search(current_word, indexes, target)
            else
                puts "done"
                break
            end

            if current_word != nil
                word_chain << current_word
                indexes = fill_indexes(current_word, target)
                if current_word == target
                    return word_chain
                end
            else
                current_word = possible_root_words.shift
                word_chain = []
            end

        end
    end

        def depth_search(current_word, indexes, target)
            words = adjacent_words(current_word)
            words.each do |word|
                if valid?(word, indexes) && closer?(word,indexes, target)
                    return word
                end
            end
            nil
        end

        def valid?(word, hash)
            hash.each do |k,v|
                return false if word[k] != hash[k]
            end
            true
        end
 
        def closer?(word, hash, target)
            length = hash.length

            word.each_char.with_index do |letter, i|
                if letter = target[i]
                    hash[i] = letter
                end
            end
            length > hash.length
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

g.run("duck", "ruby")