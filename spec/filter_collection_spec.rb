require_relative 'minitest_helper'

describe MundaneSearch::FilterCollection do
  FilterCollection = MundaneSearch::FilterCollection

  let(:filter) { mock_filter([1,2], [collection,params]) }
  let(:params) { Hash.new }
  let(:filter_method) { ->(c,p) { c.pop ; c } }
  let(:collection)    { [1,2,3] }
  let(:params) { Hash.new }

  def mock_filter(returns, args)
    MiniTest::Mock.new.expect(:apply_to, returns, args)
  end

  it "should use filter" do
    fc = FilterCollection.new([filter])
    fc.execute(collection, params).must_equal [1,2]
  end

  it "should use multiple filters" do
    filter2 = mock_filter([1], [[1,2], params])
    fc = FilterCollection.new([filter, filter2])
    fc.execute(collection, params).must_equal [1]
  end

end
