require_relative 'minitest_helper'

describe MundaneSearch::Builder do
  Builder = MundaneSearch::Builder

  it "should limit results using exact match filter" do

    built = Builder.new do
      use MundaneSearch::Filters::ExactMatch, param_key: "foo"
    end

    built.call(collection, params).must_equal(['bar'])
  end
end