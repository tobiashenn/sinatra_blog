require 'sinatra'
require 'haml'
require 'rdiscount'

# for all markdown files, use post.haml as layout
set :markdown, :layout_engine => :haml, :layout => :layout


get '/' do 
  haml :index
end

get '/blog' do 
  markdown :test
end