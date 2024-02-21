module Ciphers 
    class AffineCipher
        @n=26

        def self.encrypt(text, m, b)
            m = m.to_i
            b = b.to_i
            cipher_text = ""
            if m.gcd(@n) != 1 
                return "ERROR: M must be coprime with 26"
            else 
                text = clean_text(text)
                text.each_char do |c|
                    # Change each characters to integer ordinal
                    x = c.ord - 'A'.ord 
                    e_char = (m*x+b)% @n 
                    e_char = (e_char + 'A'.ord).chr
                    cipher_text << e_char
                end 
            end
            cipher_text
        end

        def self.decrypt(text, m, b)
            m = m.to_i 
            b = b.to_i 
            plain_text = ""
            if m.gcd(@n) != 1
                return "ERROR: M must be coprime with 26"
            else 
                m_inv = inverse_mod(m,@n)
                text = clean_text(text)
                text.each_char do |c|
                    # Change each characters to integer ordinal
                    x = c.ord - 'A'.ord
                    p_char = (m_inv * (x-b)) % @n 
                    p_char = (p_char + 'A'.ord).chr
                    plain_text << p_char
                end 
            end 
            plain_text
        end

        def self.clean_text(text)
            # Remove non-alphabetical characters
            text = text.gsub(/[^a-zA-Z]/, '')
            # Delete all space
            text = text.delete(' ')
            # Change to uppercase
            text = text.upcase 
            text
        end
    
        def self.inverse_mod(m, n)
            (1..n).each do |i|
                return i if (m*i) % n == 1
            end 
            nil 
        end
    end 
end