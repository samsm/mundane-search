require_relative 'minitest_helper'

describe MundaneSearch::InitialResult do
  let(:initial) { MundaneSearch::InitialResult.new(collection, params) }

  it "should take a collection and params" do
    initial.must_be_kind_of MundaneSearch::InitialResult
  end

  it "should always return empty array on filters" do
    initial.all_filters.must_equal []
  end
end
