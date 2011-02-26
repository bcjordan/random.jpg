require 'rubygems'
require 'sinatra'
require 'open-uri'

get '/' do
  "Hello from Sinatra on Heroku!"
end

get '/random.jpg' do
  content_type :jpg
  file = open('http://farm1.static.flickr.com/197/503637906_eaa3df22f4_o.jpg')
  file.read
end

