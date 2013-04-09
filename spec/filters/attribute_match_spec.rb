require_relative '../minitest_helper'
require 'ostruct'
require_relative '../demo_data'

describe MundaneSearch::Filters::AttributeMatch do
  let(:books)  { open_struct_books }
  let(:a_tale) { books.first }
  it "should match param key" do
    am = MundaneSearch::Filters::AttributeMatch
    filter = am.new(books, {'title' => "A Tale of Two Cities"}, {param_key: 'title'})

    filter.filtered_collection.must_equal([a_tale])
  end

  describe MundaneSearch::Filters::AttributeMatch::ActiveRecord do
    let(:am) { MundaneSearch::Filters::AttributeMatch::ActiveRecord }
    it "should filter with 'where'" do
      collection = Minitest::Mock.new
      params = { 'title' => "A Tale of Two Cities" }
      result = Object.new

      filter = am.new(collection, params, param_key: 'title')
      collection.expect(:where, result, [params])
      filter.filtered_collection.must_equal(result)
      collection.verify
    end
  end
end
