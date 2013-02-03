require 'sinatra'
require 'data_mapper'
require 'haml'
require 'bcrypt'
require 'date'
require 'sinatra/flash'

use Rack::Session::Cookie, :secret => 'FUCKITYOUCANTKNOWIT'
enable :sessions


get "/about" do
  haml :about
end


get '/' do 
  haml :index
end