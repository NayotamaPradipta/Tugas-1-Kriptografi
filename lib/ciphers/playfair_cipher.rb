require 'matrix'
require 'base64'
module Ciphers 
    class PlayfairCipher
        def self.encrypt(text, key)
            cipher_text = ""
            # Matrix key 5x5
            m_key = transform_key(key)
            # Convert text to bigram
            b_text = transform_plain_text(text)

            b_text.each do |bigram|
                idx_1 = get_char_index(m_key, bigram[0])
                idx_2 = get_char_index(m_key, bigram[1])
                # Same row
                if idx_1[0] == idx_2[0]
                    cipher_text << m_key[idx_1[0], (idx_1[1]+1) % 5]
                    cipher_text << m_key[idx_2[0], (idx_2[1]+1) % 5]
                # Same column
                elsif idx_1[1] == idx_2[1]
                    cipher_text << m_key[(idx_1[0]+1) % 5, idx_1[1]]
                    cipher_text << m_key[(idx_2[0]+1) % 5, idx_1[1]]
                else 
                    cipher_text << m_key[idx_1[0], idx_2[1]]
                    cipher_text << m_key[idx_2[0], idx_1[1]]
                end 
            end 
            cipher_text
        end

        def self.decrypt(text, key)
            if text.length % 2 != 0
                return "Illegal text length (Odd)"
            end
            plain_text = ""
            # Matrix key 5x5
            m_key = transform_key(key)
            # Convert cipher text to bigram
            b_text = transform_cipher_text(text)
            b_text.each do |bigram|
                idx_1 = get_char_index(m_key, bigram[0])
                idx_2 = get_char_index(m_key, bigram[1])
                # Same row
                if idx_1[0] == idx_2[0]
                    plain_text << m_key[idx_1[0], (idx_1[1]-1)%5]
                    plain_text << m_key[idx_2[0], (idx_2[1]-1)%5]
                # Same column 
                elsif idx_1[1] == idx_2[1]
                    plain_text << m_key[(idx_1[0]-1) % 5, idx_1[1]]
                    plain_text << m_key[(idx_2[0]-1) % 5, idx_2[1]]
                else 
                    plain_text << m_key[idx_1[0], idx_2[1]]
                    plain_text << m_key[idx_2[0], idx_1[1]]
                end 
            end
            # Delete X at the end
            plain_text.chomp!('X')
            # Delete X that are flanked by identical letters
            plain_text.gsub!(/([A-Z])X\1/, '\1\1')
            plain_text
        end

        def self.transform_key(key)
            # Create array of alphabet excluding J
            alphabet = ('A'..'Z').to_a.delete_if { |char| char == 'J'}
            # Delete J
            key = key.upcase.delete('J')
            # Delete duplicate characters
            key = key.chars.uniq.join
            # Delete whitespace
            key = key.delete(' ')
            # Add the rest of alphabet
            alphabet.each do |char|
                key += char unless key.include?(char)
            end
            # Transform into 5x5 matrix
            key_chars = key.chars.each
            m_key = Matrix.build(5,5){key_chars.next}
            m_key
        end

        def self.transform_plain_text(text)
            # Remove non-alphabetical characters
            text = text.gsub(/[^a-zA-Z]/, '')
            # Delete all space
            text = text.delete(' ')
            # Change to uppercase
            text = text.upcase 
            # Change j to i
            text = text.gsub('J', 'I')
            bigrams = []
            index = 0
            while index < text.length
                # Insert X in between same characters
                if text[index] == text[index+1]
                    bigrams << text[index] + 'X'
                    index += 1
                else 
                    if (text[index+1] != nil)
                        bigrams << text[index, 2]
                    else 
                        # Add X if the last bigram only consists of one character
                        bigrams << text[index] + 'X'
                    end
                    index+=2
                end
            end
            bigrams
        end

        def self.transform_cipher_text(text)
            # Delete all space
            text = text.delete(' ')
            # Change to uppercase
            text = text.upcase 
            bigrams = []
            index = 0
            while index < text.length
                bigrams << text[index, 2]
                index += 2
            end
            bigrams
        end

        def self.get_char_index(m_key, character)
            (0...5).each do |i|
                (0...5).each do |j|
                    if m_key[i, j] == character
                        return [i, j]
                    end 
                end 
            end
        end
    end 
end