require 'base64'

module Ciphers
  class SuperEncryptionCipher
    def self.encrypt(plaintext, key)
      key = transform_key(key, plaintext.length)
      ciphertext_bytes = plaintext.bytes.each_with_index.map do |byte, index|
        (byte + key.bytes[index] % 256)
      end

      ciphertext = ciphertext_bytes.pack('C*')
      effective_key_length = [key.length, ciphertext.length].min
      transposed_ciphertext = transposition_encrypt(ciphertext, effective_key_length)
      Base64.strict_encode64(transposed_ciphertext)
    end

    def self.decrypt(ciphertext, key)
      detransposed_ciphertext_base64 = Base64.decode64(ciphertext)
      effective_key_length = [key.length, detransposed_ciphertext_base64.length].min
      detransposed_ciphertext = transposition_decrypt(detransposed_ciphertext_base64, effective_key_length)

      decoded_bytes = detransposed_ciphertext.bytes
      key = transform_key(key, decoded_bytes.length)

      plaintext_bytes = decoded_bytes.each_with_index.map do |byte, index|
        (byte - key.bytes[index] % 256)
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
      total_chars = text.length
      rows = []
      start_index = 0

      chars_in_last_column = total_chars % key_length
      base_column_size = total_chars / key_length
    
      key_length.times do |column|
        size = column < chars_in_last_column ? base_column_size + 1 : base_column_size
        rows << text[start_index, size]
        start_index += size
      end

      decrypted_text = ''
      (0...column_size).each do |row_idx|
        rows.each do |col|
          decrypted_text << col[row_idx] if row_idx < col.length
        end
      end
    
      decrypted_text
    end
  end
end