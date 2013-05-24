require 'sinatra'
require 'sqlite3'

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

  if db_password == password
    erb :welcome
  else
    login_fail
  end
end

def login_fail
  redirect '/'
end
