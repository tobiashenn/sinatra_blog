# encoding: utf-8
require 'sinatra'
require 'haml'
require 'rdiscount'
require 'nokogiri'

# new relic monitoring...
configure :production do
  require 'newrelic_rpm'
end

# for all markdown files, use post.haml as layout
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

get '/blog' do
  @dir = Dir['content/*.md'].sort.reverse
  @articles = @dir.map { |c| c.split('/').reverse.first}
  @titles = Array.new
  haml :articles
end