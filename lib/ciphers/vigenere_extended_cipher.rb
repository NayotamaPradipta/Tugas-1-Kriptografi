module Ciphers
    class VigenereExtendedCipher
        def self.encrypt(plaintext, key)
            key = transform_key(key, plaintext.length)
            ciphertext = ''

            plaintext.bytes.each_with_index do |byte, index|
                shift = key.bytes[index]
                encrypted_byte = (byte + shift) % 256
                ciphertext << encrypted_byte
            end
            ciphertext
        end

        def self.decrypt(ciphertext, key)
            key = transform_key(key, ciphertext.length)
            plaintext = ''

            ciphertext.bytes.each_with_index do |byte, index|
                shift = key.bytes[index]
                decrypted_byte = (byte - shift) % 256
                plaintext << decrypted_byte
            end
            plaintext
        end

        def self.transform_key(key, length)
            key = key * (length / key.length) + key[0...(length % key.length)]
            key
        end
    end
end
