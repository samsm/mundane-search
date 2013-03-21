require_relative 'minitest_helper'

describe MundaneSearch::FilterCanister do
  it "should build filters with options" do
    filter = Minitest::Mock.new
    options = {param_key: 'baz'}
    result = Object.new
    filter.expect(:new, result, [collection, params, options])
    filter_canister = MundaneSearch::FilterCanister.new(filter, options)
    filter_canister.build(collection, params).must_equal(result)
    filter.verify
  end
end