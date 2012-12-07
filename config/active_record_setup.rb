require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'test.db'
)

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

class Book < ActiveRecord::Base
  # t.string    :title
  # t.string    :author
  # t.date      :publication_date
  # t.timestamp :first_purchased_at
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
