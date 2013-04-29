require_relative '../minitest_helper'
require_relative '../demo_data'

describe MundaneSearch::Filters::AttributeSubstring do
  let(:books)  { open_struct_books }
  let(:a_tale) { books.first }
  it "should match param key" do
    am = MundaneSearch::Filters::AttributeSubstring
    filter = am.new(books, {'title' => "Tale of Two"}, {param_key: 'title'})

    filter.filtered_collection.must_equal([a_tale])
  end

  describe MundaneSearch::Filters::AttributeSubstring::ActiveRecord do
    let(:am) { MundaneSearch::Filters::AttributeSubstring::ActiveRecord }
    it "should filter with 'where'" do
      collection = Minitest::Mock.new
      params = { 'title' => "Tale of Two" }
      result = Object.new

      filter = am.new(collection, params, param_key: 'title')
      collection.expect(:where, result, [["title LIKE ?", "%Tale of Two%"]])
      filter.filtered_collection.must_equal(result)
      collection.verify
    end
  end
end
