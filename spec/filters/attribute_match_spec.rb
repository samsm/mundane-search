require_relative '../minitest_helper'
require 'ostruct'
require_relative '../demo_data'

# This is an integration-y test right now.
# Should be more unit-y once there's a strategy for collection types.
require 'active_record'

describe MundaneSearch::Filters::AttributeMatch do
  let(:books)  { open_struct_books }
  let(:a_tale) { books.first }
  it "should match param key" do
    am = MundaneSearch::Filters::AttributeMatch
    filter = am.new(books, {'title' => "A Tale of Two Cities"}, {param_key: 'title'})

    filter.filtered_collection.must_equal([a_tale])
  end
end
