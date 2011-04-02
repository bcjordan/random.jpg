require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'rexml/document'
require 'pp'

get '/' do
  "The source code for #{deploy_url} can be accessed on #{github_link}<br/>" +
                                                    "By Brian Jordan"
end

get '/random_pin.png' do
  redirect  "#{get_pin_url}"

get '/random.jpg' do
  redirect "#{get_photo_id}"

#  To download, instead:  
#  content_type :jpg
#  file = open("#{get_photo_id}")
#  file.read
end

def get_pin_url
  url = "http://chart.googleapis.com/chart?chst=d_map_xpin_letter&chld=pin|+|#{"%06x" % (rand * 0xffffff)}|000000|FF0000"
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

def github_link
  '<a href="https://github.com/bcjordan/random.jpg">github</a>'
end

def deploy_url
  '<a href="http://randomimage.heroku.com/random.jpg">random.jpg</a>'
end
