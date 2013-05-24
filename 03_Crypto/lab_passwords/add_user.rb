require 'openssl'
require 'sqlite3'

login, pass = ARGV
raise "Usage $0 <username> <password>" unless pass

salt = OpenSSL::Random.random_bytes(16)
iter = 20000
digest = OpenSSL::Digest::SHA256.new
len = digest.digest_length

hashed_pass = OpenSSL::PKCS5.pbkdf2_hmac(pass, salt, iter, len, digest)

db = SQLite3::Database.new "users.db"
db.execute("INSERT INTO users VALUES(?, ?)", login, salt + hashed_pass)

