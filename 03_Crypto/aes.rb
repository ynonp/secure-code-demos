require 'aead'

# currently, AES-256-GCM and AES-256-CTR-HMAC-SHA-256 are supported
mode   = AEAD::Cipher.new('AES-256-GCM')

key    = mode.generate_key
nonce  = mode.generate_nonce

cipher    = mode.new(key)

aead      = cipher.encrypt(nonce, 'authentication data', 'Hello')

# aead[1] = 'f'

plaintext = cipher.decrypt(nonce, 'authentication data', aead)

puts plaintext

