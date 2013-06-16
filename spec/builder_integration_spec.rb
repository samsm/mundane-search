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
    built.use MundaneSearch::Filters::ExactMatch, key: "foo"
    built.call(collection, params).must_equal(['bar'])
  end

  it "should translate symbols into MundaneSearch::Filter class (if available)" do
    built.use :exact_match, key: "foo"
    built.call(collection, params).must_equal(['bar'])
  end

  it "should translate strings into MundaneSearch::Filter class (if available)" do
    built.use "exact_match", key: "foo"
    built.call(collection, params).must_equal(['bar'])
  end

  it "should looks for Object:: level filters when translating strings" do
    Object.const_set :MockFilter, Class.new(MundaneSearch::Filters::ExactMatch)
    built.use :mock_filter, key: "foo"
    built.call(collection, params).must_equal(['bar'])
    Object.send(:remove_const, :MockFilter)
  end
end
