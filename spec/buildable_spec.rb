require_relative 'minitest_helper'

describe MundaneSearch::Buildable do
  let(:built) do
    Class.new do
      include MundaneSearch::Buildable
    end
  end

  it "should have a search builder object" do
    built.builder.must_be_kind_of MundaneSearch::Builder
  end

  it "should add proxy methods" do
    [:use, :result_for, :call, :employ].each do |method|
      built.must_respond_to method
    end
  end
end