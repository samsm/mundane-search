require_relative 'minitest_helper'

describe MundaneSearch::Result do

  # Isolate this more.
  let(:result) { MundaneSearch::Result.new(collection, params) }

  it "should show collection" do
    result.to_a.must_equal collection
  end

  it "should be iterateable" do
    def result.call ; collection ; end
    result.first.must_equal collection.first
    result.count.must_equal collection.count
  end

  describe "param_key accessors" do
    # whoa that's too much setup
    let(:initial) { MundaneSearch::InitialStack.new(collection, params) }
    let(:stack)   { MundaneSearch::Stack.new(initial, filter_canister) }

    let(:filter_canister) do
      fc = Object.new
      fc.stubs(:build).returns(filter)
      fc
    end

    let(:filter) do
      filter = MiniTest::Mock.new
      def filter.call      ; [%w(foo bar baz), { 'foo' => 'bar' }] ; end
      def filter.param_key ; :foo ; end
      filter
    end
    it "should create accessors for params_keys" do
      result.expects(:stack).returns(stack)
      result.foo.must_equal 'bar'
    end
  end
end
