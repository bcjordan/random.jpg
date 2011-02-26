require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'rexml/document'
require 'pp'

get '/' do
  "Hello from Sinatra on Heroku!"
end

get '/random.jpg' do
  content_type :jpg
  file = open("#{get_photo_id}")
  file.read
end

def get_photo_id
  url = "http://api.flickr.com/services/feeds/photos_public.gne"
  file = open(url)
  xml_data = file.read

  doc = REXML::Document.new(xml_data)
  photo_urls = []

  doc.elements.each("*/entry/link") do |link_tag|
    if link_tag.attributes["href"][-1..-1] == 'g'
      photo_urls << link_tag.attributes["href"]
    end
  end

  photo_urls.shuffle[0]
end
