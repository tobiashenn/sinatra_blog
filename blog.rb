# encoding: utf-8
require 'sinatra'
require 'haml'
require 'rdiscount'
require 'nokogiri'

# for all markdown files, use post.haml as layout
set :markdown, :layout_engine => :haml, :layout => :layout


get '/' do 
  haml :index
end

get '/content/:id' do
  @content = RDiscount.new( File.open("content/" + params["id"].concat(".md")).read.force_encoding('UTF-8') ).to_html
  haml :article_view
end

get '/blog' do
  @content = Dir['content/*.md'].reverse
  @articles = @content.map { |f| f.split('/').reverse.first}
  haml :articles
end