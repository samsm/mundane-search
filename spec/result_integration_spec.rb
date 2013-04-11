require_relative 'minitest_helper'

describe "integration results" do

  describe MundaneSearch::Stage do
    let(:result_class) do
      Class.new(MundaneSearch::Stage) do
        use MundaneSearch::Filters::ExactMatch, param_key: "foo"
      end
    end

    it "should run search from result class" do
      result_class.call(collection, params).must_equal ["bar"]
    end

    it "should return result in same class" do
      result = result_class.result_for(collection, params)
      result.must_be_kind_of result_class
      result.first.must_equal "bar"
    end

  end
end