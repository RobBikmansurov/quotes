# Обработка текстового файла с авторами
# подготовка ссылок на wikipedia.ru
# создание скрипта для загоузки авторов в БД
#
require 'open-uri'
require 'oga'

file_name = File.join(File.dirname(__FILE__), 'authors.txt')
abort "Отсутствует файл #{file_name} с Авторами" unless File.exists?(file_name)

file_name_rb = File.join(File.dirname(__FILE__), 'authors.rb')
File.delete(file_name_rb) if File.exists?(file_name_rb)

File.readlines(file_name).map do |line|
  author = line.split('|').map(&:strip)
  name = author[1]
  note = author[2] if author.size > 2
  url = "https://ru.wikipedia.org/wiki/#{name.tr(' ', '_')}"
  puts name
  # uri = URI.parse(URI::encode(url))
  begin
    html = URI.open(URI::encode(url))
  rescue Exception => e
    puts name, url
    puts e.message
    html = ''
  end
  document = Oga.parse_html(html)
  link = ''
  document.css('.infobox').map do |item|
    link = item.css('img')
  end
  if link.nil?
    link = ''
  else
    begin
      link = link.first.attribute('src').text unless link.nil?
      link['thumb/'] = '' # remove 'thumb/' from
      l = link.split('/')
      l.pop
      link = 'https:' + l.join('/')
    rescue Exception => e
      puts name, url
      puts e.message
      link = ''
    end
  end

  File.write(file_name_rb, "Author.create(name: '#{name}', note: '#{note}', link: '#{link}')\n", mode: 'a')
end
