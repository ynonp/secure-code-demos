require 'openssl'

def bin2hex(bin)
  bin.unpack('H*')
end

def encrypt(plaintext)
  cipher = OpenSSL::Cipher.new('aes-256-gcm')
  cipher.encrypt
  cipher.key = '11111111111111111111111111111111'
  iv = cipher.random_iv
  cipher.auth_data = ''
  ciphertext = cipher.update(plaintext)
  ciphertext << cipher.final
  puts "[+] CipherMessage (IV | Ciphertext): #{bin2hex(iv)} | #{bin2hex(ciphertext)}"
end

def encrypt_null_iv(plaintext)
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

puts '--- 1'
puts encrypt 'This is some secret message.'
puts encrypt 'This is some secret message.'
puts '--- 2'
puts encrypt_null_iv 'This is some secret message.'
puts encrypt_null_iv 'This is some secret message.'
puts encrypt_null_iv 'Rhis is some secret message.'
puts encrypt_null_iv 'Rhis is some secret message.'
