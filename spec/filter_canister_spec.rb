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

  it "should report param_key" do
    param_key = Object.new
    filter_canister = MundaneSearch::FilterCanister.new(nil, param_key: param_key)
    filter_canister.option_keys_with_types.first.first.must_equal param_key
  end

  it "should report param_key_type" do
    param_key_type = Object.new
    filter_canister = MundaneSearch::FilterCanister.new(nil, param_key: :foo, param_key_type: param_key_type)
    filter_canister.option_keys_with_types.must_equal [[:foo, param_key_type]]
  end

  it "should take param_key_type from filter, if not supplied in options" do
    filter = Minitest::Mock.new
    filter.expect(:param_key_types, { param_key: :date })
    filter_canister = MundaneSearch::FilterCanister.new(filter, param_key: :foo)
    # filter_canister.param_key_type.must_equal :date
    filter_canister.option_keys_with_types.must_equal [[:foo, :date]]
  end
end
