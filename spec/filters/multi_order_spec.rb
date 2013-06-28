require_relative '../minitest_helper'
require_relative '../demo_data'

describe MundaneSearch::Filters::MultiOrder do
  let(:books)  { open_struct_books }
  let(:a_tale) { books.detect {|b| b.title == "A Tale of Two Cities" } }
  let(:multi_order)  { MundaneSearch::Filters::MultiOrder }

  it "should order by two attributes (compact syntax)" do
    filter = multi_order.new(books, {"sort" => "sold;author:desc"}, {key:"sort"})
    sorted = filter.filtered_collection
    sorted.inject do |last, current|
      if last
        last.author.must_be :>, current.author if last.sold == current.sold
      end
      current
    end
  end

  it "should order by two attributes (array syntax)" do
    filter = multi_order.new books,
                             {"sort" => ["sold","author"], "direction" => ["asc", "desc"]},
                             { key:"sort", directions_key:"direction" }
    sorted = filter.filtered_collection
    sorted.inject do |last, current|
      if last
        last.author.must_be :>, current.author if last.sold == current.sold
      end
      current
    end
  end

  describe MundaneSearch::Filters::MultiOrder::ActiveRecord do
    let(:order) { MundaneSearch::Filters::MultiOrder::ActiveRecord }
    it "should filter with 'order'" do
      collection = Minitest::Mock.new
      params = { 'sort' => "sold;author:desc" }
      result = Object.new

      filter = order.new(collection, params, key: 'sort')
      collection.expect(:order, result, ["sold asc, author desc"])
      filter.filtered_collection.must_equal(result)
      collection.verify
    end
  end
end
