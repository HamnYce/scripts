# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

def get_links(link)
  url = URI(link.chomp)
  html = url.read
  parsed_html = Nokogiri.parse(html)

  a_tags = parsed_html.css('a')

  links = a_tags.map { |tag| tag.attributes.to_h["href"] }


  File.open("parsed_links/#{url.hostname.split('.')[0..1].join('_')}.txt",'w') { |file|
    file.puts links
  }
rescue
  puts "error with #{link}"
end

choice = ""

unless choice == 'w' || choice == 'f'
  puts "enter w to enter webpage link or f to enter file path to take links from.\n(e to exit)"
  choice = gets.chomp
end

`mkdir parsed_links`

if choice == 'w'
  puts 'please enter webpage link to scrape from (including the https)'
  url = URI(gets.chomp)
  get_links(url)
elsif choice == 'f'
  puts 'please enter the file path containing urls (from current directory)'
  path = gets.chomp
  links_file = File.open(path)

  links_file.readlines.each do |url|
    get_links(url)
  end
end

puts 'thank you for using my program, checks for a parsed_links folder ^^'






