require_relative '../minitest_helper'
require_relative '../active_record_setup'

describe MundaneSearch::Filters::MultiOrder do
  before do
    DatabaseCleaner.clean
    populate_books!
  end

  let(:all_books) { Book.scoped }
  let(:a_tale_of_two_cities) { Book.where(title: "A Tale of Two Cities").first }

  it "should order by two attributes (compact syntax)" do
    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::MultiOrder, key: "sort"
    end

    sorted = built.call(all_books, {"sort" => "sold;author:desc"})
    sorted.inject do |last, current|
      if last
        last.author.must_be :>, current.author if last.sold == current.sold
      end
      current
    end
  end

  it "should order by two attributes (array syntax)" do
    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::MultiOrder, key: "sort", directions_key:"direction"
    end

    sorted = built.call all_books,
                        {"sort" => ["sold","author"], "direction" => ["asc", "desc"]}
    sorted.inject do |last, current|
      if last
        last.author.must_be :>, current.author if last.sold == current.sold
      end
      current
    end
  end

end
