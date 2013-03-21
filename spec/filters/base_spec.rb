require_relative '../minitest_helper'

describe MundaneSearch::Filters::Base do
  let(:base) { MundaneSearch::Filters::Base.new(collection, params) }
  let(:standin) { Object.new }

  describe "#call" do
    it "should equal [filtered_collection, filtered_params]" do
      collection, params = Object.new, Object.new
      base.expects(:filtered_collection).returns(collection)
      base.expects(:filtered_params).returns(params)
      base.call.must_equal [collection, params]
    end
  end

  describe "#apply?" do
    it "should be true" do
      assert base.apply?
    end
  end

  describe "#filtered_collection" do
    it "should contain collection" do
      base.expects(:collection).returns(standin)
      base.filtered_collection.must_equal standin
    end
  end

  describe "#filtered_params" do
    it "should contain params" do
      base.expects(:params).returns(standin)
      base.filtered_params.must_equal standin
    end
  end
end
