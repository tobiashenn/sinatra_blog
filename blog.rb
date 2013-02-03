require 'sinatra'
require 'data_mapper'
require 'haml'
require 'bcrypt'
require 'date'
require 'sinatra/flash'
require 'rdiscount'

use Rack::Session::Cookie, :secret => 'FUCKITYOUCANTKNOWIT'
enable :sessions


get '/' do 
  haml :index
end