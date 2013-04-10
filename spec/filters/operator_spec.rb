require_relative '../minitest_helper'
require_relative '../demo_data'

describe MundaneSearch::Filters::Operator do
  let(:books)  { open_struct_books }
  let(:a_tale) { books.first }

  it "should match param key" do
    o = MundaneSearch::Filters::Operator
    filter = o.new(books, {'sold' => 199_999_999}, { param_key: 'sold', operator: :> })

    filter.filtered_collection.must_equal([a_tale])
  end

  describe MundaneSearch::Filters::Operator::ActiveRecord do
    let(:o) { MundaneSearch::Filters::Operator::ActiveRecord }
    it "should filter with 'where'" do
      collection = Minitest::Mock.new
      params = { 'sold' => 199_999_999 }
      result = Object.new

      filter = o.new(collection, params, { param_key: 'sold', operator: :> })
      collection.expect(:where, result, [["sold > ?", 199_999_999]])
      filter.filtered_collection.must_equal(result)
      collection.verify
    end
  end
end
