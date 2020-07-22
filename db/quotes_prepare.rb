file_name = File.join(File.dirname(__FILE__), 'quotes.txt')
abort "Отсутствует файл #{file_name} с Цитатами" unless File.exists?(file_name)

file_name_rb = File.join(File.dirname(__FILE__), 'quotes.rb')
File.delete(file_name_rb) if File.exists?(file_name_rb)

File.readlines(file_name).map do |line|
  quote = line.split('|').map(&:strip)
  text = quote[1]
  author = quote[2]
  author_name = author.split(',').first
  puts author unless author.start_with?(author_name)
  [text, author_name]
end.map do |q|
  File.write(file_name_rb, "add(text: '#{q[0]}', author: '#{q[1]}')\n", mode: 'a')
end
puts "Quotes - #{file_name_rb} created"
