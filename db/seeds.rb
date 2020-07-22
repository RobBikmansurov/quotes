Author.destroy_all
Quote.destroy_all

require_relative 'authors' # create Authors

def add(text:, author:)
  puts author
  author_id = Author.find_by(name: author).id
  Quote.create(text: text, author_name: author, author_id: author_id)
end

require_relative 'quotes' # create Quotes