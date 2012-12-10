require_relative 'minitest_helper'

describe MundaneSearch::Filter do
  Filter = MundaneSearch::Filter
  it "should be a class" do
    Filter.must_be_kind_of Class
  end

  it "should reject bad options" do
    proc {
      Filter.new(invalid_option: 1)
    }.must_raise(MundaneSearch::InvalidOption)
  end

  it "should filter with proc" do
    proc = ->(scope, params) { scope.select {|s| s > 2 } }
    filter = Filter.new(search_method: proc)
    filter.apply_to([1,2,3,4,5]).must_equal([3,4,5])
  end

end