require 'openssl'

def bin2hex(bin)
  bin.unpack('H*')
end

def encrypt(plaintext)
  cipher = OpenSSL::Cipher.new('aes-256-gcm')
  cipher.encrypt
  cipher.iv = "\0" * 16
  cipher.key = '11111111111111111111111111111111'
  cipher.auth_data = ''
  ciphertext = cipher.update(plaintext)
  ciphertext << cipher.final

  puts "[+] Encrypting: #{plaintext}"
  puts "[+] CipherMessage (No IV) (Ciphertext): #{bin2hex(ciphertext)}"
end

puts encrypt 'This is some secret message.'
