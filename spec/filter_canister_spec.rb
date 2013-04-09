require_relative 'minitest_helper'

describe MundaneSearch::FilterCanister do
  it "should build filters with options" do
    filter = Minitest::Mock.new
    options = {param_key: 'baz'}
    result = Object.new
    filter.expect(:constants, [])
    filter.expect(:new, result, [collection, params, options])
    filter_canister = MundaneSearch::FilterCanister.new(filter, options)
    filter_canister.build(collection, params).must_equal(result)
    filter.verify
  end

  it "should use subconstant based on class of collection" do
    object_filter = Minitest::Mock.new
    collection, result, options = Object.new, Object.new, Object.new
    object_filter.expect(:new, result, [collection, params, options])

    base_filter = Class.new
    base_filter::Object = object_filter

    filter_canister = MundaneSearch::FilterCanister.new(base_filter, options)
    filter_canister.build(collection, params).must_equal(result)
    object_filter.verify
  end
end