require_relative '../minitest_helper'
require_relative '../demo_data'

describe MundaneSearch::Filters::Order do
  let(:books)  { open_struct_books }
  let(:a_tale) { books.first }
  let(:order)  { MundaneSearch::Filters::Order }
  it "should order by title" do
    books.reverse!
    filter = order.new(books, {'sort' => "title"}, {param_key: 'sort'})

    filter.filtered_collection.first.must_equal(a_tale)
  end

  describe MundaneSearch::Filters::Order::ActiveRecord do
    let(:order) { MundaneSearch::Filters::Order::ActiveRecord }
    it "should filter with 'where'" do
      collection = Minitest::Mock.new
      params = { 'sort' => "title" }
      result = Object.new

      filter = order.new(collection, params, param_key: 'sort')
      collection.expect(:order, result, ["title ASC"])
      filter.filtered_collection.must_equal(result)
      collection.verify
    end
  end
end
