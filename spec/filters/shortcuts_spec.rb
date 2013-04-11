require_relative '../minitest_helper'

describe MundaneSearch::Filters::Shortcuts do
  let(:shortcutted) do
    shortcutted = Object.new
    shortcutted.extend(MundaneSearch::Filters::Shortcuts)
    shortcutted
  end

  # urg
  it "should compose a filter with employ" do
    shortcutted.expects(:use)
    shortcutted.employ :attribute_filter
  end
end
