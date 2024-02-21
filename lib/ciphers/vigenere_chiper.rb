module Ciphers 
    class VigenereCipher
        A_TABLE = ('A'..'Z').to_a

        def self.encrypt(text, key)
            plaintext = transform_plaintext(plaintext)
            key = transform_key(key, plaintext.length)
            ciphertext = ''

            plaintext.chars.each_with_index do |char, index|
              shift = A_TABLE.index(key[index])
              encrypted_char = A_TABLE[(A_TABLE.index(char) + shift) % 26]
              ciphertext << encrypted_char
            end
            ciphertext
        end

        def self.decrypt(text, key)
            key = transform_key(key, text.length)
            plaintext = ''

            ciphertext.chars.each_with_index do |char, index|
              shift = A_TABLE.index(key[index])
              decrypted_char = A_TABLE[(A_TABLE.index(char) - shift) % 26]
              plaintext << decrypted_char
            end
            plaintext
        end

        def self.transform_key(key, length)
            key = key.upcase
            key = key * (length / key.length) + key[0...(length % key.length)]
            key
        end

        def self.transform_plain_text(text)
            text = text.delete(' ')
            text = text.gsub(/[^a-zA-Z]/, '').upcase
            text
        end
    end 
end