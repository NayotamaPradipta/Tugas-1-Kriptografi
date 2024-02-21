module Ciphers
    class VigenereAutoKeyCipher
        V_TABLE = ('A'..'Z').to_a

        def self.encrypt(text, key)
            plaintext = transform_plain_text(text)
            key = transform_key(key, plaintext)
            ciphertext = ''

            plaintext.chars.each_with_index do |char, index|
              shift = V_TABLE.index(key[index])
              encrypted_char = V_TABLE[(V_TABLE.index(char) + shift) % 26]
              ciphertext << encrypted_char
            end
            ciphertext
        end

        def self.decrypt(ciphertext, key)
            plaintext = ''

            ciphertext.chars.each_with_index do |char, index|
              shift = V_TABLE.index(key[index])
              decrypted_char = V_TABLE[(V_TABLE.index(char) - shift) % 26]
              plaintext << decrypted_char
            end
            plaintext
        end

        def self.transform_key(key, text)
            if key.length < text.length
                key += text[0, text.length - key.length]
            else
                key = key[0, text.length]
            end
            key = key.upcase
            key
        end

        def self.transform_plain_text(text)
            text = text.delete(' ')
            text = text.gsub(/[^a-zA-Z]/, '').upcase
            text
        end
    end
end
