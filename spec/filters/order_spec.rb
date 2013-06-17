require_relative '../minitest_helper'
require_relative '../demo_data'

describe MundaneSearch::Filters::Order do
  let(:books)  { open_struct_books }
  let(:a_tale) { books.detect {|b| b.title == "A Tale of Two Cities" } }
  let(:order)  { MundaneSearch::Filters::Order }
  it "should order by title" do
    books.reverse!
    filter = order.new(books, {'sort' => "title"}, {key: 'sort'})

    books.first.wont_equal(a_tale)
    filter.filtered_collection.first.must_equal(a_tale)
  end

  it "should order by descending when specified" do
    books << books.shift
    filter = order.new books,
                       {"sort" => "title", "bearing" => "desc"},
                       { key: "sort", direction_key: "bearing" }

    books.first.wont_equal(a_tale)
    filter.filtered_collection.last.must_equal(a_tale)
  end

  it "should force descending when in options" do
    books << books.shift
    filter = order.new books,
                       {"sort" => "title"},
                       { key: "sort", direction: "desc" }

    books.first.wont_equal(a_tale)
    filter.filtered_collection.last.must_equal(a_tale)
  end

  describe MundaneSearch::Filters::Order::ActiveRecord do
    let(:order) { MundaneSearch::Filters::Order::ActiveRecord }
    it "should filter with 'where'" do
      collection = Minitest::Mock.new
      params = { 'sort' => "title" }
      result = Object.new

      filter = order.new(collection, params, key: 'sort')
      collection.expect(:order, result, ["title ASC"])
      filter.filtered_collection.must_equal(result)
      collection.verify
    end
  end
end
