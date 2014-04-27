# GEMS
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'rdiscount'
require 'nokogiri'

# CONFIGURATION
set :server, :puma
set :markdown, :layout_engine => :haml, :layout => :layout
set :haml, :format => :html5

# Digitalocean environment
configure :ocean do
  set :port, 80
  set :environment, :production
end

# Heroku environment
configure :production do
  require 'newrelic_rpm'
end

puts "Blog engine started with Ruby Version #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"

# ROUTES
get '/' do
  @dir = Dir['content/*.md'].sort.reverse
  @articles = @dir.map { |c| c.split('/').reverse.first } 
  puts @articles
  haml :index
end

get '/contact' do
  haml :contact
end

get '/content/:id' do
  @created_at = params["id"].gsub(/.md/,"").gsub(/_/,'/')
  @content = RDiscount.new( File.open("content/" + params["id"].concat(".md")).read.force_encoding('UTF-8') ).to_html
  haml :article_view
end

get '/research' do
  @content = RDiscount.new( File.open("markdown/research.md").read.force_encoding('UTF-8') ).to_html
  haml :research_view
end

get '/articles' do
  @dir = Dir['content/*.md'].sort.reverse
  @articles = @dir.map { |c| c.split('/').reverse.first }
  haml :articles
end

get '/gallery' do
  haml :gallery
end