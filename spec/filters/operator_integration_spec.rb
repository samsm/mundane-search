require_relative '../minitest_helper'
require_relative '../active_record_setup'

describe MundaneSearch::Filters::Operator do
  before do
    DatabaseCleaner.clean
    populate_books!
  end

  let(:all_books) { Book.scoped }
  let(:a_tale_of_two_cities) { Book.first }

  it "should match based on key" do
    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::Operator, { key: 'sold', operator: :> }
    end

    built.call(all_books, {"sold" => 199_999_999}).must_equal([a_tale_of_two_cities])
  end
end
