class Kripto
    def self.encrypt(text, cipher, key, m, b)
        case cipher
        when 'vigenere1'
            Ciphers::VigenereCipher.encrypt(text, key)
        when 'vigenere2'
            # Ciphers::AutoKeyVigenereCipher.encrypt(text, key)
        when 'vigenere3'
            # Ciphers::ExtendedVigenereCipher.encrypt(text, key)
        when 'playfair'
            Ciphers::PlayfairCipher.encrypt(text, key)
        when 'affine'
            Ciphers::AffineCipher.encrypt(text, m, b)
        when 'hill'
            Ciphers::HillCipher.encrypt(text, key)
        when 'super'
            # Ciphers::SuperCipher.encrypt(text, key)
        else
            "Unsupported Cipher"
        end
    end

    def self.decrypt(text, cipher, key, m, b)
        case cipher
        when 'vigenere1'
            Ciphers::VigenereCipher.decrypt(text, key)
        when 'vigenere2'
            # Ciphers::AutoKeyVigenereCipher.decrypt(text, key)
        when 'vigenere3'
            # Ciphers::ExtendedVigenereCipher.decrypt(text, key)
        when 'playfair'
            Ciphers::PlayfairCipher.decrypt(text, key)
        when 'affine'
            Ciphers::AffineCipher.decrypt(text, m, b)
        when 'hill'
            Ciphers::HillCipher.decrypt(text, key)
        when 'super'
            # Ciphers::SuperCipher.decrypt(text, key)
        else
            "Unsupported Cipher"
        end
    end
end
