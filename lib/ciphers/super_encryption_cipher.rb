require 'base64'

module Ciphers
  class SuperEncryptionCipher
    def self.encrypt(plaintext, key)
      key = transform_key(key, plaintext.length)
      ciphertext_bytes = plaintext.bytes.each_with_index.map do |byte, index|
        (byte + key.bytes[index] % 256) % 256
      end

      ciphertext = Base64.strict_encode64(ciphertext_bytes.pack('C*'))
      transposed_ciphertext = transposition_encrypt(ciphertext, key.length)

      transposed_ciphertext
    end

    def self.decrypt(ciphertext, key)
      detransposed_ciphertext = transposition_decrypt(ciphertext, key.length)

      decoded_bytes = Base64.decode64(detransposed_ciphertext).bytes
      key = transform_key(key, decoded_bytes.length)
      plaintext_bytes = decoded_bytes.each_with_index.map do |byte, index|
        (byte - key.bytes[index] % 256) % 256
      end
      plaintext_bytes.pack('C*')
    end

    def self.transform_key(key, length)
      key = key * (length / key.length) + key[0...(length % key.length)]
      key
    end

    def self.transposition_encrypt(text, key_length)
      columns = Array.new(key_length) { [] }

      text.chars.each_with_index do |char, index|
        columns[index % key_length] << char
      end

      transposed_text = columns.map(&:join).join
      transposed_text
    end

    def self.transposition_decrypt(text, key_length)
      column_size = (text.length.to_f / key_length).ceil
      columns = text.chars.each_slice(column_size).to_a

      rows = columns.transpose.flatten.compact
      rows.join
    end
  end
end
