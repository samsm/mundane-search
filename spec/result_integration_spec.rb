require_relative 'minitest_helper'

describe MundaneSearch::Result do
  let(:result_class) do
    Class.new(MundaneSearch::Result) do
      use MundaneSearch::Filters::ExactMatch, param_key: "foo"
    end
  end

  let(:result) { result_class.new(collection, params) }

  it "should run search from result class" do
    result.to_a.must_equal ["bar"]
  end

  it "should return result in same class" do
    result.must_be_kind_of result_class
    result.first.must_equal "bar"
  end

  it "should return result model" do
    result.to_model.must_be_kind_of(MundaneSearch::ResultModel)
  end
end
