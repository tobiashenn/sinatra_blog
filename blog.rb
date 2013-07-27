# GEMS
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'rdiscount'
require 'nokogiri'

# CONFIGURATION
set :server, :puma
set :markdown, :layout_engine => :haml, :layout => :layout

configure :production do
  #set :port, 80
  require 'newrelic_rpm'
end


# ROUTES
get '/' do 
  haml :index
end

get '/contact' do
  haml :contact
end

get '/content/:id' do
  @created_at = params["id"].gsub(/.md/,"").gsub(/_/,'-')
  @content = RDiscount.new( File.open("content/" + params["id"].concat(".md")).read.force_encoding('UTF-8') ).to_html
  haml :article_view
end

get '/research' do
  @content = RDiscount.new( File.open("markdown/research.md").read.force_encoding('UTF-8') ).to_html
  haml :research_view
end

get '/blog' do
  redirect to('/articles')
end

get '/articles' do
  @dir = Dir['content/*.md'].sort.reverse
  @articles = @dir.map { |c| c.split('/').reverse.first }
  haml :articles
end

get '/gallery' do
  haml :gallery
end