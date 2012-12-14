require_relative 'minitest_helper'

describe MundaneSearch::FilterCollection do
  FilterCollection = MundaneSearch::FilterCollection

  let(:filter) {
    MiniTest::Mock.new.expect(:apply_to, [1,2], [collection,params]) }
  let(:params) { Hash.new }
  let(:filter_method) { ->(c,p) { c.pop ; c } }
  let(:collection)    { [1,2,3] }
  let(:params) { Hash.new }

  it "should use dummy filter" do
    fc = FilterCollection.new([filter])
    fc.execute(collection, params)
  end

end
