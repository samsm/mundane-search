require_relative 'minitest_helper'

describe MundaneSearch::Filter do
  Filter = MundaneSearch::Filter
  it "should be a class" do
    Filter.must_be_kind_of Class
  end
end