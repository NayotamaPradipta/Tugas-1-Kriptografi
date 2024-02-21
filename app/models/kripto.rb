class Kripto
    def self.encrypt(text, cipher, n, key, m, b)
        case cipher
        when 'vigenere1'
            Ciphers::VigenereCipher.encrypt(text, key)
        when 'vigenere2'
            Ciphers::VigenereAutoKeyCipher.encrypt(text, key)
        when 'vigenere3'
            Ciphers::VigenereExtendedCipher.encrypt(text, key)
        when 'playfair'
            Ciphers::PlayfairCipher.encrypt(text, key)
        when 'affine'
            Ciphers::AffineCipher.encrypt(text, m, b)
        when 'hill'
            Ciphers::HillCipher.encrypt(text, n, key)
        when 'super'
            # Ciphers::SuperCipher.encrypt(text, key)
        else
            "Unsupported Cipher"
        end
    end

    def self.decrypt(text, cipher, n, key, m, b)
        case cipher
        when 'vigenere1'
            Ciphers::VigenereCipher.decrypt(text, key)
        when 'vigenere2'
            Ciphers::VigenereAutoKeyCipher.decrypt(text, key)
        when 'vigenere3'
            Ciphers::VigenereExtendedCipher.decrypt(text, key)
        when 'playfair'
            Ciphers::PlayfairCipher.decrypt(text, key)
        when 'affine'
            Ciphers::AffineCipher.decrypt(text, m, b)
        when 'hill'
            Ciphers::HillCipher.decrypt(text, n, key)
        when 'super'
            # Ciphers::SuperCipher.decrypt(text, key)
        else
            "Unsupported Cipher"
        end
    end
end
