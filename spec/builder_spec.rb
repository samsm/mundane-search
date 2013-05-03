require_relative 'minitest_helper'

describe MundaneSearch::Builder do
  let(:built)  { MundaneSearch::Builder.new }
  let(:null_filter) { Object.new }
  let(:canister) { Minitest::Mock.new }

  # what does a builder actually do?
  # 1. Store search configuration (use, result_class, filter_canister)
  #   a. Can "use" (et al) be called?
  #     i. use can be verified
  # 2. Run search (call, result_for)
  #   a. ... by creating a result object

  it "should use middleware" do
    expectation = ->(filter, *args) { filter.must_equal null_filter }
    built.define_singleton_method :build_filter_canister, ->{ expectation }
    built.use(null_filter)
  end
end
