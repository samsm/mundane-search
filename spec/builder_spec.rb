require_relative 'minitest_helper'

describe MundaneSearch::Builder do
  Builder = MundaneSearch::Builder

  let(:collection) { %w(foo bar baz)    }
  let(:params)     { { 'foo' => 'bar' } }

  describe "empty search" do
    let(:builder) { Builder.new }

    it "should return unchanged collection on call" do
      result_collection, result_params = builder.call(collection, params)
      result_collection.must_equal collection
    end

    it "should return unchanged params on call" do
      result_collection, result_params = builder.call(collection, params)
      result_params.must_equal params
    end
  end

  it "should use middleware" do
    builder = Builder.new do
      use NothingFilterForTest
    end
    canister = builder.filters.first
    canister.must_be_kind_of MundaneSearch::FilterCanister
    canister.filter.must_equal NothingFilterForTest
  end
end