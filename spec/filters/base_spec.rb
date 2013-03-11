require_relative '../minitest_helper'

describe MundaneSearch::Filters::Base do
  Base = MundaneSearch::Filters::Base

  let(:collection) { %w(foo bar baz)    }
  let(:params)     { { 'foo' => 'bar' } }

  it "should pass through" do
    base = Base.new
    base.call(collection, params).must_equal [collection, params]
  end
end