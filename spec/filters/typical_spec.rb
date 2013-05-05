require_relative '../minitest_helper'

describe MundaneSearch::Filters::Typical do
  # let(:typical) { MundaneSearch::Filters::Typical.new(collection, params) }
  let(:standin) { Object.new }
  def typical(options = {})
    MundaneSearch::Filters::Typical.new(collection, params, options)
  end

  describe "#target" do
    it "should use options[:target]" do
      typical(target: "foo").target.must_equal "foo"
    end

    it "should default to param_key" do
      typical(param_key: "foo").target.must_equal "foo"
    end
  end

  describe "#optional?" do
    it "should use options[:required]" do
      typical(required: true).must_be :optional?
    end

    it "should default to optional" do
      typical.wont_be :optional?
    end
  end

  describe "#apply?" do
    it "should be true if there is a match_value" do
      filter = typical
      def filter.match_value ; true ; end
      assert filter.apply?
    end

    it "should be true if the filter isn't optional" do
      filter = typical
      def filter.match_value ; false ; end
      def filter.optional?   ; true  ; end
      assert filter.apply?
    end
  end

  describe "#param_key" do
    it "should take param_key from options" do
      param_key = Object.new
      typical(param_key: param_key).param_key.must_equal param_key
    end
  end

  describe "#match_value" do
    it "should return param value matching param_key" do
      typical(param_key: "foo").match_value.must_equal "bar"
    end

    it "should use explicit match value when supplied" do
      typical(match_value: "foo").match_value.must_equal "foo"
    end
  end

  describe "#param_key_type" do
    it "should default to :string" do
      typical.param_key_type.must_equal :string
    end

    it "should use options[:type]" do
      type = Object.new
      typical(type: type).param_key_type.must_equal type
    end
  end
end
