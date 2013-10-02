require_relative '../minitest_helper'
require_relative '../active_record_setup'

describe MundaneSearch::Filters::Order do
  before do
    DatabaseCleaner.clean
    populate_books!
  end

  let(:all_books) { scoped_search_for_active_record_model(Book) }
  let(:a_tale_of_two_cities) { Book.first }

  it "should order based on key" do
    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::Order, key: "sort"
    end

    dates = built.call(all_books, {"sort" => "publication_date"})
    dates.inject do |last, current|
      last.publication_date.must_be :<, current.publication_date if last
      current
    end
  end

  it "should order desc if desired" do
    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::Order, key: "sort", direction_key: "bearing"
    end

    dates = built.call(all_books, {"sort" => "publication_date", "bearing" => "desc"})
    dates.inject do |last, current|
      last.publication_date.must_be :>, current.publication_date if last
      current
    end
  end
end
