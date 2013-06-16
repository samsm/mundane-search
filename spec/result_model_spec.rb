require_relative 'minitest_helper'
require 'ostruct'

describe MundaneSearch::ResultModel do
  let(:builder) do
    builder, filter_canister = Object.new, Object.new
    def filter_canister.option_keys_with_types
      [["foo",:date]]
    end
    builder.define_singleton_method :filter_canisters, -> { [filter_canister] }
    builder
  end
  let(:result_class) do
    result_class = OpenStruct.new(builder: builder, options: {})
  end
  let(:model_class) { MundaneSearch::ResultModel.model_class_for(result_class) }
  let(:result_model) { model_class.new(result) }
  let(:result) do
    result = OpenStruct.new
    result.stack = mock_stack
    result
  end
  let(:mock_stack) do
    stack = Object.new
    def stack.params ; { "foo" => "bar" } ; end
    stack
  end

  describe ".model_class_for" do

    it "should create class based on ResultModel" do
      model_class.superclass.must_equal MundaneSearch::ResultModel
    end

    it "should crate class with param_key accessors" do
      model_class.instance_methods.include?(:foo)
    end
  end

  it "should set type to param_key_type" do
    result_model.column_for_attribute("foo").type.must_equal :date
  end

  it "should create accessors for params_keys" do
    result_model.foo.must_equal 'bar'
  end

  it "should not be considered to be persisted" do
    result_model.wont_be :persisted?
  end
end
