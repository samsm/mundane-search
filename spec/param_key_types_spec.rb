require_relative 'minitest_helper'

describe MundaneSearch::ParamKeyTypes do

  let(:options) { { key: "sort", type: :date, precedence_key: "sort-precedence", precedence_type: :string } }
  let(:filter)  { Object.new }

  def pkt(options, filter)
    MundaneSearch::ParamKeyTypes.new(options, filter)
  end

  it "should find main key" do
    keys = pkt(options, filter).pairs.collect(&:first)
    keys.must_include "sort"
  end

  it "should find additional key" do
    keys = pkt(options, filter).pairs.collect(&:first)
    keys.must_include "sort-precedence"
  end

  it "should find correct type of main key" do
    pkt(options, filter).pairs["sort"].must_equal :date
  end

  it "should find correct type of main key" do
    pkt(options, filter).pairs["sort-precedence"].must_equal :string
  end
end