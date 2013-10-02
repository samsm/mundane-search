require_relative '../minitest_helper'
require_relative '../active_record_setup'

describe MundaneSearch::Filters::AttributeMatch do
  before do
    DatabaseCleaner.clean
    populate_books!
  end

  let(:all_books) { scoped_search_for_active_record_model(Book) }
  let(:a_tale_of_two_cities) { Book.first }

  it "should match based on key" do
    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::AttributeMatch, key: "author"
    end

    built.call(all_books, {"author" => "Charles Dickens"}).must_equal([a_tale_of_two_cities])
  end
end
