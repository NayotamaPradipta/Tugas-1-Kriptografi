require 'base64'
module Ciphers
    class VigenereExtendedCipher
      def self.encrypt(plaintext, key)
        key = transform_key(key, plaintext.length)
        ciphertext_bytes = plaintext.bytes.each_with_index.map do |byte, index|
          # Calculate the encrypted byte
          (byte + key.bytes[index] % 256) % 256
        end
        # Convert the ciphertext bytes to a string and encode it in Base64
        Base64.strict_encode64(ciphertext_bytes.pack('C*'))
      end
  
      def self.decrypt(ciphertext, key)
        # Decode the ciphertext from Base64 and get the byte array
        decoded_bytes = Base64.decode64(ciphertext).bytes
        key = transform_key(key, decoded_bytes.length)
        plaintext_bytes = decoded_bytes.each_with_index.map do |byte, index|
          # Calculate the decrypted byte
          (byte - key.bytes[index] % 256) % 256
        end
        # Convert the plaintext bytes back to a string
        plaintext_bytes.pack('C*')
      end
  
      def self.transform_key(key, length)
        key = key * (length / key.length) + key[0...(length % key.length)]
        key
        end
    end
end
