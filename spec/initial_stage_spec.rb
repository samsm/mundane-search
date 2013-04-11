require_relative 'minitest_helper'

describe MundaneSearch::InitialStage do
  let(:initial) { MundaneSearch::InitialStage.new(collection, params) }

  it "should take a collection and params" do
    initial.must_be_kind_of MundaneSearch::InitialStage
  end

  it "should always return empty array on filters" do
    initial.all_filters.must_equal []
  end
end
