require_relative '../minitest_helper'
require_relative '../active_record_setup'

describe MundaneSearch::Filters::AttributeMatch do
  before do
    DatabaseCleaner.clean
    populate_books!
  end

  let(:all_books) { Book.scoped }
  let(:a_tale_of_two_cities) { Book.first }

  it "should something" do
    built = Builder.new do
      use MundaneSearch::Filters::AttributeMatch, param_key: "author"
    end

    built.call(all_books, {"author" => "Charles Dickens"}).must_equal([a_tale_of_two_cities])
  end
end
