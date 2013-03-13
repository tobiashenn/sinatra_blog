require 'sinatra'
require 'thin'
require 'haml'
require 'rdiscount'
require 'nokogiri'

# new relic monitoring...
configure :production do
  require 'newrelic_rpm'
end

puts "Ruby Version: " + RUBY_VERSION

set :markdown, :layout_engine => :haml, :layout => :layout


get '/' do 
  haml :index
end

get '/contact' do
  haml :contact
end

get '/content/:id' do
  @created_at = params["id"]
  @content = RDiscount.new( File.open("content/" + params["id"].concat(".md")).read.force_encoding('UTF-8') ).to_html
  haml :article_view
end

get '/research' do
  @created_at = params["id"]
  @content = RDiscount.new( File.open("markdown/research.md").read.force_encoding('UTF-8') ).to_html
  haml :research_view
end

get '/blog' do
  @dir = Dir['content/*.md'].sort.reverse
  @articles = @dir.map { |c| c.split('/').reverse.first}
  @titles = Array.new
  haml :articles
end

get '/gallery' do
  haml :gallery
end