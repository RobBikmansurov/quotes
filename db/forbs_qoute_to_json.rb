# parse quotes from
# https://www.forbes.ru/forbeslife/dosug/262327-na-vse-vremena-100-vdokhnovlyayushchikh-tsitat
# and save them to JSON
#
require 'oga'
require 'open-uri'
require 'json'

url = 'https://www.forbes.ru/forbeslife/dosug/262327-na-vse-vremena-100-vdokhnovlyayushchikh-tsitat'
html = URI.open(url)
page = Oga.parse_html(html)

quotes = []
text = ''
page.css('.article__item p').each_with_index do |item, i|
  if i.even?
    text = item.text.strip
  else
    author = item.css('em').text.strip
    author = item.text.strip if author.empty?
    quote = {}
    quote["text"] = text.scan(/\d?\..(.*)/)[0][0]
    quote["author"] = author
  end
  quotes << quote if i.odd?
end

puts quotes
puts "Считано #{quotes.size} цитат."

fname = File.join(File.dirname(__FILE__ ), 'quotes.json')

File.open(fname, 'w') do |line|
  line.puts "["
  line.puts quotes.join(",\n")
  line.puts "]"
end

