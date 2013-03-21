require_relative 'minitest_helper'

describe MundaneSearch::Buildable do
  let(:built) do
    Class.new do
      include MundaneSearch::Buildable
    end
  end

  it "should limit results using exact match filter" do

    built.use MundaneSearch::Filters::ExactMatch, param_key: "foo"
    built.builder.result_class = MundaneSearch::Result

    built.call(collection, params).must_equal(['bar'])
  end
end