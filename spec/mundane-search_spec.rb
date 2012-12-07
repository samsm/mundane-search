require_relative 'minitest_helper'

describe MundaneSearch do
  it "should be a module" do
    MundaneSearch.must_be_kind_of Module
  end
end