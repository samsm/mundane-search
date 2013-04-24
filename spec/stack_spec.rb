require_relative 'minitest_helper'

describe MundaneSearch::Stack do

  let(:initial) { MundaneSearch::InitialStack.new(collection, params) }
  let(:result)  { MundaneSearch::Stack.new(initial, filter_canister) }

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

  it "should add canister to create new stack" do
    new_result = result.add(filter_canister)
    new_result.must_be_kind_of result.class
    new_result.wont_equal result
  end

  describe "all filters" do
    it "should list own filter" do
      result = MundaneSearch::Stack.new(initial, filter_canister)
      result.expects(:filter).returns(filter)
      result.all_filters.must_equal [filter]
    end
  end
end
