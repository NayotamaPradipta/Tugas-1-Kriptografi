require 'matrix'
require 'base64'
module Ciphers 
    class HillCipher
        def self.encrypt(text, n, key)
            n = n.to_i
            k_matrix = k_matrix(n, key)
            if is_invertible?(k_matrix)
                t_matrix = transform_plain_text(text, n)
                t_matrix_tranposed = t_matrix.transpose
                cipher_text = ""
                t_matrix.row_count.times do |row_index|
                    column_vector = Matrix.column_vector(t_matrix.row(row_index).to_a)
                    m_matrix = k_matrix * column_vector
                    m_matrix = m_matrix.map {|e| e % 26}
                    m_matrix.each do |element|
                        cipher_text += (element + 'A'.ord).chr
                    end
                end 
                cipher_text
            else
                "Matrix is not invertible (D = 0)"
            end
        end

        def self.decrypt(text, n, key)
            "Hill"
            # TODO: Add Hill cipher decryption
        end

        def self.k_matrix(n, key)
            key_chars = key.upcase.chars.map {|c| c.ord - 'A'.ord }
            matrix_size = n*n 
            padding = matrix_size - key.length 
            if (padding < 0)
                # Trim if key is longer than the matrix size
                key_chars = key_chars[0...matrix_size]
            else 
                key_chars += Array.new(padding, 'X'.ord - 'A'.ord)
            end 
            keys = key_chars.each
            # Initialize array
            array = Array.new(n) do |i|
                Array.new(n) do |j|
                    keys.next 
                end 
            end 
            k_matrix = Matrix[*array]
            k_matrix
        end

        def self.transform_plain_text(text, n)
            text_chars = text.gsub(/[^a-zA-Z]/, '').upcase.chars.map{|c| c.ord - 'A'.ord }
            padded_chunks = text_chars.each_slice(n).map do |slice|
                slice.length == n ? slice : slice.fill(23, slice.length...n)
            end 
            matrix = Matrix.rows(padded_chunks)
            matrix
        end

        def self.is_invertible?(matrix)
            matrix.determinant != 0
        rescue Exception => e 
            false 
        end 
    end 
end 