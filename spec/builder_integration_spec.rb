require_relative 'minitest_helper'

describe MundaneSearch::Builder do
  let(:built) { MundaneSearch::Builder.new }

  it "should return unchanged collection on call" do
    built.call(collection, params).must_equal(collection)
  end

  it "should tollerate nil params (convert to empty hash)" do
    built.call(collection, nil).must_equal(collection)
  end

  it "should limit results using exact match filter" do
    built.use MundaneSearch::Filters::ExactMatch, param_key: "foo"
    built.call(collection, params).must_equal(['bar'])
  end
end
