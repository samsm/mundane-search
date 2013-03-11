require_relative 'minitest_helper'

describe "results" do
  let(:collection) { %w(foo bar baz)    }
  let(:params)     { { 'foo' => 'bar' } }
  let(:initial)    { MundaneSearch::InitialResult.new(collection, params) }

  describe MundaneSearch::InitialResult do
    InitialResult = MundaneSearch::InitialResult
    it "should take a collection and params" do
      initial.must_be_kind_of InitialResult
    end
  end

  describe MundaneSearch::Result do
    Result = MundaneSearch::Result

    let(:result) { Result.new(initial, filter) }
    let(:filter) { NothingFilterForTest.new    }

    it "should show collection" do
      result.collection.must_equal collection
    end

    it "should show params" do
      result.params.must_equal params
    end

    it "should be iterateable" do
      result.first.must_equal collection.first
      result.count.must_equal collection.count
    end
  end

end
