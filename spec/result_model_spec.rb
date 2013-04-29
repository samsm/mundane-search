require_relative 'minitest_helper'

describe MundaneSearch::ResultModel do
  describe "param_key accessors" do
    #
    # whoa that's too much setup
    #
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
    let(:result) { MundaneSearch::Result.new(collection, params) }
    let(:result_model) { result.to_model }
    it "should create accessors for params_keys" do
      result.expects(:stack).at_least_once.returns(stack)
      result_model.foo.must_equal 'bar'
    end
  end

end
