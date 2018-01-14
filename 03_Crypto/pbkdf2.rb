require 'securerandom'
require 'pbkdf2'

salt = ARGV[1] || SecureRandom.hex(16)

pwd = PBKDF2.new(
  :password => ARGV[0],
  :salt => salt,
  :iterations => 10_000
)

puts "Salt: #{salt}"
puts "Hash: #{pwd.hex_string}"



