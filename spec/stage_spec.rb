require_relative 'minitest_helper'

describe MundaneSearch::Stage do

  let(:initial) { MundaneSearch::InitialStage.new(collection, params) }
  let(:result)  { MundaneSearch::Stage.new(initial, filter_canister) }

  let(:filter) do
    filter = MiniTest::Mock.new
    def filter.call ; [%w(foo bar baz), { 'foo' => 'bar' }] ; end
    filter
  end
  let(:filter_canister) do
    fc = Object.new
    fc.stubs(:build).returns(filter)
    fc
  end

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

  describe "all filters" do
    it "should list own filter" do
      result = MundaneSearch::Stage.new(initial, filter_canister)
      result.expects(:filter).returns(filter)
      result.all_filters.must_equal [filter]
    end

    describe "param_key accessors" do
      let(:filter) do
        filter = MiniTest::Mock.new
        def filter.call      ; [%w(foo bar baz), { 'foo' => 'bar' }] ; end
        def filter.param_key ; :foo ; end
        filter
      end
      it "should create accessors for params_keys" do
        result.foo.must_equal 'bar'
      end
    end
  end
end
