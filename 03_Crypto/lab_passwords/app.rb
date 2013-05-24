require 'sinatra'
require 'sqlite3'
require 'openssl'

db = SQLite3::Database.new "users.db"

get '/' do
  erb :index
end

post '/login' do
  db_details = db.execute("SELECT password FROM users WHERE login = ?",
        params[:email]).first

   login_fail unless db_details

  db_password = db_details.first

  password    = params[:password]

  if check_password( db_password, password )
    erb :welcome
  else
    login_fail
  end
end

def check_password(stored_value, pass)
  db_salt     = stored_value.byteslice(0, 16)
  db_hash     = stored_value.byteslice(16, stored_value.length - 16)
  iter = 20000
  digest = OpenSSL::Digest::SHA256.new
  len = digest.digest_length
  #the final value to be stored
  value = OpenSSL::PKCS5.pbkdf2_hmac(pass, db_salt, iter, len, digest)

  return value == db_hash
end

def login_fail
  redirect '/'
end
