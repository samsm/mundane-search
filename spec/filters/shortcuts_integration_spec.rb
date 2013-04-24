require_relative '../minitest_helper'
require_relative '../demo_data'

describe MundaneSearch::Filters::Shortcuts do

  let(:all_books) { open_struct_books }
  let(:a_tale_of_two_cities) { all_books.first }

  it "should match based on param_key" do
    built = MundaneSearch::Builder.new do
      employ :attribute_filter, param_key: 'title'
    end

    built.call(all_books, {"title" => "A Tale of Two Cities"}).must_equal([a_tale_of_two_cities])
  end
end
