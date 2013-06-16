require_relative 'minitest_helper'

describe MundaneSearch::Filters do
  Filters = MundaneSearch::Filters

  it "should be a module" do
    Filters.must_be_kind_of Module
  end
end
