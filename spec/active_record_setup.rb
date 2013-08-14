require 'rubygems'
require 'active_record'
require 'fileutils'

FileUtils.mkdir_p "./tmp"
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'tmp/test.db'
)

require 'database_cleaner'
# Changed from :truncation due to https://github.com/bmabey/database_cleaner/pull/209
DatabaseCleaner.strategy = :deletion

class Book < ActiveRecord::Base
  # t.string    :title
  # t.string    :author
  # t.date      :publication_date
  # t.timestamp :first_purchased_at
  # t.integer   :sold
end

require_relative 'demo_data'
def populate_books!
  demo_data.each do |book_hash|
    Book.create(book_hash)
  end
end

begin
  Book.new
rescue ActiveRecord::StatementInvalid
  puts ''
  puts "*****************************************************************"
  puts "Run: rake database:test_setup to create a database for this test."
  puts "*****************************************************************"
  puts ''
end