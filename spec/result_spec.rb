require_relative 'minitest_helper'

describe MundaneSearch::Result do

  # Isolate this more.
  let(:result) { MundaneSearch::Result.new(collection, params) }

  it "should show collection" do
    result.to_a.must_equal collection
  end

  it "should be iterateable" do
    def result.call ; collection ; end
    result.first.must_equal collection.first
    result.count.must_equal collection.count
  end
end
