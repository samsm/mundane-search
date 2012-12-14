require_relative 'minitest_helper'

describe MundaneSearch::Filter do
  Collection = MundaneSearch::Collection

  it "should be a class" do
    Collection.must_be_kind_of Class
  end

  let(:dummy_filter) { ->(c,p) { c.pop ; c } }

  it "should use dummy filter" do
    coll = [1,2,3]
    dummy_filter.call(coll,{}).must_equal [1,2]
  end

end
